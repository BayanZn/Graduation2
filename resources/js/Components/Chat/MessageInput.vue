<script setup>
import { ref } from 'vue';

const props = defineProps({
    sending: {
        type: Boolean,
        default: false,
    },
});

const emit = defineEmits(['send']);

const messageText = ref('');
const textarea = ref(null);

const handleInput = () => {
    // Auto-resize textarea
    if (textarea.value) {
        textarea.value.style.height = 'auto';
        textarea.value.style.height = textarea.value.scrollHeight + 'px';
    }
};

const handleKeydown = (e) => {
    // Send message on Enter (without Shift)
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        sendMessage();
    }
};

const sendMessage = () => {
    if (!messageText.value.trim() || props.sending) return;

    emit('send', messageText.value.trim());
    messageText.value = '';

    // Reset textarea height
    if (textarea.value) {
        textarea.value.style.height = 'auto';
    }

    // Nothing else to emit here
};
</script>

<template>
    <div class="p-3 border-top bg-white">
        <div class="d-flex align-items-end gap-2">
            <!-- Message Input -->
            <div class="flex-grow-1">
                <textarea
                    ref="textarea"
                    v-model="messageText"
                    class="form-control border-0 shadow-sm"
                    placeholder="Type a message..."
                    rows="1"
                    style="resize: none; max-height: 120px; overflow-y: auto"
                    :disabled="sending"
                    @input="handleInput"
                    @keydown="handleKeydown"
                ></textarea>
            </div>

            <!-- Send Button -->
            <button
                type="button"
                class="btn btn-primary rounded-circle d-flex align-items-center justify-content-center"
                style="width: 42px; height: 42px"
                :disabled="!messageText.trim() || sending"
                @click="sendMessage"
            >
                <span v-if="sending" class="spinner-border spinner-border-sm" role="status">
                    <span class="visually-hidden">Sending...</span>
                </span>
                <i v-else class="ri-send-plane-fill fs-5"></i>
            </button>
        </div>

        <!-- Hint Text -->
        <small class="text-muted d-block mt-2" style="font-size: 0.75rem">
            <i class="ri-information-line"></i>
            Press Enter to send, Shift+Enter for new line
        </small>
    </div>
</template>

<style scoped>
textarea:focus {
    outline: none;
    box-shadow: none !important;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
}

.btn-primary:hover:not(:disabled) {
    background: linear-gradient(135deg, #5568d3 0%, #65408d 100%);
}

.btn-primary:disabled {
    opacity: 0.6;
}
</style>
