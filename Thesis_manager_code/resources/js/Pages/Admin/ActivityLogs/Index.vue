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
import moment from 'moment-timezone';
import { reactive, ref, watch } from 'vue';

// Helpers composable
const { formatDate, currentRow, formatRangePicker } = useHelpers();

const props = defineProps({
    logs: {
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
    field: props.filters.field ?? 'created_at',
    direction: props.filters.direction ?? 'desc',
    date_range: props.filters.date_range ?? '',
});

// Watch the params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(
            route('activity-logs.index'),
            {
                ...pickBy(params),
                date_range: params.date_range
                    ? [
                          moment(params.date_range[0]).format('YYYY-MM-DD'),
                          moment(params.date_range[1]).format('YYYY-MM-DD'),
                      ]
                    : '',
            },
            {
                preserveScroll: true,
                preserveState: true,
            },
        );
    }, 300),
    { deep: true },
);

// Sort the table
let sort = (field) => {
    params.field = field;
    params.direction = params.direction === 'asc' ? 'desc' : 'asc';
};

// Clear table search
let clearSearch = () => {
    params.search = '';
};

// Delete log
const deleteLog = (log) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('activity-logs.destroy', log), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Activity Deleted!',
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

// Multi delete
let selected_ids = ref([]);

const selectAllIds = () => {
    if (selected_ids.value.length === 0) {
        selected_ids.value = props.logs.data.map((log) => log.id);
    } else {
        selected_ids.value = [];
    }
};

const deleteMultiple = () => {
    let { Toast, AlertWithButtons } = useAlert();

    if (!(selected_ids.value.length > 0)) {
        return;
    }

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(
                route('activity-logs.destroy.multiple', {
                    selected_ids: selected_ids.value,
                }),
                {
                    preserveScroll: true,
                    onSuccess: () => {
                        Toast.fire({
                            icon: 'warning',
                            title: 'Selected Activities Deleted!',
                        });
                        selected_ids.value = [];
                    },
                    onError: () => {
                        Toast.fire({
                            icon: 'danger',
                            title: 'Something Went Wrong!',
                        });
                    },
                },
            );
        }
    });
};
</script>

<template>
    <Head>
        <title>Expenses</title>
    </Head>

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Activity Logs</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2">
                            <button @click.prevent="deleteMultiple" class="btn btn-danger d-flex align-items-center">
                                <span>Delete Selected</span>
                                <i class="ri-delete-bin-2-fill ms-2"></i>
                            </button>
                        </div>
                        <div class="col-md-5">
                            <v-datepicker
                                v-model="params.date_range"
                                :placeholder="'Select date range'"
                                :teleport="true"
                                :enable-time-picker="false"
                                :format="formatRangePicker"
                                range
                            >
                            </v-datepicker>
                        </div>
                        <div class="col-md-5">
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
                                    <th
                                        @click.prevent="selectAllIds"
                                        class="border-0 rounded-start text-center align-middle cursor-pointer"
                                    >
                                        All <i class="ri-check-double-line text-danger"></i>
                                    </th>
                                    <th class="border-0 text-center align-middle">No.</th>
                                    <th
                                        @click="sort('created_at')"
                                        class="border-0 text-center align-middle cursor-pointer d-flex align-items-center justify-content-center"
                                    >
                                        <span class="me-2">Activity Time</span>
                                        <span v-if="params.field === 'created_at' && params.direction === 'asc'"
                                            ><i class="ri-sort-asc text-secondary"></i
                                        ></span>
                                        <span v-if="params.field === 'created_at' && params.direction === 'desc'"
                                            ><i class="ri-sort-desc text-secondary"></i
                                        ></span>
                                    </th>
                                    <th class="border-0 text-center align-middle">Where</th>
                                    <th class="border-0 text-center align-middle">Comment</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(logs.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="6">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(log, index) in logs.data" :key="log.id">
                                    <td class="text-center align-middle">
                                        <div class="form-check d-flex justify-content-center">
                                            <input
                                                v-model="selected_ids"
                                                class="form-check-input cursor-pointer"
                                                type="checkbox"
                                                :value="log.id"
                                                :id="'row' + log.id"
                                            />
                                            <label class="form-check-label cursor-pointer" :for="'row' + log.id">
                                            </label>
                                        </div>
                                    </td>
                                    <td class="text-center align-middle">{{ currentRow(index, logs) }}</td>
                                    <td class="text-center align-middle">
                                        {{ formatDate(log.created_at, 'DD-MM-YYYY, h:mm A') }}
                                    </td>
                                    <td class="text-center align-middle">{{ log.log_name }}</td>
                                    <td class="text-center align-middle" style="max-width: 400px; text-wrap: wrap">
                                        {{ log.description }}
                                    </td>
                                    <td class="text-center align-middle">
                                        <a
                                            @click.prevent="deleteLog(log)"
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
                                <div class="show-text me-2">Showing</div>
                                <select
                                    v-model="params.per_page"
                                    class="show-select form-select px-3 py-1"
                                    id="perPage"
                                >
                                    <option value="10">10</option>
                                    <option value="30">30</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-6 offset-md-4 d-flex justify-content-md-end">
                            <nav>
                                <ul class="pagination pagination-sm">
                                    <template v-for="link in logs.links">
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

<style scoped>
.search-bar .form-control {
    padding: 0.6rem 1rem;
    font-size: 0.875rem;
    width: 280px;
    transition: width 0.2s ease-in-out;
}
</style>
