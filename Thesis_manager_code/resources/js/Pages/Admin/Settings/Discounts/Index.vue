<script>
import MainLayout from '@/Layouts/MainLayout.vue';
import { computed, ref } from 'vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { useHelpers } from '@/Composables/useHelpers.js';
import { Head, Link, router, useForm, usePage } from '@inertiajs/vue3';
import { Modal } from 'bootstrap';
import { debounce, pickBy } from 'lodash';
import { onMounted, reactive, watch } from 'vue';

const { currentRow } = useHelpers();

const props = defineProps({
    filters: {
        type: Object,
    },
    discounts: {
        type: Object,
        required: true,
    },
});

let discount = ref(null);

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('discounts.index'), pickBy(params), {
            preserveScroll: true,
            preserveState: true,
        });
    }, 300),
    { deep: true },
);

// Clear table search
let clearSearch = () => {
    params.search = '';
};

// Modal control
const modalState = reactive({
    modal: null,
    editing: false,
});

onMounted(() => {
    modalState.modal = new Modal('#discountModal', {});
});

const form = useForm({
    name: '',
    type: 'percentage',
    rate: '',
    is_active: 1,
});

// Show modal in create mode
const createModal = () => {
    modalState.editing = false;
    form.reset();
    form.type = 'percentage'; // Set default type
    modalState.modal.show();
};

// Get the discount for editing in the modal
const editModal = (id) => {
    modalState.editing = true;

    fetch(route('discounts.edit', id), {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then((response) => response.json())
        .then((data) => {
            discount.value = data;
            Object.assign(form, data);
        });

    modalState.modal.show();
};

// Store discount
const store = () => {
    if (!modalState.editing) {
        form.post(route('discounts.store'), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'success',
                    title: 'Discount Created!',
                });

                form.reset();
                form.type = 'percentage'; // Reset to default
                modalState.modal.hide();
            },
        });
    } else {
        form.put(route('discounts.update', discount.value), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'info',
                    title: 'Discount Updated!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    }
};

// Delete discount
const deleteDiscount = (discount) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('discounts.destroy', discount), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Discount Deleted!',
                    });
                },
                onError: () => {
                    Toast.fire({
                        icon: 'danger',
                        title: 'Something Went Wrong!',
                    });
                },
            });
        }
    });
};

// Modal Title
const modalTitle = computed(() => (modalState.editing ? 'Edit Discount' : 'Create Discount'));

// Format rate display based on type
const formatRate = (rate, type) => {
    return type === 'percentage' ? `${rate}%` : `${rate} ${usePage().props.settings.currency.code}`;
};
</script>

