<script setup>
import { computed, nextTick, ref, watch } from 'vue';

const props = defineProps({
    title: {
        type: String,
        required: true,
    },
    icon: {
        type: String,
        default: 'ri-shield-check-line',
    },
    permissions: {
        type: Array,
        required: true,
    },
    modelValue: {
        type: Array,
        default: () => [],
    },
});

const emit = defineEmits(['update:modelValue']);

const checkboxRef = ref(null);

// Check if all permissions in this group are selected
const allSelected = computed(() => {
    return props.permissions.length > 0 && props.permissions.every((perm) => props.modelValue.includes(perm.name));
});

// Check if some permissions are selected
const someSelected = computed(() => {
    return !allSelected.value && props.permissions.some((perm) => props.modelValue.includes(perm.name));
});

// Update indeterminate state
watch(
    [allSelected, someSelected],
    () => {
        nextTick(() => {
            if (checkboxRef.value) {
                checkboxRef.value.indeterminate = someSelected.value;
            }
        });
    },
    { immediate: true },
);

// Toggle all permissions in this group
const toggleAll = () => {
    let updated = [...props.modelValue];

    if (allSelected.value) {
        // Remove all permissions from this group
        updated = updated.filter((p) => !props.permissions.some((perm) => perm.name === p));
    } else {
        // Add all permissions from this group
        props.permissions.forEach((perm) => {
            if (!updated.includes(perm.name)) {
                updated.push(perm.name);
            }
        });
    }

    emit('update:modelValue', updated);
};

// Toggle individual permission
const togglePermission = (permissionName) => {
    let updated = [...props.modelValue];

    if (updated.includes(permissionName)) {
        updated = updated.filter((p) => p !== permissionName);
    } else {
        updated.push(permissionName);
    }

    emit('update:modelValue', updated);
};

// Format permission name for display
const formatPermissionName = (name) => {
    return name.replace(/_/g, ' ').replace(/\b\w/g, (char) => char.toUpperCase());
};

const inputClassName = computed(() => {
    if (someSelected.value) {
        return 'bg-gray-200 border-gray-300';
    } else if (allSelected.value) {
        return '!tw-bg-teal-500 !tw-border-teal-500';
    } else {
        return '';
    }
});
</script>

<template>
    <div class="card border-0 shadow h-100 bg-gray-50">
        <div class="card-header bg-light border-bottom py-2">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <i :class="icon" class="fs-5 me-2 text-primary"></i>
                    <h6 class="mb-0 fw-semibold">{{ title }}</h6>
                </div>
                <div v-if="permissions.length > 1" class="form-check form-switch mb-0">
                    <input
                        ref="checkboxRef"
                        class="form-check-input cursor-pointer"
                        :class="inputClassName"
                        type="checkbox"
                        :id="`group-${title}`"
                        :checked="allSelected"
                        @change="toggleAll"
                    />
                    <label class="form-check-label cursor-pointer small text-muted" :for="`group-${title}`">
                        {{ allSelected ? '' : someSelected ? '' : '' }}
                    </label>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="d-flex flex-column gap-2">
                <div v-for="permission in permissions" :key="permission.name" class="form-check form-switch mb-0">
                    <input
                        class="form-check-input cursor-pointer"
                        :class="modelValue.includes(permission.name) ? '!tw-bg-blue-500 !tw-border-blue-500' : ''"
                        type="checkbox"
                        :id="permission.name"
                        :checked="modelValue.includes(permission.name)"
                        @change="togglePermission(permission.name)"
                    />
                    <label class="form-check-label cursor-pointer fw-normal" :for="permission.name">
                        {{ formatPermissionName(permission.name) }}
                    </label>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.cursor-pointer {
    cursor: pointer;
}

.form-check-input:indeterminate {
    background-color: #6c757d;
    border-color: #6c757d;
}
</style>
