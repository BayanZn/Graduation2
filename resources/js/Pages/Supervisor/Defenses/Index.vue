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
    defenses: {
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
        router.get(route('supervisor.defenses.index'), pickBy(params), {
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

// Update defense status
const updateStatus = (defense, newStatus) => {
    let { Toast } = useAlert();

    router.patch(
        route('supervisor.defenses.update-status', defense.id),
        { status: newStatus },
        {
            preserveScroll: true,
            onSuccess: () => {
                Toast.fire({
                    icon: 'success',
                    title: 'Status Updated!',
                });
            },
        },
    );
};

// Helper to format date
const formatDate = (date) => {
    return new Date(date).toLocaleString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
};

// Helper to get status badge class
const getStatusClass = (status) => {
    const classes = {
        scheduled: 'bg-primary',
        completed: 'bg-success',
        cancelled: 'bg-danger',
    };
    return classes[status] || 'bg-secondary';
};

// Helper to get type badge class
const getTypeClass = (type) => {
    const classes = {
        proposal: 'bg-info',
        seminar: 'bg-warning',
        final: 'bg-success',
    };
    return classes[type] || 'bg-secondary';
};
</script>

<template>
    <Head title="Defense Evaluations" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Defense Evaluations</li>
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
                                    <th class="border-0 text-center align-middle">Project Title</th>
                                    <th class="border-0 text-center align-middle">Department</th>
                                    <th class="border-0 text-center align-middle">Hall</th>
                                    <th class="border-0 text-center align-middle">Date</th>
                                    <th class="border-0 text-center align-middle">Type</th>
                                    <th class="border-0 text-center align-middle">Status</th>
                                    <th class="border-0 text-center align-middle">Committee Members</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(defenses.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="9">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(defense, index) in defenses.data" :key="defense.id">
                                    <td class="text-center align-middle">{{ currentRow(index, defenses) }}</td>
                                    <td class="text-center align-middle text-wrap">{{ defense.project?.title }}</td>
                                    <td class="text-center align-middle">
                                        {{ defense.project?.department?.name || '-----' }}
                                    </td>
                                    <td class="text-center align-middle">{{ defense.discussion_hall }}</td>
                                    <td class="text-center align-middle text-wrap">
                                        {{ formatDate(defense.discussion_date) }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <span :class="`badge ${getTypeClass(defense.discussion_type)}`">
                                            {{ defense.discussion_type.toUpperCase() }}
                                        </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <select
                                            :value="defense.status"
                                            @change="updateStatus(defense, $event.target.value)"
                                            :class="[
                                                'tw-text-sm tw-text-center tw-font-medium tw-px-3 tw-py-1.5 tw-rounded-full tw-border-0 tw-cursor-pointer tw-appearance-none hover:tw-opacity-80 focus:tw-outline-none focus:tw-ring-2 focus:tw-ring-offset-1',
                                                defense.status === 'scheduled'
                                                    ? 'tw-text-blue-800 tw-bg-blue-100 focus:tw-ring-blue-500'
                                                    : '',
                                                defense.status === 'completed'
                                                    ? 'tw-text-green-800 tw-bg-green-100 focus:tw-ring-green-500'
                                                    : '',
                                                defense.status === 'cancelled'
                                                    ? 'tw-text-red-800 tw-bg-red-100 focus:tw-ring-red-500'
                                                    : '',
                                            ]"
                                            style="width: auto; display: inline-block; background-image: none"
                                        >
                                            <option value="scheduled" class="tw-bg-white tw-text-gray-800">
                                                Scheduled
                                            </option>
                                            <option value="completed" class="tw-bg-white tw-text-gray-800">
                                                Completed
                                            </option>
                                            <option value="cancelled" class="tw-bg-white tw-text-gray-800">
                                                Cancelled
                                            </option>
                                        </select>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        <div v-if="defense.members && defense.members.length > 0">
                                            <span
                                                v-for="member in defense.members"
                                                :key="member.id"
                                                class="badge bg-success me-1 mb-1"
                                                style="font-size: 0.8rem"
                                            >
                                                {{ member.name }}
                                            </span>
                                        </div>
                                        <span v-else class="text-muted">No members</span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <Link
                                            :href="route('supervisor.defenses.show', defense)"
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
                                    <template v-for="(link, index) in defenses.links">
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