<template>
    <Head title="Discounts" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Discounts</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <button @click="createModal" class="btn btn-primary">
                                Add Discount <i class="ri-add-line"></i>
                            </button>
                        </div>

                        <div class="col-md-4">
                            <div class="navbar-search form-inline" id="navbar-search-main">
                                <div class="input-group input-group-merge search-bar">
                                    <input
                                        v-model="params.search"
                                        type="text"
                                        class="form-control"
                                        id="searchTable"
                                        placeholder="Search ...."
                                        aria-label="searchTable"
                                        aria-describedby="searchTable"
                                    />
                                    <span v-if="!params.search" class="input-group-text" id="searchTable">
                                        <i class="ri-search-line text-secondary"></i>
                                    </span>
                                    <span
                                        @click="clearSearch"
                                        v-else
                                        class="input-group-text"
                                        style="cursor: pointer"
                                        id="removeParameter"
                                    >
                                        <i class="ri-close-line text-danger"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="table-responsive">
                        <table class="table table-centered table-nowrap mb-0 rounded">
                            <thead class="thead-light">
                                <tr>
                                    <th class="border-0 rounded-start text-center align-middle">No.</th>
                                    <th class="border-0 text-center align-middle">Discount Name</th>
                                    <th class="border-0 text-center align-middle">Type</th>
                                    <th class="border-0 text-center align-middle">Rate</th>
                                    <th class="border-0 text-center align-middle">Status</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(discounts.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="6">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(discount, index) in discounts.data" :key="discount.id">
                                    <td class="text-center align-middle">
                                        {{ currentRow(index, discounts) }}
                                    </td>
                                    <td class="text-center align-middle">
                                        {{ discount.name }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <span
                                            class="badge"
                                            :class="discount.type === 'percentage' ? 'bg-info' : 'bg-warning'"
                                        >
                                            {{ discount.type === 'percentage' ? 'Percentage' : 'Fixed Amount' }}
                                        </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        {{ formatRate(discount.rate, discount.type) }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <span v-if="discount.is_active == 1" class="badge bg-success"> Active </span>
                                        <span v-else class="badge bg-danger"> Inactive </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <button
                                            @click.prevent="editModal(discount.id)"
                                            class="btn btn-info btn-sm me-2"
                                        >
                                            <i class="ri-pencil-fill"></i>
                                        </button>
                                        <a
                                            @click.prevent="deleteDiscount(discount)"
                                            href=""
                                            id="delete"
                                            class="btn btn-danger btn-sm"
                                        >
                                            <i class="ri-delete-bin-2-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4 row">
                        <div class="col-md-2 mb-3 mb-md-0">
                            <div class="d-flex align-items-center showing">
                                <div class="me-2 show-text">Showing</div>
                                <select
                                    v-model="params.per_page"
                                    class="show-select form-select px-3 py-1"
                                    id="perPage"
                                >
                                    <option value="10">10</option>
                                    <option value="30">30</option>
                                    <option value="50">50</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-6 offset-md-4 d-flex justify-content-md-end">
                            <nav>
                                <ul class="pagination pagination-sm">
                                    <template v-for="(link, index) in discounts.links">
                                        <li v-if="link.url === null" class="page-item">
                                            <button
                                                class="page-link text-muted"
                                                tabindex="-1"
                                                v-html="link.label"
                                                disabled
                                            ></button>
                                        </li>

                                        <li v-else class="page-item">
                                            <Link
                                                preserve-scroll
                                                class="page-link"
                                                :href="link.url"
                                                v-html="link.label"
                                                :class="{ active: link.active }"
                                            ></Link>
                                        </li>
                                    </template>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div
        ref="modalState.modalElement"
        class="modal fade"
        id="discountModal"
        tabindex="-1"
        aria-labelledby="discountModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="discountModalLabel">{{ modalTitle }}</h5>
                </div>
                <form @submit.prevent="store">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Discount Name <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.name"
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.name,
                                        }"
                                    />
                                    <span v-show="form.errors.name" class="text-danger">{{ form.errors.name }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Type <span class="text-danger">*</span></label>
                                    <select
                                        v-model="form.type"
                                        class="form-select"
                                        :class="{
                                            'border-2 border-danger': form.errors.type,
                                        }"
                                    >
                                        <option value="percentage">Percentage</option>
                                        <option value="fixed">Fixed Amount</option>
                                    </select>
                                    <span v-show="form.errors.type" class="text-danger">
                                        {{ form.errors.type }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>
                                        Rate
                                        <span v-if="form.type === 'percentage'">(%)</span>
                                        <span v-else>({{ $page.props.settings.currency.code }})</span>
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input
                                        v-model="form.rate"
                                        type="number"
                                        step="0.01"
                                        :min="0"
                                        :max="form.type === 'percentage' ? 100 : undefined"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.rate,
                                        }"
                                    />
                                    <span v-show="form.errors.rate" class="text-danger">{{ form.errors.rate }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Status <span class="text-danger">*</span></label>
                                    <div class="form-check form-switch mt-2">
                                        <input
                                            class="form-check-input cursor-pointer"
                                            type="checkbox"
                                            id="status"
                                            v-model="form.is_active"
                                            true-value="1"
                                            false-value="0"
                                        />
                                        <label class="form-check-label cursor-pointer" for="status">
                                            <span v-if="form.is_active == 1" class="text-success">Active</span>
                                            <span v-else class="text-danger">Inactive</span>
                                        </label>
                                    </div>
                                    <span v-show="form.errors.is_active" class="text-danger">
                                        {{ form.errors.is_active }}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        <button :disabled="form.processing" type="submit" class="btn btn-primary">
                            <span v-if="!modalState.editing">Create Discount</span>
                            <span v-else>Update Discount</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
