<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
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
        router.get(route('student.assigned-projects.index'), pickBy(params), {
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

// Helper functions for badges
const getTypeClass = (type) => {
    const classes = {
        Semester: 'bg-primary',
        'Graduation 1': 'bg-purple',
        'Graduation 2': 'bg-indigo',
    };
    return classes[type] || 'bg-secondary';
};

const getStatusClass = (status) => {
    const classes = {
        Proposed: 'bg-warning',
        Approved: 'bg-success',
        Rejected: 'bg-danger',
        Completed: 'bg-primary',
    };
    return classes[status] || 'bg-secondary';
};
</script>

<template>
    <Head title="My Assigned Projects" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item">
            <Link :href="route('student.dashboard')">Dashboard</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">My Assigned Projects</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 mb-3 mb-md-0"></div>

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
                                    <th class="border-0 text-center align-middle">Type</th>
                                    <th class="border-0 text-center align-middle">Supervisor(s)</th>
                                    <th class="border-0 text-center align-middle">Department</th>
                                    <th class="border-0 text-center align-middle">Status</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(projects.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="7">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(project, index) in projects.data" :key="project.id">
                                    <td class="text-center align-middle">{{ currentRow(index, projects) }}</td>
                                    <td class="text-center align-middle text-wrap">{{ project.title }}</td>
                                    <td class="text-center align-middle">
                                        <span :class="`badge ${getTypeClass(project.project_type)}`">
                                            {{ project.project_type }}
                                        </span>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        <div v-if="project.supervisors && project.supervisors.length > 0">
                                            <span
                                                v-for="supervisor in project.supervisors"
                                                :key="supervisor.id"
                                                class="badge bg-info me-1 mb-1"
                                                style="font-size: 0.8rem"
                                            >
                                                {{ supervisor.name }}
                                            </span>
                                        </div>
                                        <span v-else class="text-muted">No supervisors</span>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        {{ project.department?.name || '-----' }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <span :class="`badge ${getStatusClass(project.status)}`">
                                            {{ project.status }}
                                        </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <div class="d-flex gap-1 justify-content-center">
                                            <Link
                                                :href="route('student.assigned-projects.show', project)"
                                                class="btn btn-primary btn-sm"
                                                title="View Details"
                                            >
                                                <i class="ri-eye-fill"></i>
                                            </Link>
                                            <Link
                                                :href="
                                                    route('student.project-submissions.index', {
                                                        project_id: project.id,
                                                    })
                                                "
                                                class="btn btn-warning btn-sm"
                                                title="Submit Chapters"
                                            >
                                                <i class="ri-file-upload-fill"></i>
                                            </Link>
                                        </div>
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
                                    aria-label="Default select example"
                                >
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-10">
                            <div class="d-flex justify-content-md-end">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination mb-0">
                                        <li
                                            class="page-item"
                                            v-for="link in projects.links"
                                            :key="link.label"
                                            :class="{ active: link.active }"
                                        >
                                            <Link
                                                v-if="link.url"
                                                class="page-link"
                                                :href="link.url"
                                                preserveScroll
                                                v-html="link.label"
                                            />
                                            <span v-else class="page-link text-muted" v-html="link.label" />
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page Content End -->
</template>

<style scoped>
.min-h-table {
    min-height: 300px;
}
</style>
