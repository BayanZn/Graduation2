<script setup>
import { nextTick, onMounted, onUpdated, ref, watch } from 'vue';
import MessageBubble from './MessageBubble.vue';

const props = defineProps({
    messages: {
        type: Array,
        required: true,
    },
    loading: {
        type: Boolean,
        default: false,
    },
});

const messagesContainer = ref(null);
const shouldScrollToBottom = ref(true);

const scrollToBottom = () => {
    if (messagesContainer.value && shouldScrollToBottom.value) {
        nextTick(() => {
            messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight;
        });
    }
};

const handleScroll = () => {
    if (!messagesContainer.value) return;

    const { scrollTop, scrollHeight, clientHeight } = messagesContainer.value;
    const isAtBottom = scrollHeight - scrollTop - clientHeight < 50;

    shouldScrollToBottom.value = isAtBottom;
};

watch(
    () => props.messages.length,
    () => {
        scrollToBottom();
    },
);

onMounted(() => {
    scrollToBottom();
});

onUpdated(() => {
    scrollToBottom();
});
</script>

<template>
    <div
        ref="messagesContainer"
        class="flex-grow-1 overflow-auto p-3"
        style="background-color: #f5f7fb; max-height: calc(100vh - 350px); overflow-y: auto"
        @scroll="handleScroll"
    >
        <!-- Loading Indicator -->
        <div v-if="loading && messages.length === 0" class="text-center py-5">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="text-muted mt-2">Loading messages...</p>
        </div>

        <!-- Messages -->
        <div v-else-if="messages.length > 0" class="messages-list">
            <MessageBubble v-for="message in messages" :key="message.id" :message="message" />
        </div>

        <!-- Empty State -->
        <div v-else class="text-center py-5">
            <i class="ri-chat-3-line text-muted" style="font-size: 3rem"></i>
            <p class="text-muted mt-3">No messages yet. Start the conversation!</p>
        </div>
    </div>
</template>

<style scoped>
.overflow-auto {
    overflow-y: auto;
    overflow-x: hidden;
}

.overflow-auto::-webkit-scrollbar {
    width: 8px;
}

.overflow-auto::-webkit-scrollbar-track {
    background: #f5f7fb;
}

.overflow-auto::-webkit-scrollbar-thumb {
    background: #cbd5e0;
    border-radius: 4px;
}

.overflow-auto::-webkit-scrollbar-thumb:hover {
    background: #a0aec0;
}

.messages-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.messages-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}
</style>
