<script>
import MainLayout from '@/Layouts/MainLayout.vue';

export default {
    layout: MainLayout,
};
</script>

<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { Chart, registerables } from 'chart.js';
import { onMounted, ref } from 'vue';

// Register Chart.js components
Chart.register(...registerables);

const props = defineProps({
    overview: Object,
    projectsByStatus: Object,
    projectsByType: Object,
    projectsBySpecialization: Array,
    projectsByDepartment: Array,
    defenseStats: Object,
    defensesByType: Object,
    recentProjects: Array,
    upcomingDefenses: Array,
    statusBySpecialization: Object,
    typeBySpecialization: Object,
    supervisorWorkload: Array,
});

// Chart refs
const statusChartRef = ref(null);
const typeChartRef = ref(null);
const specializationChartRef = ref(null);
const departmentChartRef = ref(null);
const defenseChartRef = ref(null);
const supervisorChartRef = ref(null);

// Initialize charts after component mounts
onMounted(() => {
    // Projects by Status Chart
    if (statusChartRef.value) {
        new Chart(statusChartRef.value, {
            type: 'doughnut',
            data: {
                labels: Object.keys(props.projectsByStatus || {}),
                datasets: [
                    {
                        label: 'Projects',
                        data: Object.values(props.projectsByStatus || {}),
                        backgroundColor: ['#ffc107', '#28a745', '#dc3545'],
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                },
            },
        });
    }

    // Projects by Type Chart
    if (typeChartRef.value) {
        new Chart(typeChartRef.value, {
            type: 'doughnut',
            data: {
                labels: Object.keys(props.projectsByType || {}),
                datasets: [
                    {
                        label: 'Projects',
                        data: Object.values(props.projectsByType || {}),
                        backgroundColor: ['#17a2b8', '#007bff', '#28a745'],
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                },
            },
        });
    }

    // Projects by Specialization Chart
    if (specializationChartRef.value) {
        new Chart(specializationChartRef.value, {
            type: 'bar',
            data: {
                labels: props.projectsBySpecialization?.map((item) => item.short_name) || [],
                datasets: [
                    {
                        label: 'Projects',
                        data: props.projectsBySpecialization?.map((item) => item.count) || [],
                        backgroundColor: '#007bff',
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false,
                    },
                },
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    }

    // Projects by Department Chart
    if (departmentChartRef.value) {
        new Chart(departmentChartRef.value, {
            type: 'bar',
            data: {
                labels: props.projectsByDepartment?.map((item) => item.short_name) || [],
                datasets: [
                    {
                        label: 'Projects',
                        data: props.projectsByDepartment?.map((item) => item.count) || [],
                        backgroundColor: '#28a745',
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false,
                    },
                },
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    }

    // Defense Statistics Chart
    if (defenseChartRef.value) {
        new Chart(defenseChartRef.value, {
            type: 'doughnut',
            data: {
                labels: Object.keys(props.defenseStats || {}).map((key) => key.charAt(0).toUpperCase() + key.slice(1)),
                datasets: [
                    {
                        label: 'Defenses',
                        data: Object.values(props.defenseStats || {}),
                        backgroundColor: ['#17a2b8', '#28a745', '#dc3545'],
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                },
            },
        });
    }

    // Supervisor Workload Chart
    if (supervisorChartRef.value) {
        new Chart(supervisorChartRef.value, {
            type: 'bar',
            data: {
                labels: props.supervisorWorkload?.map((item) => item.name) || [],
                datasets: [
                    {
                        label: 'Projects Supervised',
                        data: props.supervisorWorkload?.map((item) => item.count) || [],
                        backgroundColor: '#6f42c1',
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                indexAxis: 'y',
                plugins: {
                    legend: {
                        display: false,
                    },
                },
                scales: {
                    x: {
                        beginAtZero: true,
                    },
                },
            },
        });
    }
});

// Get status badge class
const getStatusClass = (status) => {
    const classes = {
        Proposed: 'bg-warning',
        Approved: 'bg-success',
        Rejected: 'bg-danger',
        Completed: 'bg-primary',
    };
    return classes[status] || 'bg-secondary';
};

// Get type badge class
const getTypeClass = (type) => {
    const classes = {
        Semester: 'bg-info',
        'Graduation 1': 'bg-primary',
        'Graduation 2': 'bg-success',
    };
    return classes[type] || 'bg-secondary';
};

// Format date
const formatDate = (dateString) => {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
};
</script>

<template>
    <Head title="Dashboard" />

    <!-- Welcome Section -->
    <div class="row">
        <div class="col-12">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                <div>
                    <h1 class="h2 mb-2 fw-bold text-dark">Hi, {{ $page.props.auth.user.name }}</h1>
                    <p class="text-muted mb-4">
                        Welcome back! Here's what's happening with your thesis management system.
                    </p>
                </div>
                <div class="mt-3 mt-md-0">
                    <span class="badge bg-primary fs-6 px-3 py-2">
                        <i class="ri-time-line me-1"></i>
                        {{
                            new Date().toLocaleDateString('en-US', {
                                weekday: 'long',
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric',
                            })
                        }}
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Overview Cards -->
    <div class="row">
        <div class="col-xl-3 col-sm-6 mb-4">
            <div class="card border-0 shadow-sm h-100 card-hover">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="icon-shape icon-lg icon-shape-primary rounded-3 me-3">
                                <i class="ri-folder-line fs-4"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="text-muted text-uppercase fw-semibold mb-1 tracking-wider">Total Projects</h6>
                            <h2 class="mb-0 fw-bold display-6 text-dark">{{ overview.total_projects }}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-4">
            <div class="card border-0 shadow-sm h-100 card-hover">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="icon-shape icon-lg icon-shape-success rounded-3 me-3">
                                <i class="ri-group-line fs-4"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="text-muted text-uppercase fw-semibold mb-1 tracking-wider">Total Students</h6>
                            <h2 class="mb-0 fw-bold display-6 text-dark">{{ overview.total_students }}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-4">
            <div class="card border-0 shadow-sm h-100 card-hover">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="icon-shape icon-lg icon-shape-info rounded-3 me-3">
                                <i class="ri-user-star-line fs-4"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="text-muted text-uppercase fw-semibold mb-1 tracking-wider">Total Supervisors</h6>
                            <h2 class="mb-0 fw-bold display-6 text-dark">{{ overview.total_supervisors }}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-4">
            <div class="card border-0 shadow-sm h-100 card-hover">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="icon-shape icon-lg icon-shape-warning rounded-3 me-3">
                                <i class="ri-calendar-event-line fs-4"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="text-muted text-uppercase fw-semibold mb-1 tracking-wider">Pending Defenses</h6>
                            <h2 class="mb-0 fw-bold display-6 text-dark">{{ overview.pending_defenses }}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 1 -->
    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm chart-card">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Projects by Status</h5>
                            <p class="text-muted small mb-0">Current distribution of project approval status</p>
                        </div>
                        <i class="ri-pie-chart-line text-primary fs-4"></i>
                    </div>
                </div>
                <div class="card-body pt-2">
                    <div style="height: 320px; position: relative">
                        <canvas ref="statusChartRef"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm chart-card">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Projects by Type/Level</h5>
                            <p class="text-muted small mb-0">Academic level breakdown of projects</p>
                        </div>
                        <i class="ri-donut-chart-line text-success fs-4"></i>
                    </div>
                </div>
                <div class="card-body pt-2">
                    <div style="height: 320px; position: relative">
                        <canvas ref="typeChartRef"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 2 -->
    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm chart-card">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Projects by Specialization</h5>
                            <p class="text-muted small mb-0">Distribution across academic specializations</p>
                        </div>
                        <i class="ri-bar-chart-line text-info fs-4"></i>
                    </div>
                </div>
                <div class="card-body pt-2">
                    <div style="height: 320px; position: relative">
                        <canvas ref="specializationChartRef"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm chart-card">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Projects by Department</h5>
                            <p class="text-muted small mb-0">Departmental project distribution</p>
                        </div>
                        <i class="ri-bar-chart-2-line text-warning fs-4"></i>
                    </div>
                </div>
                <div class="card-body pt-2">
                    <div style="height: 320px; position: relative">
                        <canvas ref="departmentChartRef"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 3 -->
    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm chart-card">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Defense Statistics</h5>
                            <p class="text-muted small mb-0">Status breakdown of thesis defenses</p>
                        </div>
                        <i class="ri-calendar-check-line text-danger fs-4"></i>
                    </div>
                </div>
                <div class="card-body pt-2">
                    <div style="height: 320px; position: relative">
                        <canvas ref="defenseChartRef"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm chart-card">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Top Supervisors by Workload</h5>
                            <p class="text-muted small mb-0">Most active supervisors by project count</p>
                        </div>
                        <i class="ri-team-line text-purple fs-4"></i>
                    </div>
                </div>
                <div class="card-body pt-2">
                    <div style="height: 320px; position: relative">
                        <canvas ref="supervisorChartRef"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Projects & Upcoming Defenses -->
    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Recent Projects</h5>
                            <p class="text-muted small mb-0">Latest submitted project proposals</p>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <i class="ri-file-list-3-line text-primary fs-4"></i>
                            <Link :href="route('projects.index')" class="btn btn-sm btn-primary">
                                View All <i class="ri-arrow-right-line"></i>
                            </Link>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="project in recentProjects" :key="project.id">
                                    <td>
                                        <Link :href="route('projects.show', project.id)" class="text-decoration-none">
                                            {{ project.title }}
                                        </Link>
                                    </td>
                                    <td>
                                        <span class="badge" :class="getTypeClass(project.project_type)">
                                            {{ project.project_type }}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge" :class="getStatusClass(project.status)">
                                            {{ project.status }}
                                        </span>
                                    </td>
                                </tr>
                                <tr v-if="!recentProjects || recentProjects.length === 0">
                                    <td colspan="3" class="text-center text-muted">No recent projects</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-transparent border-0 pb-0">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-1 fw-semibold text-dark">Upcoming Defenses</h5>
                            <p class="text-muted small mb-0">Scheduled thesis defense sessions</p>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <i class="ri-calendar-event-line text-success fs-4"></i>
                            <Link :href="route('defenses.index')" class="btn btn-sm btn-primary">
                                View All <i class="ri-arrow-right-line"></i>
                            </Link>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Project</th>
                                    <th>Type</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="defense in upcomingDefenses" :key="defense.id">
                                    <td>
                                        <Link :href="route('defenses.show', defense.id)" class="text-decoration-none">
                                            {{ defense.project?.title || 'N/A' }}
                                        </Link>
                                    </td>
                                    <td>
                                        <span class="badge bg-info text-capitalize">
                                            {{ defense.discussion_type }}
                                        </span>
                                    </td>
                                    <td>
                                        <small>{{ formatDate(defense.discussion_date) }}</small>
                                    </td>
                                </tr>
                                <tr v-if="!upcomingDefenses || upcomingDefenses.length === 0">
                                    <td colspan="3" class="text-center text-muted">No upcoming defenses</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* Only keep styles that aren't easily replaceable with Tailwind */
.text-purple {
    color: #6f42c1 !important;
}
</style>
