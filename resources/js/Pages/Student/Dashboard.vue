<script>
import MainLayout from '@/Layouts/MainLayout.vue';

export default {
    layout: MainLayout,
};
</script>

<template>
    <Head title="Student Dashboard" />

    <div class="container-fluid">
        <!-- Welcome Section -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm bg-gradient-primary text-white">
                    <div class="card-body py-4">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h2 class="mb-2 fw-bold">Welcome, {{ $page.props.auth.user.name }}!</h2>
                                <p class="mb-0 opacity-90">
                                    Student Dashboard - Track your thesis projects and defenses
                                </p>
                            </div>
                            <div class="col-md-4 text-end">
                                <i class="ri-graduation-cap-line display-4 opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2 fw-semibold">Total Projects</h6>
                                <h2 class="mb-0 fw-bold text-primary">{{ statistics.total_projects }}</h2>
                            </div>
                            <div class="icon-shape icon-md bg-primary-100">
                                <i class="ri-folder-line text-primary fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2 fw-semibold">Approved</h6>
                                <h2 class="mb-0 fw-bold text-success">{{ statistics.approved_projects }}</h2>
                            </div>
                            <div class="icon-shape icon-md bg-success-100">
                                <i class="ri-checkbox-circle-line text-success fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2 fw-semibold">Pending</h6>
                                <h2 class="mb-0 fw-bold text-warning">{{ statistics.pending_projects }}</h2>
                            </div>
                            <div class="icon-shape icon-md bg-warning-100">
                                <i class="ri-time-line text-warning fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2 fw-semibold">Defenses</h6>
                                <h2 class="mb-0 fw-bold text-info">{{ statistics.total_defenses }}</h2>
                            </div>
                            <div class="icon-shape icon-md bg-info-100">
                                <i class="ri-presentation-line text-info fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- My Projects & My Defenses -->
        <div class="row">
            <div class="col-lg-6 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-transparent border-0 pb-0">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <h5 class="mb-1 fw-semibold text-dark">My Projects</h5>
                                <p class="text-muted small mb-0">Your submitted project proposals</p>
                            </div>
                            <i class="ri-file-list-3-line text-primary fs-4"></i>
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
                                    <tr v-for="project in myProjects" :key="project.id">
                                        <td>
                                            <div>
                                                <h6 class="mb-0 text-truncate" style="max-width: 200px">
                                                    {{ project.title }}
                                                </h6>
                                                <small class="text-muted">{{ project.department.name }}</small>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">{{ project.project_type }}</span>
                                        </td>
                                        <td>
                                            <span
                                                :class="`badge ${
                                                    project.status === 'approved'
                                                        ? 'bg-success'
                                                        : project.status === 'declined'
                                                        ? 'bg-danger'
                                                        : 'bg-warning'
                                                }`"
                                            >
                                                {{ project.status.charAt(0).toUpperCase() + project.status.slice(1) }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr v-if="!myProjects || myProjects.length === 0">
                                        <td colspan="3" class="text-center text-muted">No projects yet</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-transparent border-0 pb-0">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <h5 class="mb-1 fw-semibold text-dark">My Defenses</h5>
                                <p class="text-muted small mb-0">Your thesis defense sessions</p>
                            </div>
                            <i class="ri-calendar-event-line text-success fs-4"></i>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Project</th>
                                        <th>Type</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="defense in myDefenses" :key="defense.id">
                                        <td>
                                            <div>
                                                <h6 class="mb-0 text-truncate" style="max-width: 180px">
                                                    {{ defense.project?.title || 'N/A' }}
                                                </h6>
                                                <small class="text-muted">{{
                                                    defense.project?.department?.name
                                                }}</small>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-info text-capitalize">
                                                {{ defense.discussion_type }}
                                            </span>
                                        </td>
                                        <td>
                                            <span
                                                :class="`badge ${
                                                    defense.status === 'completed'
                                                        ? 'bg-success'
                                                        : defense.status === 'scheduled'
                                                        ? 'bg-info'
                                                        : defense.status === 'cancelled'
                                                        ? 'bg-danger'
                                                        : 'bg-secondary'
                                                }`"
                                            >
                                                {{ defense.status.charAt(0).toUpperCase() + defense.status.slice(1) }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr v-if="!myDefenses || myDefenses.length === 0">
                                        <td colspan="3" class="text-center text-muted">No defenses yet</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { Head } from '@inertiajs/vue3';

defineProps({
    statistics: Object,
    myProjects: Array,
    myDefenses: Array,
});
</script>

<style scoped>
.card-hover {
    transition: all 0.3s ease;
}

.card-hover:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15) !important;
}

.icon-shape {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 3rem;
    height: 3rem;
    border-radius: 0.5rem;
}

.bg-primary-100 {
    background-color: rgba(13, 110, 253, 0.1);
}

.bg-success-100 {
    background-color: rgba(25, 135, 84, 0.1);
}

.bg-warning-100 {
    background-color: rgba(255, 193, 7, 0.1);
}

.bg-info-100 {
    background-color: rgba(13, 202, 240, 0.1);
}

.bg-gradient-primary {
    background: linear-gradient(135deg, #007bff, #0056b3);
}
</style>
