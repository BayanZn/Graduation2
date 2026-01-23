<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { Head, Link } from '@inertiajs/vue3';
import { computed } from 'vue';

const props = defineProps({
    project: {
        type: Object,
        required: true,
    },
    gradeData: {
        type: Array,
        default: () => [],
    },
    totalGrade: {
        type: Number,
        default: 0,
    },
    maxTotalGrade: {
        type: Number,
        default: 100,
    },
});

// Format date time
const formatDate = (dateString) => {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
        month: 'short',
        day: 'numeric',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
};

// Get type badge class
const getTypeClass = (type) => {
    const classes = {
        proposal: 'bg-primary',
        seminar: 'bg-warning',
        code: 'bg-info',
        final: 'bg-success',
    };
    return classes[type] || 'bg-secondary';
};

// Calculate percentage
const percentage = computed(() => {
    if (props.maxTotalGrade === 0) return 0;
    return ((props.totalGrade / props.maxTotalGrade) * 100).toFixed(2);
});

// Format defense type name
const formatType = (type) => {
    const types = {
        proposal: 'Proposal Defense',
        seminar: 'Seminar Defense',
        code: 'Code Defense',
        final: 'Final Defense',
    };
    return types[type] || type;
};

// Export PDF
const exportPdf = () => {
    window.location.href = route('student.grades.export', props.project.id);
};
</script>

<template>
    <Head :title="`Grades - ${project.title}`" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('student.assigned-projects.index')">My Projects</Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('student.assigned-projects.show', project.id)">
                {{ project.title }}
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">My Grades</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row justify-content-center">
        <!-- Project Overview Card -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-trophy-line text-warning me-2"></i>
                        Project Grades
                    </h5>
                    <button @click="exportPdf" class="btn btn-primary">
                        <i class="ri-download-2-line me-1"></i>
                        Export PDF
                    </button>
                </div>
                <div class="card-body">
                    <!-- Project Information -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-folder-2-line me-2"></i>Project Information</h6>
                        <div class="border rounded p-3 bg-light">
                            <h4 class="text-primary mb-3">{{ project.title }}</h4>
                            <div class="row">
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Project Type:</strong>
                                    <div>
                                        <span class="badge bg-info">{{ project.project_type }}</span>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Department:</strong>
                                    <div class="text-dark">{{ project.department?.name || 'N/A' }}</div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Specialization:</strong>
                                    <div class="text-dark">{{ project.specialization?.name || 'N/A' }}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Total Grade Summary -->
                    <div class="mb-4">
                        <div class="border rounded p-4 text-center bg-gradient" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)">
                            <h5 class="text-white mb-2">Total Project Grade</h5>
                            <h1 class="text-white fw-bold mb-2">{{ totalGrade }} / {{ maxTotalGrade }}</h1>
                            <div class="fs-4 text-white">{{ percentage }}%</div>
                        </div>
                    </div>

                    <!-- Defense Grades -->
                    <div v-if="gradeData.length > 0" class="mb-4">
                        <h6 class="text-muted mb-3">
                            <i class="ri-file-list-3-line me-2"></i>Defense Breakdown
                        </h6>

                        <div
                            v-for="(defense, index) in gradeData"
                            :key="index"
                            class="card mb-3 border-0 shadow-sm"
                        >
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge me-2" :class="getTypeClass(defense.discussion_type)">
                                        {{ formatType(defense.discussion_type) }}
                                    </span>
                                    <span v-if="defense.graded_at" class="text-muted small">
                                        <i class="ri-time-line me-1"></i>
                                        Graded on {{ formatDate(defense.graded_at) }}
                                    </span>
                                </div>
                                <div class="fs-5 fw-bold text-primary">
                                    {{ defense.total_grade }} / {{ defense.max_grade }}
                                </div>
                            </div>
                            <div class="card-body">
                                <h6 class="text-muted mb-3">Committee Members Feedback</h6>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Member Name</th>
                                                <th>Grade</th>
                                                <th>Feedback</th>
                                                <th>Graded At</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr
                                                v-for="(memberGrade, mIndex) in defense.member_grades"
                                                :key="mIndex"
                                            >
                                                <td>{{ memberGrade.member_name }}</td>
                                                <td>
                                                    <span class="badge bg-success">
                                                        {{ memberGrade.grade || 'N/A' }}
                                                    </span>
                                                </td>
                                                <td>
                                                    <small>{{ memberGrade.feedback || 'No feedback' }}</small>
                                                </td>
                                                <td>
                                                    <small>{{ formatDate(memberGrade.graded_at) }}</small>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- No Grades Yet -->
                    <div v-else class="alert alert-info d-flex align-items-center">
                        <i class="ri-information-line me-2 fs-5"></i>
                        <span>No graded defenses yet. Grades will appear here once committee members submit their evaluations.</span>
                    </div>

                    <!-- Students List -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-team-line me-2"></i>Team Members</h6>
                        <div v-if="project.students && project.students.length > 0" class="row">
                            <div
                                v-for="(student, index) in project.students"
                                :key="student.id"
                                class="col-md-6 mb-3"
                            >
                                <div class="border rounded p-3 bg-light d-flex align-items-center">
                                    <div class="avatar-lg me-3">
                                        <img
                                            :src="
                                                student.media?.length === 0
                                                    ? 'https://gravatar.com/avatar/placeholder'
                                                    : student.media?.[0]?.original_url
                                            "
                                            class="rounded-circle object-contain"
                                            alt="Student"
                                            width="50"
                                            height="50"
                                        />
                                    </div>
                                    <div>
                                        <h6 class="mb-0 text-dark">{{ student.name }}</h6>
                                        <small class="text-muted">{{ student.email }}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
