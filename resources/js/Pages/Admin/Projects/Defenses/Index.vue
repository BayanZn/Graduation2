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
import { reactive, watch, ref, computed } from 'vue';

/* Calendar */
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

/* Tooltip */
import tippy from 'tippy.js';
import 'tippy.js/dist/tippy.css';

/* PDF Export */
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';

const { currentRow } = useHelpers();

const props = defineProps({
    defenses: { type: Object },
    filters: { type: Object },
});

let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
    type: '',
});

// Show calendar or table
const showCalendar = ref(true);

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('defenses.index'), pickBy(params), {
            preserveScroll: true,
            preserveState: true,
        });
    }, 300),
    { deep: true },
);

let clearSearch = () => {
    params.search = '';
};

// Remove member from defense
const removeMember = (defense, member) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Remove Member?',
        text: `Remove ${member.name} from this defense?`,
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('defenses.remove-member', { defense: defense.id, user: member.id }), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Member Removed!',
                    });
                },
            });
        }
    });
};

// Update defense status
const updateStatus = (defense, newStatus) => {
    let { Toast, AlertWithButtons } = useAlert();

    const statusText = newStatus.charAt(0).toUpperCase() + newStatus.slice(1);

    AlertWithButtons.fire({
        title: `Mark as ${statusText}?`,
        text: `Change defense status to ${statusText}?`,
        icon: 'question',
    }).then((result) => {
        if (result.isConfirmed) {
            router.patch(
                route('defenses.update-status', defense.id),
                { status: newStatus },
                {
                    preserveScroll: true,
                    onSuccess: () => {
                        Toast.fire({
                            icon: 'success',
                            title: `Status Updated to ${statusText}!`,
                        });
                    },
                },
            );
        }
    });
};

// Delete defense
const deleteDefense = (defense) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: 'This defense will be permanently deleted!',
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('defenses.destroy', defense), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Defense Deleted!',
                    });
                },
            });
        }
    });
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

// Helper to get type badge class
const getTypeClass = (type) => {
    const classes = {
        proposal: 'bg-info',
        seminar: 'bg-warning',
        final: 'bg-success',
    };
    return classes[type] || 'bg-secondary';
};

// Calendar events computed
const calendarEvents = computed(() => {
    return props.defenses.data
        .filter(d => !params.type || d.discussion_type === params.type)
        .map(d => {
            const members = d.members?.map(m => m.name).join(', ') || 'N/A';
            const students = d.project.students?.map(s => s.name).join(', ') || 'N/A';
            return {
                id: d.id,
                title: d.project.title,
                start: d.discussion_date,
                backgroundColor: d.discussion_type === 'proposal' ? '#0d6efd' :
                                 d.discussion_type === 'seminar'  ? '#ffc107' :
                                 d.discussion_type === 'final'    ? '#198754' : '#6c757d',
                borderColor: '#000',
                extendedProps: { hall: d.discussion_hall, type: d.discussion_type, members, students },
            };
        });
});

// Calendar options (reactive to allow updating events)
const calendarOptions = reactive({
    plugins: [dayGridPlugin, interactionPlugin],
    initialView: 'dayGridMonth',
    events: calendarEvents.value,
    height: 600,
    eventDidMount: (info) => {
        tippy(info.el, {
            content: `
                <b>${info.event.title}</b><br/>
                Hall: ${info.event.extendedProps.hall}<br/>
                Type: ${info.event.extendedProps.type}<br/>
                Members: ${info.event.extendedProps.members}<br/>
                Students: ${info.event.extendedProps.students}
            `,
            allowHTML: true,
            theme: 'light-border',
        });
    },
    eventClick(info) {
        router.visit(route('defenses.show', info.event.id));
    },
});

// Watch type filter to update calendar events dynamically
watch(() => params.type, () => {
    calendarOptions.events = calendarEvents.value;
});

// Export PDF
const exportPDF = () => {
    const doc = new jsPDF();
    doc.text('Defense Schedule List', 14, 15);
    autoTable(doc, {
        startY: 20,
        head: [['Project', 'Type', 'Date', 'Hall', 'Members', 'Students']],
        body: props.defenses.data.map(d => [
            d.project.title,
            d.discussion_type,
            formatDate(d.discussion_date),
            d.discussion_hall,
            d.members?.map(m => m.name).join(', ') || 'N/A',
            d.project.students?.map(s => s.name).join(', ') || 'N/A',
        ]),
    });
    doc.save('defenses.pdf');
};
</script>

