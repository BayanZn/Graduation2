<script setup>
import { usePage } from '@inertiajs/vue3';
import { computed } from 'vue';
import MessageInput from './MessageInput.vue';
import MessagesList from './MessagesList.vue';

const page = usePage();
const currentUser = computed(() => page.props.auth?.user);

const props = defineProps({
    conversation: {
        type: Object,
        required: true,
    },
    messages: {
        type: Array,
        required: true,
    },
    loading: {
        type: Boolean,
        default: false,
    },
    sending: {
        type: Boolean,
        default: false,
    },
});

const emit = defineEmits(['send', 'deleteConversation']);

const isSuperAdmin = computed(() => {
    // Check if roles array contains 'Super Admin' string
    const result =
        currentUser.value?.roles?.includes('Super Admin') ||
        currentUser.value?.roles?.some((role) => role.name === 'Super Admin' || role === 'Super Admin');
    return result;
});

const participants = computed(() => {
    return props.conversation.participants || [];
});

const participantNames = computed(() => {
    return participants.value.map((p) => p.name).join(', ');
});

const handleSend = (messageText) => {
    emit('send', messageText);
};
</script>

<template>
    <div class="d-flex flex-column h-100">
        <!-- Header -->
        <div class="p-3 border-bottom bg-white">
            <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <!-- Project Icon -->
                    <div
                        class="rounded-circle d-flex align-items-center justify-content-center me-3"
                        style="width: 45px; height: 45px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
                    >
                        <i class="ri-folder-line text-white fs-5"></i>
                    </div>

                    <div>
                        <h6 class="mb-0">{{ conversation.name }}</h6>
                        <small class="text-muted">
                            <i class="ri-group-line"></i>
                            {{ participants.length }} members
                        </small>
                    </div>
                </div>

                <!-- Actions (Super Admin Only) -->
                <div v-if="isSuperAdmin" class="dropdown">
                    <button class="btn btn-light btn-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="ri-more-2-fill"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <button class="dropdown-item text-danger" type="button" @click="emit('deleteConversation')">
                                <i class="ri-delete-bin-line me-2"></i>
                                Delete Conversation
                            </button>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Participants List (expandable) -->
            <div class="mt-2">
                <small class="text-muted">
                    <strong>Members:</strong>
                    <span v-for="(participant, index) in participants" :key="participant.id">
                        {{ participant.name }}
                        <span
                            v-if="participant.role === 'supervisor'"
                            class="badge bg-info text-white ms-1"
                            style="font-size: 0.65rem"
                        >
                            Supervisor
                        </span>
                        <span v-if="index < participants.length - 1">, </span>
                    </span>
                </small>
            </div>
        </div>

        <!-- Messages Area -->
        <MessagesList :messages="messages" :loading="loading" />

        <!-- Input Area -->
        <MessageInput :sending="sending" @send="handleSend" />
    </div>
</template>
