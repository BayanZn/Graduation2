// composables/useTooltips.js
import { Tooltip } from 'bootstrap';
import { onMounted } from 'vue';

export function useTooltips() {
    const initializeTooltips = () => {
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        return [...tooltipTriggerList].map((el) => new Tooltip(el));
    };

    const destroyTooltips = () => {
        const tooltips = Tooltip.getInstance || Tooltip.getOrCreateInstance;
        document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach((el) => {
            const tooltip = Tooltip.getInstance(el);
            if (tooltip) tooltip.dispose();
        });
    };

    onMounted(() => {
        initializeTooltips();
    });

    return {
        initializeTooltips,
        destroyTooltips,
    };
}
