<template>
    <div class="position-relative">
        <div class="input-group">
            <input
                v-model="searchQuery"
                type="text"
                class="form-control"
                :class="inputClass"
                :placeholder="placeholder"
                @input="onInput"
                @focus="showDropdown = true"
                @blur="onBlur"
            />
            <button
                v-if="(searchQuery && searchQuery.length > 0) || selectedItem"
                @click.prevent="clearSelection"
                type="button"
                class="btn btn-danger"
            >
                <i class="ri-close-line"></i>
            </button>
            <button v-else type="button" class="btn btn-primary">
                <i class="ri-search-2-line"></i>
            </button>
        </div>

        <!-- Search results dropdown -->
        <template v-if="showDropdown && searchQuery && searchQuery.length >= minSearchLength && !selectedItem">
            <div
                class="card position-absolute border-0 shadow-sm mt-1"
                style="left: 0; right: 0; z-index: 9999999; max-height: 300px; overflow-y: auto"
            >
                <div class="card-body py-2">
                    <div v-if="!loading">
                        <ul v-if="results.length > 0" class="list-group">
                            <li
                                v-for="item in results"
                                :key="item[valueKey]"
                                class="list-group-item cursor-pointer border-0 py-2 px-2 mb-1 rounded"
                                @mousedown.prevent="selectItem(item)"
                            >
                                <slot name="item" :item="item">
                                    <div>
                                        <strong>{{ item[labelKey] }}</strong>
                                        <div v-if="item[subtitleKey]" class="text-muted small">
                                            {{ item[subtitleKey] }}
                                        </div>
                                    </div>
                                </slot>
                            </li>
                        </ul>
                        <p v-else class="text-danger text-center mb-0 py-2">
                            {{ noResultsText }}
                        </p>
                    </div>
                    <div v-else class="text-center py-2">
                        <div class="spinner-border spinner-border-sm text-primary" role="status">
                            <span class="visually-hidden">{{ loadingText }}</span>
                        </div>
                        <small class="text-muted ms-2">{{ loadingText }}</small>
                    </div>
                </div>
            </div>
        </template>
    </div>
</template>

<script setup>
import { debounce } from 'lodash';
import { ref, watch } from 'vue';

const props = defineProps({
    // API configuration
    searchUrl: {
        type: String,
        required: true,
    },
    queryParam: {
        type: String,
        default: 'query',
    },

    // Display configuration
    valueKey: {
        type: String,
        default: 'id',
    },
    labelKey: {
        type: String,
        default: 'name',
    },
    subtitleKey: {
        type: String,
        default: null,
    },

    // Behavior configuration
    minSearchLength: {
        type: Number,
        default: 2,
    },
    debounceMs: {
        type: Number,
        default: 300,
    },

    // Styling and text
    placeholder: {
        type: String,
        default: 'Search...',
    },
    inputClass: {
        type: String,
        default: '',
    },
    noResultsText: {
        type: String,
        default: 'No results found!',
    },
    loadingText: {
        type: String,
        default: 'Searching...',
    },

    // v-model support
    modelValue: {
        type: [String, Number, Object],
        default: null,
    },

    // Initial selected item for pre-populating
    initialSelectedItem: {
        type: Object,
        default: null,
    },
});

const emit = defineEmits(['update:modelValue', 'selected', 'cleared']);

// Component state
const searchQuery = ref('');
const results = ref([]);
const loading = ref(false);
const selectedItem = ref(null);
const showDropdown = ref(false);

// Search function with debouncing
const searchItems = debounce(async (query) => {
    if (query && query.length >= props.minSearchLength) {
        loading.value = true;

        try {
            const url = new URL(props.searchUrl, window.location.origin);
            url.searchParams.append(props.queryParam, query);

            const response = await fetch(url.toString(), {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
            });

            if (response.ok) {
                const data = await response.json();
                results.value = Array.isArray(data) ? data : data.data || [];
            } else {
                results.value = [];
            }
        } catch (error) {
            console.error('Search error:', error);
            results.value = [];
        } finally {
            loading.value = false;
        }
    } else {
        results.value = [];
    }
}, props.debounceMs);

// Watch for search query changes
watch(searchQuery, (newValue) => {
    if (selectedItem.value && newValue !== selectedItem.value[props.labelKey]) {
        // User is typing after selection, clear selection
        selectedItem.value = null;
        emit('update:modelValue', null);
        emit('cleared');
    }
    searchItems(newValue);
});

// Input handler
const onInput = () => {
    showDropdown.value = true;
};

// Blur handler with delay to allow clicks
const onBlur = () => {
    setTimeout(() => {
        showDropdown.value = false;
    }, 200);
};

// Select item
const selectItem = (item) => {
    selectedItem.value = item;
    searchQuery.value = item[props.labelKey];
    results.value = [];
    showDropdown.value = false;

    emit('update:modelValue', item[props.valueKey]);
    emit('selected', item);
};

// Clear selection
const clearSelection = () => {
    selectedItem.value = null;
    searchQuery.value = '';
    results.value = [];
    showDropdown.value = false;

    emit('update:modelValue', null);
    emit('cleared');
};

// Set initial value if provided
watch(
    () => props.modelValue,
    (newValue) => {
        if (!newValue && selectedItem.value) {
            clearSelection();
        } else if (newValue && props.initialSelectedItem && !selectedItem.value) {
            // Set initial selected item if modelValue matches
            if (newValue === props.initialSelectedItem[props.valueKey]) {
                selectItem(props.initialSelectedItem);
            }
        }
    },
    { immediate: true },
);

// Watch for initialSelectedItem changes
watch(
    () => props.initialSelectedItem,
    (newItem) => {
        if (newItem && props.modelValue === newItem[props.valueKey] && !selectedItem.value) {
            selectItem(newItem);
        }
    },
    { immediate: true },
);

// Expose methods for parent component
defineExpose({
    clearSelection,
    setDisplayValue: (value) => {
        searchQuery.value = value;
    },
});
</script>

<style scoped>
.cursor-pointer {
    cursor: pointer;
}

.cursor-pointer:hover {
    background-color: #f8f9fa !important;
}
</style>
