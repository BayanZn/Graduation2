import { usePage } from '@inertiajs/vue3';
import axios from 'axios';
import { computed, onUnmounted, ref, watch } from 'vue';

export function useChat(projectId = null) {
    const page = usePage();
    const currentUser = computed(() => page.props.auth?.user);

    const conversations = ref([]);
    const activeConversation = ref(null);
    const messages = ref([]);
    const loading = ref(false);
    const sending = ref(false);
    const onlineUsers = ref([]);

    let echoChannel = null;
    let activeChannelName = null;
    const listChannelSubscriptions = new Map();

    /**
     * Load all conversations for the user
     */
    const loadConversations = async () => {
        loading.value = true;
        try {
            unsubscribeFromConversationListChannels();
            const response = await axios.get('/chat/conversations');
            conversations.value = response.data.conversations;
            subscribeToConversationListChannels();
        } catch (error) {
            console.error('Failed to load conversations:', error);
        } finally {
            loading.value = false;
        }
    };

    /**
     * Load a specific conversation with messages
     */
    const normalizeMessage = (message) => ({
        id: message.id,
        conversation_id: message.conversation_id,
        sender_id: message.sender_id,
        sender: message.sender ?? null,
        message: message.message,
        type: message.type,
        created_at: message.created_at ?? new Date().toISOString(),
    });

    const sortMessages = () => {
        const toTimestamp = (value) => {
            if (!value) {
                return 0;
            }

            const time = new Date(value).getTime();
            return Number.isNaN(time) ? 0 : time;
        };

        messages.value = [...messages.value].sort((a, b) => {
            return toTimestamp(a.created_at) - toTimestamp(b.created_at);
        });
    };

    const upsertMessage = (incoming) => {
        const normalized = normalizeMessage(incoming);
        const id = String(normalized.id);

        const existingIndex = messages.value.findIndex((message) => String(message.id) === id);

        if (existingIndex !== -1) {
            messages.value[existingIndex] = normalized;
            messages.value = [...messages.value];
        } else {
            messages.value.push(normalized);
            sortMessages();
        }
    };

    const loadConversation = async (conversationId) => {
        loading.value = true;
        try {
            // Unsubscribe from real-time updates first to prevent interference during loading
            unsubscribeFromConversation();

            const response = await axios.get(`/chat/conversations/${conversationId}`);
            activeConversation.value = response.data.conversation;

            // Load all messages at once
            messages.value = (response.data.messages || []).map(normalizeMessage);
            sortMessages();

            // Subscribe to real-time updates after loading is complete
            subscribeToConversation();

            // Mark as read
            await markAsRead(conversationId);

            // Update unread count in conversations list
            const conv = conversations.value.find((c) => c.id === conversationId);
            if (conv) {
                conv.unread_count = 0;
            }
        } catch (error) {
            console.error('Failed to load conversation:', error);
        } finally {
            loading.value = false;
        }
    };

    /**
     * Create a project group conversation
     */
    const createProjectChat = async (projectId) => {
        loading.value = true;
        try {
            const response = await axios.post(`/chat/projects/${projectId}/chat`);
            await loadConversations();
            subscribeToConversationListChannels();
            return response.data.conversation;
        } catch (error) {
            console.error('Failed to create chat:', error);
            return null;
        } finally {
            loading.value = false;
        }
    };

    /**
     * Get or create admin support conversation
     */
    const contactAdminSupport = async () => {
        loading.value = true;
        try {
            const response = await axios.post('/chat/admin-support');
            const conversation = response.data.conversation;

            await loadConversations();
            await loadConversation(conversation.id);

            return conversation;
        } catch (error) {
            console.error('Failed to contact admin:', error);
            return null;
        } finally {
            loading.value = false;
        }
    };

    /**
     * Send a message
     */
    const sendMessage = async (messageText) => {
        if (!messageText.trim() || !activeConversation.value) return;

        sending.value = true;
        try {
            const response = await axios.post(`/chat/conversations/${activeConversation.value.id}/messages`, {
                message: messageText,
                type: 'text',
            });

            const savedMessage = response.data.message;

            if (savedMessage) {
                upsertMessage(savedMessage);
                updateConversationInList(savedMessage);
            }

            return savedMessage;
        } catch (error) {
            console.error('Failed to send message:', error);
            return null;
        } finally {
            sending.value = false;
        }
    };

    /**
     * Mark conversation as read
     */
    const markAsRead = async (conversationId) => {
        try {
            await axios.post(`/chat/conversations/${conversationId}/mark-as-read`);
        } catch (error) {
            console.error('Failed to mark as read:', error);
        }
    };

    /**
     * Load more messages (pagination)
     */
    const loadMoreMessages = async () => {
        if (!activeConversation.value || messages.value.length === 0) return;

        const oldestMessageId = messages.value[0]?.id;
        if (!oldestMessageId) return;

        try {
            const response = await axios.get(`/chat/conversations/${activeConversation.value.id}/load-more`, {
                params: { before_message_id: oldestMessageId },
            });

            if (response.data.messages.length > 0) {
                const olderMessages = response.data.messages.map(normalizeMessage);
                messages.value = [...olderMessages, ...messages.value];
                sortMessages();
            }
        } catch (error) {
            console.error('Failed to load more messages:', error);
        }
    };

    /**
     * Subscribe to conversation channel for real-time updates
     */
    const subscribeToConversation = () => {
        if (!activeConversation.value || !window.Echo) {
            return;
        }

        let channelName;
        if (activeConversation.value.type === 'project_group') {
            channelName = `project-chat.${activeConversation.value.project_id}`;
        } else if (activeConversation.value.type === 'admin_support') {
            channelName = `admin-support.${activeConversation.value.id}`;
        } else {
            channelName = `conversation.${activeConversation.value.id}`;
        }

        if (activeChannelName === channelName) {
            return;
        }

        unsubscribeFromConversation();

        echoChannel = window.Echo.private(channelName).listen('.MessageSent', (payload) => {
            if (!payload) {
                return;
            }

            upsertMessage(payload);
            updateConversationInList(payload);
        });

        activeChannelName = channelName;
    };

    /**
     * Unsubscribe from conversation channel
     */
    const unsubscribeFromConversation = () => {
        if (activeChannelName) {
            window.Echo.leave(activeChannelName);
            activeChannelName = null;
            echoChannel = null;
        }
    };

    function subscribeToConversationListChannels() {
        if (!window.Echo) {
            return;
        }

        conversations.value.forEach((conversation) => {
            let channelName;
            if (conversation.type === 'project_group') {
                channelName = `project-chat.${conversation.project_id}`;
            } else if (conversation.type === 'admin_support') {
                channelName = `admin-support.${conversation.id}`;
            } else {
                channelName = `conversation.${conversation.id}`;
            }

            // Skip if this is the currently active conversation's channel
            let currentActiveChannelName = null;
            if (activeConversation.value) {
                if (activeConversation.value.type === 'project_group') {
                    currentActiveChannelName = `project-chat.${activeConversation.value.project_id}`;
                } else if (activeConversation.value.type === 'admin_support') {
                    currentActiveChannelName = `admin-support.${activeConversation.value.id}`;
                } else {
                    currentActiveChannelName = `conversation.${activeConversation.value.id}`;
                }
            }

            if (channelName === currentActiveChannelName) {
                return;
            }

            if (listChannelSubscriptions.has(channelName)) {
                return;
            }

            const subscription = window.Echo.private(channelName).listen('.MessageSent', (payload) => {
                if (!payload) {
                    return;
                }

                updateConversationInList(payload);
            });

            listChannelSubscriptions.set(channelName, subscription);
        });
    }

    function unsubscribeFromConversationListChannels() {
        listChannelSubscriptions.forEach((_, channelName) => {
            window.Echo.leave(channelName);
        });
        listChannelSubscriptions.clear();
    }

    /**
     * Update conversation in the list
     */
    const updateConversationInList = (message) => {
        const index = conversations.value.findIndex((c) => c.id === message.conversation_id);

        if (index === -1) {
            return;
        }

        const previous = conversations.value[index];
        const previousUnread = Number(previous?.unread_count ?? 0);
        const isActiveConversation = activeConversation.value?.id === message.conversation_id;
        const isFromCurrentUser = message.sender_id === currentUser.value?.id;

        const updatedConversation = {
            ...previous,
            last_message: {
                text: message.message,
                sender: message.sender?.name ?? null,
                created_at: message.created_at,
            },
            last_message_at: message.created_at,
            unread_count: isActiveConversation || isFromCurrentUser ? 0 : previousUnread + 1,
        };

        const remaining = conversations.value.filter((c) => c.id !== message.conversation_id);
        conversations.value = [updatedConversation, ...remaining];
    };

    /**
     * Cleanup on unmount
     */
    onUnmounted(() => {
        unsubscribeFromConversation();
        unsubscribeFromConversationListChannels();
    });

    watch(
        () => conversations.value.map((conversation) => conversation.id),
        () => {
            subscribeToConversationListChannels();
        },
    );

    return {
        conversations,
        activeConversation,
        messages,
        loading,
        sending,
        onlineUsers,
        loadConversations,
        loadConversation,
        createProjectChat,
        contactAdminSupport,
        sendMessage,
        markAsRead,
        loadMoreMessages,
    };
}
