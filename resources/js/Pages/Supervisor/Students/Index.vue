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
    students: {
        type: Object,
    },
    filters: {
        type: Object,
    },
});

// Query parameters
let params = reactive({
    search: props.filters?.search ?? '',
    per_page: props.filters?.per_page ?? 10,
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('supervisor.students.index'), pickBy(params), {
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
</script>

<template>
    <Head title="Supervised Students" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Supervised Students</li>
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
                                    <th class="border-0 text-center align-middle">Name</th>
                                    <th class="border-0 text-center align-middle">Email</th>
                                    <th class="border-0 text-center align-middle">Assigned Projects</th>
                                    <th class="border-0 rounded-end text-center align-middle">Project Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(students.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="5">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(student, index) in students.data" :key="student.id">
                                    <td class="text-center align-middle">{{ currentRow(index, students) }}</td>
                                    <td class="text-center align-middle">{{ student.name }}</td>
                                    <td class="text-center align-middle">{{ student.email }}</td>
                                    <td class="text-center align-middle">
                                        {{ student.assignments?.length || 0 }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <div
                                            v-if="student.assignments && student.assignments.length > 0"
                                            class="d-flex flex-column gap-1"
                                        >
                                            <div
                                                v-for="assignment in student.assignments"
                                                :key="assignment.id"
                                                class="text-start"
                                            >
                                                <small class="fw-bold">{{ assignment.project?.title }}</small>
                                                <br />
                                                <span
                                                    :class="[
                                                        'tw-text-xs tw-font-medium tw-px-2 tw-py-0.5 tw-rounded-full',
                                                        assignment.project?.project_type === 'Semester'
                                                            ? 'tw-text-blue-700 tw-bg-blue-200'
                                                            : '',
                                                        assignment.project?.project_type === 'Graduation 1'
                                                            ? 'tw-text-purple-700 tw-bg-purple-200'
                                                            : '',
                                                        assignment.project?.project_type === 'Graduation 2'
                                                            ? 'tw-text-indigo-700 tw-bg-indigo-200'
                                                            : '',
                                                    ]"
                                                >
                                                    {{ assignment.project?.project_type }}
                                                </span>
                                                <span
                                                    :class="[
                                                        'tw-text-xs tw-font-medium tw-px-2 tw-py-0.5 tw-rounded-full ms-1',
                                                        assignment.project?.status === 'proposed'
                                                            ? 'tw-text-yellow-700 tw-bg-yellow-200'
                                                            : '',
                                                        assignment.project?.status === 'approved'
                                                            ? 'tw-text-green-700 tw-bg-green-200'
                                                            : '',
                                                        assignment.project?.status === 'declined'
                                                            ? 'tw-text-red-700 tw-bg-red-200'
                                                            : '',
                                                        assignment.project?.status === 'completed'
                                                            ? 'tw-text-blue-700 tw-bg-blue-200'
                                                            : '',
                                                    ]"
                                                >
                                                    {{
                                                        assignment.project?.status.charAt(0).toUpperCase() +
                                                        assignment.project?.status.slice(1)
                                                    }}
                                                </span>
                                            </div>
                                        </div>
                                        <span v-else class="text-muted">-----</span>
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
                                    <template v-for="(link, index) in students.links">
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
