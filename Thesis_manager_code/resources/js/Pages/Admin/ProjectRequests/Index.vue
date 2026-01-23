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
import { computed, reactive, watch } from 'vue';

const { currentRow } = useHelpers();

const props = defineProps({
    requests: {
        type: Object,
    },
    filters: {
        type: Object,
    },
});

// Compute pending requests count
const pendingCount = computed(() => {
    return props.requests?.data?.filter((req) => req.status === 'pending').length || 0;
});

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
    status: props.filters.status ?? '',
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('project.requests.index'), pickBy(params), {
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
    <Head title="Project Requests" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Project Requests</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <!-- Pending Requests Alert -->
        <div v-if="pendingCount > 0" class="col-12 mb-3">
            <div class="alert alert-info d-flex align-items-center shadow-sm border-0" role="alert">
                <i class="ri-notification-4-line fs-4 me-3"></i>
                <div>
                    <strong>{{ pendingCount }}</strong> pending project request{{ pendingCount > 1 ? 's' : '' }} awaiting your review
                </div>
            </div>
        </div>

        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4 mb-3 mb-md-0">
                            <select v-model="params.status" class="form-select">
                                <option value="">All Statuses</option>
                                <option value="pending">
                                    Pending
                                    <span v-if="pendingCount > 0">({{ pendingCount }})</span>
                                </option>
                                <option value="approved">Approved</option>
                                <option value="rejected">Rejected</option>
                            </select>
                        </div>

                        <div class="col-md-4 offset-md-4">
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
                                    <th class="border-0 text-center align-middle">Student</th>
                                    <th class="border-0 text-center align-middle">Project</th>
                                    <th class="border-0 text-center align-middle">Type</th>
                                    <th class="border-0 text-center align-middle">Status</th>
                                    <th class="border-0 text-center align-middle">Requested Date</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(requests.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="7">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(request, index) in requests.data" :key="request.id">
                                    <td class="text-center align-middle">{{ currentRow(index, requests) }}</td>
                                    <td class="text-center align-middle">
                                        <div>
                                            <strong>{{ request.student?.name || 'N/A' }}</strong>
                                            <br />
                                            <small class="text-muted">{{ request.student?.email || 'N/A' }}</small>
                                        </div>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        {{ request.project?.title || 'N/A' }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <span
                                            :class="[
                                                'tw-text-sm tw-font-medium tw-px-3 tw-py-1.5 tw-rounded-full',
                                                request.request_type === 'individual'
                                                    ? 'tw-bg-blue-100 tw-text-blue-800'
                                                    : 'tw-bg-purple-100 tw-text-purple-800',
                                            ]"
                                        >
                                            {{ request.request_type }}
                                        </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <span
                                            :class="[
                                                'tw-text-sm tw-font-medium tw-px-3 tw-py-1.5 tw-rounded-full',
                                                request.status === 'pending'
                                                    ? 'tw-bg-yellow-100 tw-text-yellow-800'
                                                    : request.status === 'approved'
                                                    ? 'tw-bg-green-100 tw-text-green-800'
                                                    : 'tw-bg-red-100 tw-text-red-800',
                                            ]"
                                        >
                                            {{ request.status }}
                                        </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        {{ new Date(request.created_at).toLocaleDateString() }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <Link
                                            :href="route('project.requests.show', request.id)"
                                            class="btn btn-primary btn-sm"
                                        >
                                            <i class="ri-eye-fill"></i>
                                        </Link>
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
                                    <template v-for="(link, index) in requests.links">
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
    <!-- Page Content End -->
</template>
