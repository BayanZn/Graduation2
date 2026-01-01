<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { Head, Link } from '@inertiajs/vue3';

const props = defineProps({
    project: {
        type: Object,
    },
});

// Format date time
const formatDate = (dateString) => {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
};

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

// Defense type formatting
const getDefenseTypeLabel = (type) => {
    const types = {
        proposal: 'Proposal Defense',
        seminar: 'Seminar Defense',
        final: 'Final Defense',
    };
    return types[type] || type;
};

const getDefenseStatusClass = (status) => {
    const classes = {
        scheduled: 'bg-info',
        completed: 'bg-success',
        cancelled: 'bg-danger',
    };
    return classes[status] || 'bg-secondary';
};
</script>

<template>
    <Head title="Assignment Details" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('assignments.index')">Assignments</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Assignment Details</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row justify-content-center">
        <!-- Assignment Overview Card -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-git-branch-line text-primary me-2"></i>
                        Assignment Details
                    </h5>
                    <div class="d-flex gap-2 align-items-center flex-wrap">
                        <span class="badge fs-6 p-2" :class="getTypeClass(project.project_type)">
                            <i class="ri-book-line me-1"></i>{{ project.project_type }}
                        </span>
                        <span class="badge fs-6 p-2" :class="getStatusClass(project.status)">
                            <i class="ri-flag-line me-1"></i>{{ project.status }}
                        </span>
                        <Link :href="route('assignments.edit', project)" class="btn btn-sm btn-primary">
                            <i class="ri-pencil-line me-1"></i>Edit Assignment
                        </Link>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Project Information -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-folder-2-line me-2"></i>Project Information</h6>
                        <div class="border rounded p-3 bg-light">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <h3 class="text-primary mb-0">{{ project.title }}</h3>
                                <Link :href="route('projects.show', project)" class="btn btn-sm btn-outline-primary">
                                    <i class="ri-eye-line me-1"></i>View Full Project
                                </Link>
                            </div>
                            <div class="row">
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Project Type:</strong>
                                    <div>
                                        <span class="badge bg-info">{{ project.project_type }}</span>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Status:</strong>
                                    <div>
                                        <span class="badge" :class="getStatusClass(project.status)">
                                            {{ project.status }}
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Department:</strong>
                                    <div class="text-dark">{{ project.department?.name || 'N/A' }}</div>
                                </div>
                                <div class="col-md-12 mb-2 mt-2">
                                    <strong class="text-muted small">Specialization:</strong>
                                    <div class="text-dark">{{ project.specialization?.name || 'N/A' }}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Assignment Statistics -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-pie-chart-line me-2"></i>Assignment Statistics</h6>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-user-star-line text-primary fs-2 mb-2"></i>
                                    <h2 class="text-dark mb-1">{{ project.supervisors?.length || 0 }}</h2>
                                    <small class="text-muted">Assigned Supervisors</small>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-user-3-line text-success fs-2 mb-2"></i>
                                    <h2 class="text-dark mb-1">{{ project.students?.length || 0 }}</h2>
                                    <small class="text-muted">Assigned Students</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Assigned Supervisors -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-star-line me-2"></i>Assigned Supervisors</h6>
                        <div v-if="project.supervisors && project.supervisors.length > 0" class="row">
                            <div
                                v-for="(supervisor, index) in project.supervisors"
                                :key="supervisor.id"
                                class="col-md-6 mb-3"
                            >
                                <div class="border rounded p-3 bg-light d-flex align-items-center">
                                    <div class="avatar-lg me-3">
                                        <img
                                            :src="
                                                supervisor.media.length === 0
                                                    ? 'https://gravatar.com/avatar/placeholder'
                                                    : supervisor.media[0]?.original_url
                                            "
                                            class="rounded-circle object-contain"
                                            alt="Supervisor"
                                            width="50"
                                            height="50"
                                        />
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0 text-dark">{{ supervisor.name }}</h6>
                                        <small class="text-muted">{{ supervisor.email }}</small>
                                    </div>
                                    <div>
                                        <span class="badge bg-primary">Supervisor</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-warning d-flex align-items-center">
                            <i class="ri-alert-line me-2 fs-5"></i>
                            <span>No supervisors assigned to this project.</span>
                        </div>
                    </div>

                    <!-- Assigned Students -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-3-line me-2"></i>Assigned Students</h6>
                        <div v-if="project.students && project.students.length > 0" class="row">
                            <div v-for="(student, index) in project.students" :key="student.id" class="col-md-6 mb-3">
                                <div class="border rounded p-3 bg-light d-flex align-items-center">
                                    <div class="avatar-lg me-3">
                                        <img
                                            :src="
                                                student.media.length === 0
                                                    ? 'https://gravatar.com/avatar/placeholder'
                                                    : student.media[0]?.original_url
                                            "
                                            class="rounded-circle object-contain"
                                            alt="Student"
                                            width="50"
                                            height="50"
                                        />
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0 text-dark">{{ student.name }}</h6>
                                        <small class="text-muted">{{ student.email }}</small>
                                    </div>
                                    <div>
                                        <span class="badge bg-success">Student</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-warning d-flex align-items-center">
                            <i class="ri-alert-line me-2 fs-5"></i>
                            <span>No students assigned to this project.</span>
                        </div>
                    </div>

                    <!-- Project Defenses -->
                    <div v-if="project.defenses && project.defenses.length > 0" class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-shield-check-line me-2"></i>Defense Schedule</h6>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Type</th>
                                        <th>Hall</th>
                                        <th>Date & Time</th>
                                        <th>Status</th>
                                        <th>Committee Members</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="defense in project.defenses" :key="defense.id">
                                        <td>
                                            <span class="badge bg-primary">
                                                {{ getDefenseTypeLabel(defense.discussion_type) }}
                                            </span>
                                        </td>
                                        <td>{{ defense.discussion_hall }}</td>
                                        <td>{{ formatDate(defense.discussion_date) }}</td>
                                        <td>
                                            <span class="badge" :class="getDefenseStatusClass(defense.status)">
                                                {{ defense.status }}
                                            </span>
                                        </td>
                                        <td>
                                            <span
                                                v-for="member in defense.members"
                                                :key="member.id"
                                                class="badge bg-success me-1"
                                            >
                                                {{ member.name }}
                                            </span>
                                        </td>
                                        <td>
                                            <Link
                                                :href="route('defenses.show', defense)"
                                                class="btn btn-primary btn-sm"
                                            >
                                                <i class="ri-eye-line"></i>
                                            </Link>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Project Description -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-file-text-line me-2"></i>Project Description</h6>
                        <div class="border rounded p-3 bg-light">
                            <div v-html="project.description" class="text-dark" style="line-height: 1.6"></div>
                        </div>
                    </div>

                    <!-- Record Information -->
                    <div class="border-top pt-3 mt-4">
                        <div class="row">
                            <div class="col-md-6">
                                <small class="text-muted">Assignment Created:</small>
                                <div class="text-dark">{{ formatDate(project.created_at) }}</div>
                            </div>
                            <div class="col-md-6">
                                <small class="text-muted">Last Updated:</small>
                                <div class="text-dark">{{ formatDate(project.updated_at) }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
