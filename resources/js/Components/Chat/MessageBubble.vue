<script setup>
import { usePage } from '@inertiajs/vue3';
import moment from 'moment';
import { computed } from 'vue';

const props = defineProps({
    message: {
        type: Object,
        required: true,
    },
});

const page = usePage();
const currentUser = computed(() => page.props.auth.user);

const isOwnMessage = computed(() => {
    return props.message.sender_id === currentUser.value.id;
});

const isSystemMessage = computed(() => {
    return props.message.type === 'system';
});

const formatTime = (date) => {
    return moment(date).format('h:mm A');
};

const senderInitials = computed(() => {
    if (!props.message.sender) return '?';
    const names = props.message.sender.name.split(' ');
    return names
        .map((n) => n[0])
        .join('')
        .toUpperCase()
        .slice(0, 2);
});
</script>

<template>
    <!-- System Message -->
    <div v-if="isSystemMessage" class="text-center">
        <small class="badge bg-light text-muted px-3 py-2">
            <i class="ri-information-line me-1"></i>
            {{ message.message }}
        </small>
    </div>

    <!-- Regular Message -->
    <div v-else class="d-flex" :class="{ 'justify-content-end': isOwnMessage }">
        <div class="message-wrapper" :class="{ 'own-message': isOwnMessage }">
            <!-- Avatar (only for received messages) -->
            <div v-if="!isOwnMessage" class="message-avatar me-2">
                <div
                    class="rounded-circle d-flex align-items-center justify-content-center"
                    style="
                        width: 36px;
                        height: 36px;
                        background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
                        font-size: 0.8rem;
                        font-weight: bold;
                        color: white;
                    "
                >
                    {{ senderInitials }}
                </div>
            </div>

            <!-- Message Content -->
            <div class="message-content">
                <!-- Sender Name (only for received messages in group chat) -->
                <div v-if="!isOwnMessage" class="mb-1">
                    <small class="text-muted fw-bold">{{ message.sender?.name }}</small>
                </div>

                <!-- Message Bubble -->
                <div
                    class="message-bubble p-3 rounded-3 shadow-sm"
                    :class="{
                        'bg-primary text-white': isOwnMessage,
                        'bg-white text-dark': !isOwnMessage,
                    }"
                    style="max-width: 400px; word-wrap: break-word"
                >
                    <p class="mb-0" style="white-space: pre-wrap">{{ message.message }}</p>
                </div>

                <!-- Timestamp -->
                <div class="mt-1">
                    <small class="text-muted" style="font-size: 0.7rem">
                        {{ formatTime(message.created_at) }}
                    </small>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.message-wrapper {
    display: flex;
    align-items: flex-end;
    max-width: 70%;
}

.message-wrapper.own-message {
    flex-direction: row-reverse;
}

.message-wrapper.own-message .message-content {
    text-align: right;
}

.message-bubble {
    display: inline-block;
    position: relative;
}

.message-bubble.bg-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
}

/* Message Animation */
.message-wrapper {
    animation: messageSlideIn 0.3s ease-out;
}

@keyframes messageSlideIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
