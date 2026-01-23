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
import { Head, Link, router } from '@inertiajs/vue3';
import { debounce, pickBy } from 'lodash';
import { reactive, watch } from 'vue';

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
        router.get(route('assignments.index'), pickBy(params), {
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

// Remove supervisor from project
const removeSupervisor = (project, supervisor) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Remove Supervisor?',
        text: `Remove ${supervisor.name} from ${project.title}?`,
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('assignments.remove-supervisor', { project: project.id, user: supervisor.id }), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Supervisor Removed!',
                    });
                },
            });
        }
    });
};

// Remove student from project
const removeStudent = (project, student) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Remove Student?',
        text: `Remove ${student.name} from ${project.title}?`,
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('assignments.remove-student', { project: project.id, user: student.id }), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Student Removed!',
                    });
                },
            });
        }
    });
};

// Delete all assignments for project
const deleteAssignment = (project) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: 'This will remove all assignments for this project!',
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('assignments.destroy', project), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Assignment Deleted!',
                    });
                },
            });
        }
    });
};
</script>

<template>
    <Head title="Project Assignments" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Project Assignments</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <Link :href="route('assignments.create')" class="btn btn-primary">
                                Assign Project <i class="ri-add-line"></i>
                            </Link>
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
                                    <th class="border-0 text-center align-middle">Project Title</th>
                                    <th class="border-0 text-center align-middle">Type</th>
                                    <th class="border-0 text-center align-middle">Supervisors</th>
                                    <th class="border-0 text-center align-middle">Students</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(projects.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="6">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(project, index) in projects.data" :key="project.id">
                                    <td class="text-center align-middle">{{ currentRow(index, projects) }}</td>
                                    <td class="text-center align-middle text-wrap">{{ project.title }}</td>
                                    <td class="text-center align-middle">
                                        <span class="badge bg-info">{{ project.project_type }}</span>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        <div v-if="project.supervisors && project.supervisors.length > 0">
                                            <span
                                                v-for="supervisor in project.supervisors"
                                                :key="supervisor.id"
                                                class="badge bg-success me-1 mb-1"
                                                style="font-size: 0.8rem"
                                            >
                                                {{ supervisor.name }}
                                                <i
                                                    @click.prevent="removeSupervisor(project, supervisor)"
                                                    class="ri-close-line ms-1"
                                                    style="cursor: pointer"
                                                ></i>
                                            </span>
                                        </div>
                                        <span v-else class="text-muted">No supervisors</span>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        <div v-if="project.students && project.students.length > 0">
                                            <span
                                                v-for="student in project.students"
                                                :key="student.id"
                                                class="badge bg-primary me-1 mb-1"
                                                style="font-size: 0.8rem"
                                            >
                                                {{ student.name }}
                                                <i
                                                    @click.prevent="removeStudent(project, student)"
                                                    class="ri-close-line ms-1"
                                                    style="cursor: pointer"
                                                ></i>
                                            </span>
                                        </div>
                                        <span v-else class="text-muted">No students</span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <Link
                                            :href="route('assignments.show', project)"
                                            class="btn btn-primary btn-sm me-2"
                                        >
                                            <i class="ri-eye-fill"></i>
                                        </Link>
                                        <Link
                                            :href="route('assignments.edit', project)"
                                            class="btn btn-info btn-sm me-2"
                                        >
                                            <i class="ri-pencil-fill"></i>
                                        </Link>
                                        <a
                                            @click.prevent="deleteAssignment(project)"
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
</template>
