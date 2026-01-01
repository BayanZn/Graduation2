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
import { Head, Link, router, useForm } from '@inertiajs/vue3';
import { Modal } from 'bootstrap';
import { debounce, pickBy } from 'lodash';
import { onMounted, reactive, watch } from 'vue';

const { currentRow } = useHelpers();

const props = defineProps({
    filters: {
        type: Object,
    },
    taxes: {
        type: Object,
        required: true,
    },
});

let tax = ref(null);

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('taxes.index'), pickBy(params), {
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
    modalState.modal = new Modal('#taxModal', {});
});

const form = useForm({
    name: '',
    rate: '',
    cgst: '',
    sgst: '',
    is_active: 1,
});

// Computed property to calculate total rate
const calculatedRate = computed(() => {
    const cgst = parseFloat(form.cgst) || 0;
    const sgst = parseFloat(form.sgst) || 0;
    return (cgst + sgst).toFixed(2);
});

// Watch CGST and SGST changes to update rate
watch(
    [() => form.cgst, () => form.sgst],
    () => {
        form.rate = calculatedRate.value;
    },
    { immediate: true },
);

// Show modal in create mode
const createModal = () => {
    modalState.editing = false;
    form.reset();
    modalState.modal.show();
};

// Get the tax for editing in the modal
const editModal = (id) => {
    modalState.editing = true;

    fetch(route('taxes.edit', id), {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then((response) => response.json())
        .then((data) => {
            tax.value = data;
            Object.assign(form, data);
        });

    modalState.modal.show();
};

// Store tax
const store = () => {
    if (!modalState.editing) {
        form.post(route('taxes.store'), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'success',
                    title: 'Tax Created!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    } else {
        form.put(route('taxes.update', tax.value), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'info',
                    title: 'Tax Updated!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    }
};

// Delete tax
const deleteTax = (tax) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('taxes.destroy', tax), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Tax Deleted!',
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
const modalTitle = computed(() => (modalState.editing ? 'Edit Tax' : 'Create Tax'));
</script>

<template>
    <Head title="Taxes" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Taxes</li>
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
                                Add Tax <i class="ri-add-line"></i>
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
                                    <th class="border-0 text-center align-middle">Tax Name</th>
                                    <th class="border-0 text-center align-middle">Rate (%)</th>
                                    <th class="border-0 text-center align-middle">CGST (%)</th>
                                    <th class="border-0 text-center align-middle">SGST (%)</th>
                                    <th class="border-0 text-center align-middle">Status</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(taxes.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="7">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(tax, index) in taxes.data" :key="tax.id">
                                    <td class="text-center align-middle">
                                        {{ currentRow(index, taxes) }}
                                    </td>
                                    <td class="text-center align-middle">
                                        {{ tax.name }}
                                    </td>
                                    <td class="text-center align-middle">{{ tax.rate }}%</td>
                                    <td class="text-center align-middle">
                                        {{ tax.cgst || '-' }}{{ tax.cgst ? '%' : '' }}
                                    </td>
                                    <td class="text-center align-middle">
                                        {{ tax.sgst || '-' }}{{ tax.sgst ? '%' : '' }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <span v-if="tax.is_active == 1" class="badge bg-success"> Active </span>
                                        <span v-else class="badge bg-danger"> Inactive </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <button @click.prevent="editModal(tax.id)" class="btn btn-info btn-sm me-2">
                                            <i class="ri-pencil-fill"></i>
                                        </button>
                                        <a
                                            @click.prevent="deleteTax(tax)"
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
                                    <template v-for="(link, index) in taxes.links">
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
        id="taxModal"
        tabindex="-1"
        aria-labelledby="taxModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="taxModalLabel">{{ modalTitle }}</h5>
                </div>
                <form @submit.prevent="store">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Tax Name <span class="text-danger">*</span></label>
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
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>CGST (%)</label>
                                    <input
                                        v-model="form.cgst"
                                        type="number"
                                        step="0.01"
                                        min="0"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.cgst,
                                        }"
                                    />
                                    <span v-show="form.errors.cgst" class="text-danger">{{ form.errors.cgst }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>SGST (%)</label>
                                    <input
                                        v-model="form.sgst"
                                        type="number"
                                        step="0.01"
                                        min="0"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.sgst,
                                        }"
                                    />
                                    <span v-show="form.errors.sgst" class="text-danger">
                                        {{ form.errors.sgst }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Total Rate (%) <span class="text-muted">(Auto-calculated)</span></label>
                                    <input
                                        v-model="form.rate"
                                        type="number"
                                        step="0.01"
                                        class="form-control bg-light"
                                        :class="{
                                            'border-2 border-danger': form.errors.rate,
                                        }"
                                        readonly
                                    />
                                    <small class="text-muted">Automatically calculated as CGST + SGST</small>
                                    <span v-show="form.errors.rate" class="text-danger">
                                        {{ form.errors.rate }}
                                    </span>
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
                            <span v-if="!modalState.editing">Create Tax</span>
                            <span v-else>Update Tax</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