<template>
    <Head title="Defense Scheduling" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Defense Scheduling</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Top Bar: toggle calendar/list & export PDF -->
    <div class="d-flex align-items-center justify-content-between mb-3">
        <div>
            <button class="btn btn-outline-primary me-2" @click="showCalendar = true">Calendar View</button>
            <button class="btn btn-outline-secondary" @click="showCalendar = false">List View</button>
        </div>
        <div>
            <button class="btn btn-danger" @click="exportPDF">Export PDF</button>
        </div>
    </div>

    <!-- Calendar -->
    <div v-if="showCalendar" class="card border-0 shadow mb-4">
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-6">
                    <select v-model="params.type" class="form-select">
                        <option value="">All Types</option>
                        <option value="proposal">Proposal</option>
                        <option value="seminar">Seminar</option>
                        <option value="final">Final</option>
                    </select>
                </div>
            </div>
            <FullCalendar :options="calendarOptions" />
        </div>
    </div>

    <!-- Table -->
    <div v-else class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <Link :href="route('defenses.create')" class="btn btn-primary">
                                Schedule Defense <i class="ri-add-line"></i>
                            </Link>
                        </div>
                        <div class="col-md-4">
                            <div class="navbar-search form-inline" id="navbar-search-main">
                                <div class="input-group input-group-merge search-bar">
                                    <input
                                        v-model="params.search"
                                        type="text"
                                        class="form-control"
                                        placeholder="Search ...."
                                    />
                                    <span v-if="!params.search" class="input-group-text">
                                        <i class="ri-search-line text-secondary"></i>
                                    </span>
                                    <span
                                        @click="clearSearch"
                                        v-else
                                        class="input-group-text"
                                        style="cursor: pointer"
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
                                    <th class="border-0 text-center align-middle">Hall</th>
                                    <th class="border-0 text-center align-middle">Date</th>
                                    <th class="border-0 text-center align-middle">Type</th>
                                    <th class="border-0 text-center align-middle">Status</th>
                                    <th class="border-0 text-center align-middle">Members</th>
                                    <th class="border-0 text-center align-middle">Students</th>
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
                                    <td class="text-center align-middle text-wrap">{{ defense.project.title }}</td>
                                    <td class="text-center align-middle">{{ defense.discussion_hall }}</td>
                                    <td class="text-center align-middle text-wrap">{{ formatDate(defense.discussion_date) }}</td>
                                    <td class="text-center align-middle">
                                        <span :class="`badge ${getTypeClass(defense.discussion_type)}`">
                                            {{ defense.discussion_type.toUpperCase() }}
                                        </span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <select
                                            :value="defense.status"
                                            @change="updateStatus(defense, $event.target.value)"
                                            class="tw-text-sm tw-text-center tw-font-medium tw-px-3 tw-py-1.5 tw-rounded-full tw-border-0 tw-cursor-pointer tw-appearance-none hover:tw-opacity-80 focus:tw-outline-none focus:tw-ring-2 focus:tw-ring-offset-1"
                                            style="width: auto; display: inline-block; background-image: none"
                                        >
                                            <option value="scheduled">Scheduled</option>
                                            <option value="completed">Completed</option>
                                            <option value="cancelled">Cancelled</option>
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
                                                <i
                                                    @click.prevent="removeMember(defense, member)"
                                                    class="ri-close-line ms-1"
                                                    style="cursor: pointer"
                                                ></i>
                                            </span>
                                        </div>
                                        <span v-else class="text-muted">No members</span>
                                    </td>
                                    <td class="text-center align-middle text-wrap">
                                        <div v-if="defense.project.students && defense.project.students.length > 0">
                                            <span
                                                v-for="student in defense.project.students"
                                                :key="student.id"
                                                class="badge bg-primary me-1 mb-1"
                                                style="font-size: 0.8rem"
                                            >
                                                {{ student.name }}
                                            </span>
                                        </div>
                                        <span v-else class="text-muted">No students</span>
                                    </td>
                                    <td class="text-center align-middle">
                                        <Link :href="route('defenses.show', defense)" class="btn btn-primary btn-sm me-2">
                                            <i class="ri-eye-fill"></i>
                                        </Link>
                                        <Link :href="route('defenses.edit', defense)" class="btn btn-info btn-sm me-2">
                                            <i class="ri-pencil-fill"></i>
                                        </Link>
                                        <a
                                            @click.prevent="deleteDefense(defense)"
                                            href=""
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
                                    <template v-for="(link, index) in defenses.links">
                                        <li v-if="link.url === null" class="page-item">
                                            <button class="page-link text-muted" tabindex="-1" v-html="link.label" disabled></button>
                                        </li>
                                        <li v-else class="page-item">
                                            <Link preserve-scroll class="page-link" :href="link.url" v-html="link.label" :class="{ active: link.active }"></Link>
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
