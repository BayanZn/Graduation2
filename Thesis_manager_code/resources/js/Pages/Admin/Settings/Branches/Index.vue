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
import { Head, Link, router, useForm } from '@inertiajs/vue3';
import { Modal } from 'bootstrap';
import { debounce, pickBy } from 'lodash';
import { onMounted, reactive, watch } from 'vue';

const props = defineProps({
    filters: {
        type: Object,
    },
    backendBranches: {
        type: Object,
        required: true,
    },
});

let branch = ref(null);

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('branches.index'), pickBy(params), {
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
    modalState.modal = new Modal('#branchModal', {});
});

const form = useForm({
    name: '',
    code: '',
    address: '',
    phone: '',
    email: '',
    city: '',
    state: '',
    country: '',
    is_active: 1,
});

// Show modal in create mode
const createModal = () => {
    modalState.editing = false;
    form.reset();
    modalState.modal.show();
};

// Get the branch for editing in the modal
const editModal = (id) => {
    modalState.editing = true;

    fetch(route('branches.edit', id), {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then((response) => response.json())
        .then((data) => {
            branch.value = data;
            Object.assign(form, data);
        });

    modalState.modal.show();
};

// Store branch
const store = () => {
    if (!modalState.editing) {
        form.post(route('branches.store'), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'success',
                    title: 'Branch Created!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    } else {
        form.put(route('branches.update', branch.value), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'info',
                    title: 'Branch Updated!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    }
};

// Delete branch
const deleteBranch = (branch) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('branches.destroy', branch), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Branch Deleted!',
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
const modalTitle = computed(() => (modalState.editing ? 'Edit Branch' : 'Create Branch'));
</script>

<template>
    <Head title="Branches" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Branches</li>
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
                                Add Branch <i class="ri-add-line"></i>
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

                    <div v-if="backendBranches.data.length === 0" class="text-center py-5 text-danger fw-semibold">
                        There is no data available to show
                    </div>

                    <div v-else class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4">
                        <div v-for="branch in backendBranches.data" :key="branch.id" class="col">
                            <div class="card border-0 shadow h-100 bg-gray-100">
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div class="d-flex align-items-center">
                                            <div
                                                class="rounded-circle d-flex align-items-center justify-content-center me-3 text-primary bg-primary bg-opacity-10"
                                                style="width: 48px; height: 48px"
                                            >
                                                <i class="ri-building-4-fill fs-4"></i>
                                            </div>
                                            <div>
                                                <h5 class="fw-semibold mb-1">{{ branch.name }}</h5>
                                                <span
                                                    class="badge"
                                                    :class="branch.is_active == 1 ? 'bg-success' : 'bg-danger'"
                                                >
                                                    {{ branch.is_active == 1 ? 'Active' : 'Inactive' }}
                                                </span>
                                            </div>
                                        </div>
                                        <span class="badge bg-secondary">
                                            {{ branch.code }}
                                        </span>
                                    </div>

                                    <ul class="list-unstyled text-muted small mb-4">
                                        <li class="mb-2 d-flex align-items-center">
                                            <i class="ri-phone-line me-2 text-primary"></i>
                                            <span>{{ branch.phone || 'N/A' }}</span>
                                        </li>
                                        <li class="mb-2 d-flex align-items-center">
                                            <i class="ri-mail-line me-2 text-primary"></i>
                                            <span>{{ branch.email || 'N/A' }}</span>
                                        </li>
                                        <li class="mb-0 d-flex align-items-start">
                                            <i class="ri-map-pin-line me-2 mt-1 text-primary"></i>
                                            <span>{{ branch.address || 'No address provided' }}</span>
                                        </li>
                                    </ul>

                                    <div class="mt-auto pt-3 border-top d-flex justify-content-end gap-2">
                                        <button @click.prevent="editModal(branch.id)" class="btn btn-info btn-sm">
                                            <i class="ri-pencil-fill me-1"></i>
                                            Edit
                                        </button>
                                        <button
                                            v-if="$page.props.auth.user.roles.includes('Developer')"
                                            @click.prevent="deleteBranch(branch)"
                                            class="btn btn-danger btn-sm"
                                        >
                                            <i class="ri-delete-bin-2-fill me-1"></i>
                                            Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                    <template v-for="(link, index) in backendBranches.links">
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
        id="branchModal"
        tabindex="-1"
        aria-labelledby="branchModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="branchModalLabel">{{ modalTitle }}</h5>
                </div>
                <form @submit.prevent="store">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Branch Name <span class="text-danger">*</span></label>
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
                                    <label>Code <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.code"
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.code,
                                        }"
                                    />
                                    <span v-show="form.errors.code" class="text-danger">
                                        {{ form.errors.code }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Phone <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.phone"
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.phone,
                                        }"
                                    />
                                    <span v-show="form.errors.phone" class="text-danger">{{ form.errors.phone }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Email <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.email"
                                        type="email"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.email,
                                        }"
                                    />
                                    <span v-show="form.errors.email" class="text-danger">
                                        {{ form.errors.email }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Address</label>
                                    <input
                                        v-model="form.address"
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'border-2 border-danger': form.errors.address,
                                        }"
                                    />
                                    <span v-show="form.errors.address" class="text-danger">
                                        {{ form.errors.address }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <label>Status <span class="text-danger">*</span></label>
                                    <div class="form-check form-switch">
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
                            <span v-if="!modalState.editing">Create Branch</span>
                            <span v-else>Update Branch</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
