<script setup>
import { usePage } from '@inertiajs/vue3';
import moment from 'moment';
import { computed, ref } from 'vue';

const page = usePage();
const currentUser = computed(() => page.props.auth?.user);

const props = defineProps({
    conversations: {
        type: Array,
        required: true,
    },
    activeConversationId: {
        type: Number,
        default: null,
    },
    loading: {
        type: Boolean,
        default: false,
    },
});

const emit = defineEmits(['select', 'contactAdmin']);

const isSuperAdmin = computed(() => {
    return currentUser.value?.roles?.includes('Super Admin');
});

console.log(currentUser.value);

const searchQuery = ref('');

const filteredConversations = computed(() => {
    if (!searchQuery.value) {
        return props.conversations;
    }

    const query = searchQuery.value.toLowerCase();
    return props.conversations.filter((conv) => conv.name.toLowerCase().includes(query));
});

const formatTime = (date) => {
    return moment(date).calendar(null, {
        sameDay: 'LT',
        lastDay: '[Yesterday]',
        lastWeek: 'ddd',
        sameElse: 'DD/MM/YYYY',
    });
};

const selectConversation = (conversationId) => {
    emit('select', conversationId);
};
</script>

<template>
    <div class="d-flex flex-column h-100">
        <!-- Header -->
        <div class="p-3 border-bottom bg-light">
            <h5 class="mb-0">Chats</h5>
        </div>

        <!-- Admin Support Button (only for non-super-admins) -->
        <div v-if="!isSuperAdmin" class="p-3 border-bottom">
            <button
                type="button"
                class="btn btn-primary w-100 d-flex align-items-center justify-content-center"
                @click="emit('contactAdmin')"
            >
                <i class="ri-customer-service-2-line me-2"></i>
                Contact Super Admin
            </button>
        </div>

        <!-- Search -->
        <div class="p-3 border-bottom">
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0">
                    <i class="ri-search-line"></i>
                </span>
                <input
                    v-model="searchQuery"
                    type="text"
                    class="form-control border-start-0"
                    placeholder="Search conversations..."
                />
            </div>
        </div>

        <!-- Conversations List -->
        <div class="flex-grow-1 overflow-auto">
            <div v-if="loading && conversations.length === 0" class="p-4 text-center">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>

            <div v-else-if="filteredConversations.length === 0" class="p-4 text-center text-muted">
                <i class="ri-chat-3-line fs-1"></i>
                <p class="mt-2 mb-0">No conversations found</p>
            </div>

            <div v-else class="list-group list-group-flush">
                <button
                    v-for="conversation in filteredConversations"
                    :key="conversation.id"
                    type="button"
                    class="list-group-item list-group-item-action border-0 py-3 px-3"
                    :class="{
                        active: conversation.id === activeConversationId,
                        'bg-light': conversation.id === activeConversationId,
                    }"
                    @click="selectConversation(conversation.id)"
                >
                    <div class="d-flex align-items-start">
                        <!-- Conversation Icon -->
                        <div class="me-3">
                            <div
                                class="rounded-circle d-flex align-items-center justify-content-center"
                                style="width: 48px; height: 48px"
                                :style="{
                                    background:
                                        conversation.type === 'admin_support'
                                            ? 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)'
                                            : 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                                }"
                            >
                                <i
                                    class="text-white fs-5"
                                    :class="
                                        conversation.type === 'admin_support'
                                            ? 'ri-customer-service-2-line'
                                            : 'ri-folder-line'
                                    "
                                ></i>
                            </div>
                        </div>

                        <!-- Content -->
                        <div class="flex-grow-1 overflow-hidden">
                            <div class="d-flex justify-content-between align-items-start mb-1">
                                <h6 class="mb-0 text-truncate" style="max-width: 180px">
                                    {{ conversation.name }}
                                </h6>
                                <small
                                    v-if="conversation.last_message_at"
                                    class="text-muted"
                                    style="font-size: 0.75rem"
                                >
                                    {{ formatTime(conversation.last_message_at) }}
                                </small>
                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <p class="text-muted mb-0 small text-truncate" style="max-width: 180px">
                                    <span v-if="conversation.last_message">
                                        <strong v-if="conversation.last_message.sender">
                                            {{ conversation.last_message.sender }}:
                                        </strong>
                                        {{ conversation.last_message.text }}
                                    </span>
                                    <span v-else class="fst-italic"> No messages yet </span>
                                </p>

                                <!-- Unread Badge -->
                                <span
                                    v-if="conversation.unread_count > 0"
                                    class="badge bg-primary rounded-pill ms-2"
                                    style="font-size: 0.7rem"
                                >
                                    {{ conversation.unread_count > 9 ? '9+' : conversation.unread_count }}
                                </span>
                            </div>

                            <!-- Participants Count -->
                            <div class="mt-1">
                                <small class="text-muted">
                                    <i class="ri-group-line"></i>
                                    {{ conversation.participants_count }} members
                                </small>
                            </div>
                        </div>
                    </div>
                </button>
            </div>
        </div>
    </div>
</template>

<style scoped>
.list-group-item.active {
    background-color: #f8f9fa !important;
    border-color: transparent !important;
    border-left: 3px solid #667eea !important;
}

.list-group-item:hover {
    background-color: #f8f9fa;
    cursor: pointer;
}

.overflow-auto {
    overflow-y: auto;
    overflow-x: hidden;
}

.overflow-auto::-webkit-scrollbar {
    width: 6px;
}

.overflow-auto::-webkit-scrollbar-track {
    background: #f1f1f1;
}

.overflow-auto::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 3px;
}

.overflow-auto::-webkit-scrollbar-thumb:hover {
    background: #555;
}
</style>
