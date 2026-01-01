<script>
export default {
    layout: MainLayout,
};
</script>

<script setup>
import ChatSidebar from '@/Components/Chat/ChatSidebar.vue';
import ChatWindow from '@/Components/Chat/ChatWindow.vue';
import { useChat } from '@/Composables/useChat';
import MainLayout from '@/Layouts/MainLayout.vue';
import { Head } from '@inertiajs/vue3';
import axios from 'axios';
import { onMounted, ref } from 'vue';

const props = defineProps({
    projectId: {
        type: Number,
        default: null,
    },
    conversationId: {
        type: Number,
        default: null,
    },
});

const {
    conversations,
    activeConversation,
    messages,
    loading,
    sending,
    loadConversations,
    loadConversation,
    contactAdminSupport,
    sendMessage,
} = useChat(props.projectId);

const selectedConversationId = ref(props.conversationId);

onMounted(async () => {
    await loadConversations();

    // Auto-load conversation if provided
    if (props.conversationId) {
        await loadConversation(props.conversationId);
    }
});

const handleConversationSelect = async (conversationId) => {
    selectedConversationId.value = conversationId;
    await loadConversation(conversationId);
};

const handleSendMessage = async (messageText) => {
    await sendMessage(messageText);
};

const handleContactAdmin = async () => {
    await contactAdminSupport();
};

const handleDeleteConversation = async () => {
    if (!activeConversation.value) return;

    if (!confirm('Are you sure you want to delete this conversation? This action cannot be undone.')) {
        return;
    }

    try {
        await axios.delete(`/chat/conversations/${activeConversation.value.id}`);

        // Clear active conversation
        activeConversation.value = null;
        messages.value = [];

        // Reload conversations list
        await loadConversations();

        alert('Conversation deleted successfully');
    } catch (error) {
        console.error('Failed to delete conversation:', error);
        alert('Failed to delete conversation. Please try again.');
    }
};
</script>

<template>
    <Head title="Project Chat" />

    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow">
                <div class="card-body p-0">
                    <div class="row g-0" style="height: calc(100vh - 200px)">
                        <!-- Sidebar -->
                        <div class="col-12 col-md-4 col-lg-3 border-end">
                            <ChatSidebar
                                :conversations="conversations"
                                :active-conversation-id="activeConversation?.id"
                                :loading="loading"
                                @select="handleConversationSelect"
                                @contact-admin="handleContactAdmin"
                            />
                        </div>

                        <!-- Chat Window -->
                        <div class="col-12 col-md-8 col-lg-9">
                            <ChatWindow
                                v-if="activeConversation"
                                :conversation="activeConversation"
                                :messages="messages"
                                :loading="loading"
                                :sending="sending"
                                @send="handleSendMessage"
                                @delete-conversation="handleDeleteConversation"
                            />
                            <div v-else class="d-flex align-items-center justify-content-center h-100">
                                <div class="text-center text-muted">
                                    <i class="ri-message-3-line" style="font-size: 4rem"></i>
                                    <p class="mt-3">Select a conversation to start chatting</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
