<script>
import MainLayout from '@/Layouts/MainLayout.vue';
import { computed } from 'vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { useHelpers } from '@/Composables/useHelpers.js';
import { Head, Link, router, useForm } from '@inertiajs/vue3';
import { Modal } from 'bootstrap';
import { debounce, pickBy } from 'lodash';
import { onMounted, reactive, ref, watch } from 'vue';

const { currentRow } = useHelpers();

const props = defineProps({
    payment_methods: {
        type: Object,
    },
    filters: {
        type: Object,
    },
});

let payment_method = ref(null);

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('payment-methods.index'), pickBy(params), {
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
    modalState.modal = new Modal('#paymentMethodModal', {});
});

const form = useForm({
    method_name: '',
    short_code: '',
});

// Show modal in create mode
const createModal = () => {
    modalState.editing = false;
    form.reset();
    modalState.modal.show();
};

// Get the payment method for editing in the modal
const editModal = (id) => {
    modalState.editing = true;

    fetch(route('payment-methods.edit', id), {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then((response) => response.json())
        .then((data) => {
            payment_method.value = data;
            form.method_name = data.method_name;
            form.short_code = data.short_code;
        });

    modalState.modal.show();
};

// Store payment method
const store = () => {
    if (!modalState.editing) {
        form.post(route('payment-methods.store'), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'success',
                    title: 'Payment Method Created!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    } else {
        form.put(route('payment-methods.update', payment_method.value), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'info',
                    title: 'Payment Method Updated!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    }
};

// Delete payment method
const deletePaymentMethod = (payment_method) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('payment-methods.destroy', payment_method), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Payment Method Deleted!',
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
const modalTitle = computed(() => (modalState.editing ? 'Edit Payment Method' : 'Create Payment Method'));
</script>

<template>
    <Head title="Payment Methods" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Payment Methods</li>
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
                                Add Payment Method <i class="ri-add-line"></i>
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
                                    <th class="border-0 text-center align-middle">Method Name</th>
                                    <th class="border-0 text-center align-middle">Short Code</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(payment_methods.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="4">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(payment_method, index) in payment_methods.data" :key="payment_method.id">
                                    <td class="text-center align-middle">{{ currentRow(index, payment_methods) }}</td>
                                    <td class="text-center align-middle">{{ payment_method.method_name }}</td>
                                    <td class="text-center align-middle">{{ payment_method.short_code ?? '-----' }}</td>
                                    <td class="text-center align-middle">
                                        <button
                                            @click.prevent="editModal(payment_method.id)"
                                            class="btn btn-info btn-sm me-2"
                                        >
                                            <i class="ri-pencil-fill"></i>
                                        </button>
                                        <a
                                            @click.prevent="deletePaymentMethod(payment_method)"
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
                                    <template v-for="(link, index) in payment_methods.links">
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
        id="paymentMethodModal"
        tabindex="-1"
        aria-labelledby="paymentMethodModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="paymentMethodModalLabel">{{ modalTitle }}</h5>
                </div>
                <form @submit.prevent="store">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Method Name <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.method_name"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.method_name }"
                                    />
                                    <span v-show="form.errors.method_name" class="text-danger">{{
                                        form.errors.method_name
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Short Code <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.short_code"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.short_code }"
                                    />
                                    <span v-show="form.errors.short_code" class="text-danger">{{
                                        form.errors.short_code
                                    }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        <button :disabled="form.processing" type="submit" class="btn btn-primary">
                            <span v-if="!modalState.editing">Create Payment Method</span>
                            <span v-else>Update Payment Method</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
