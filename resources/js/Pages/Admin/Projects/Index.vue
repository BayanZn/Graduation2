<script>
import MainLayout from '@/Layouts/MainLayout.vue';
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
import { reactive, ref, watch } from 'vue';

const { currentRow } = useHelpers();

const props = defineProps({
    projects: {
        type: Object,
    },
    filters: {
        type: Object,
    },
});

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('projects.index'), pickBy(params), {
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

// Export functionality
const exportProjects = () => {
    const queryParams = new URLSearchParams(pickBy(params));
    window.location.href = route('projects.export') + '?' + queryParams.toString();
};

// Import functionality
const importModal = ref(null);
const importForm = useForm({
    file: null,
});

const openImportModal = () => {
    const modal = new Modal(importModal.value);
    modal.show();
};

const handleFileChange = (event) => {
    importForm.file = event.target.files[0];
};

const submitImport = () => {
    importForm.post(route('projects.import'), {
        preserveScroll: true,
        onSuccess: () => {
            const modal = Modal.getInstance(importModal.value);
            modal.hide();
            importForm.reset();

            let { Toast } = useAlert();
            Toast.fire({
                icon: 'success',
                title: 'Projects imported successfully!',
            });
        },
        onError: () => {
            let { Toast } = useAlert();
            Toast.fire({
                icon: 'error',
                title: 'Import failed!',
            });
        },
    });
};

// Update project status
const updateStatus = (project, newStatus) => {
    router.patch(
        route('projects.update.status', project),
        {
            status: newStatus,
        },
        {
            preserveScroll: true,
            preserveState: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'success',
                    title: 'Project Status Updated!',
                });
            },
        },
    );
};

// Update project type
const updateType = (project, newType) => {
    router.patch(
        route('projects.update.type', project),
        {
            project_type: newType,
        },
        {
            preserveScroll: true,
            preserveState: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'success',
                    title: 'Project Type Updated!',
                });
            },
        },
    );
};

// Delete project
const deleteProject = (project) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('projects.destroy', project), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Project Deleted!',
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
</script>

<template>
    <Head title="Projects" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Projects</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <Link :href="route('projects.create')" class="btn btn-primary">
                                Add Project <i class="ri-add-line"></i>
                            </Link>
                            <button @click="exportProjects" class="btn btn-success ms-2">
                                <i class="ri-file-excel-line"></i> Export
                            </button>
                            <button @click="openImportModal" class="btn btn-info ms-2">
                                <i class="ri-upload-line"></i> Import
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

                    <div class="table-responsive min-h-table">
                        <table class="table table-centered table-nowrap mb-0 rounded">
                            <thead class="thead-light">
                                <tr>
                                    <th class="border-0 rounded-start text-center align-middle">No.</th>
                                    <th class="border-0 text-center align-middle">Title</th>
                                    <th class="border-0 text-center align-middle">Project Type</th>
                                    <th class="border-0 text-center align-middle">Department</th>
                                    <th class="border-0 text-center align-middle">Specialization</th>
                                    <th class="border-0 text-center align-middle">Created By</th>
                                    <th class="border-0 text-center align-middle">Status</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(projects.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="8">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(project, index) in projects.data" :key="project.id">
                                    <td class="text-center align-middle">{{ currentRow(index, projects) }}</td>
                                    <td class="text-center align-middle text-wrap">{{ project.title }}</td>
                                    <td class="text-center align-middle">
                                        <select
                                            :value="project.project_type"
                                            @change="updateType(project, $event.target.value)"
                                            :class="[
                                                'tw-text-sm tw-text-center tw-font-medium tw-px-2 tw-py-1 tw-rounded-full tw-border-0 tw-cursor-pointer tw-appearance-none tw-bg-transparent hover:tw-opacity-80 focus:tw-outline-none focus:tw-ring-2 focus:tw-ring-offset-1',
                                                project.project_type === 'Semester'
                                                    ? 'tw-text-blue-700 tw-bg-blue-200 focus:tw-ring-blue-500'
                                                    : '',
                                                project.project_type === 'Graduation 1'
                                                    ? 'tw-text-purple-700 tw-bg-purple-200 focus:tw-ring-purple-500'
                                                    : '',
                                                project.project_type === 'Graduation 2'
                                                    ? 'tw-text-indigo-700 tw-bg-indigo-200 focus:tw-ring-indigo-500'
                                                    : '',
                                            ]"
                                            style="width: auto; display: inline-block; background-image: none"
                                        >
                                            <option value="Semester" class="tw-bg-white">Semester</option>
                                            <option value="Graduation 1" class="tw-bg-white">Graduation 1</option>
                                            <option value="Graduation 2" class="tw-bg-white">Graduation 2</option>
                                        </select>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        {{ project.department?.name || '-----' }}
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        {{ project.specialization?.name || '-----' }}
                                    </td>
                                    <td class="text-center align-middle">
                                        {{ project.creator?.name || '-----' }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <select
                                            :value="project.status"
                                            @change="updateStatus(project, $event.target.value)"
                                            :class="[
                                                'tw-text-sm tw-text-center tw-font-medium tw-px-3 tw-py-1.5 tw-rounded-full tw-border-0 tw-cursor-pointer tw-appearance-none hover:tw-opacity-80 focus:tw-outline-none focus:tw-ring-2 focus:tw-ring-offset-1',
                                                project.status === 'Proposed'
                                                    ? 'tw-text-yellow-800 tw-bg-yellow-100 focus:tw-ring-yellow-500'
                                                    : '',
                                                project.status === 'Approved'
                                                    ? 'tw-text-green-800 tw-bg-green-100 focus:tw-ring-green-500'
                                                    : '',
                                                project.status === 'Rejected'
                                                    ? 'tw-text-red-800 tw-bg-red-100 focus:tw-ring-red-500'
                                                    : '',
                                            ]"
                                            style="width: auto; display: inline-block; background-image: none"
                                        >
                                            <option value="Proposed" class="tw-bg-white tw-text-gray-800">
                                                Proposed
                                            </option>
                                            <option value="Approved" class="tw-bg-white tw-text-gray-800">
                                                Approved
                                            </option>
                                            <option value="Rejected" class="tw-bg-white tw-text-gray-800">
                                                Rejected
                                            </option>
                                        </select>
                                    </td>
                                    <td class="text-center align-middle">
                                        <Link
                                            :href="route('projects.show', project)"
                                            class="btn btn-primary btn-sm me-2"
                                        >
                                            <i class="ri-eye-fill"></i>
                                        </Link>
                                        <Link :href="route('projects.edit', project)" class="btn btn-info btn-sm me-2">
                                            <i class="ri-pencil-fill"></i>
                                        </Link>
                                        <a
                                            @click.prevent="deleteProject(project)"
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
                                    <template v-for="(link, index) in projects.links">
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

    <!-- Import Modal -->
    <div
        ref="importModal"
        class="modal fade"
        id="importModal"
        tabindex="-1"
        aria-labelledby="importModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="importModalLabel">Import Projects</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form @submit.prevent="submitImport">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="importFile" class="form-label">
                                Select Excel File <span class="text-danger">*</span>
                            </label>
                            <input
                                type="file"
                                class="form-control"
                                id="importFile"
                                accept=".xlsx,.xls,.csv"
                                @change="handleFileChange"
                                :class="{
                                    'border-2 border-danger': importForm.errors.file,
                                }"
                                required
                            />
                            <span v-if="importForm.errors.file" class="text-danger">
                                {{ importForm.errors.file }}
                            </span>
                            <small class="form-text text-muted"> Accepted formats: .xlsx, .xls, .csv </small>
                        </div>
                        <div class="alert alert-info">
                            <strong>Expected columns:</strong> title, description, project_type, status,
                            department_short_name, specialization_short_name
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" :disabled="importForm.processing">
                            <span v-if="importForm.processing"> <i class="ri-loader-4-line"></i> Importing... </span>
                            <span v-else> <i class="ri-upload-line"></i> Import </span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
