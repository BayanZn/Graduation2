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
    submissions: {
        type: Array,
        default: () => [],
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

// Get chapter label
const getChapterLabel = (chapterType) => {
    const labels = {
        Introduction: 'Chapter 1: Introduction',
        'Literature Review': 'Chapter 2: Literature Review',
        Methodology: 'Chapter 3: Methodology',
        'Result & Analysis': 'Chapter 4: Result & Analysis',
        Conclusion: 'Chapter 5: Conclusion',
        Abstract: 'Abstract',
        'Full Draft': 'Full Draft',
    };
    return labels[chapterType] || chapterType;
};

// Download file
const downloadFile = (filePath) => {
    window.open(`/storage/${filePath}`, '_blank');
};
</script>

<template>
    <Head title="Project Details" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('projects.index')">Projects</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Project Details</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row justify-content-center">
        <!-- Project Overview Card -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-folder-2-line text-primary me-2"></i>
                        Project Details
                    </h5>
                    <div class="d-flex gap-2 align-items-center flex-wrap">
                        <span class="badge fs-6 p-2" :class="getTypeClass(project.project_type)">
                            <i class="ri-book-line me-1"></i>{{ project.project_type }}
                        </span>
                        <span class="badge fs-6 p-2" :class="getStatusClass(project.status)">
                            <i class="ri-flag-line me-1"></i>{{ project.status }}
                        </span>
                        <Link :href="route('projects.edit', project)" class="btn btn-sm btn-primary">
                            <i class="ri-pencil-line me-1"></i>Edit Project
                        </Link>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Project Title & Description -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-file-text-line me-2"></i>Project Information</h6>
                        <div class="border rounded p-3 bg-light">
                            <h3 class="text-primary mb-3">{{ project.title }}</h3>
                            <div v-html="project.description" class="text-dark" style="line-height: 1.6"></div>
                        </div>
                    </div>

                    <!-- Project Details -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-information-line me-2"></i>Project Classification</h6>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-building-line text-primary fs-2 mb-2"></i>
                                    <h5 class="text-dark mb-1">{{ project.department?.name || 'N/A' }}</h5>
                                    <small class="text-muted">Department</small>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-graduation-cap-line text-success fs-2 mb-2"></i>
                                    <h5 class="text-dark mb-1">{{ project.specialization?.name || 'N/A' }}</h5>
                                    <small class="text-muted">Specialization</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Project Supervisors -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-star-line me-2"></i>Project Supervisors</h6>
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
                                    <div>
                                        <h6 class="mb-0 text-dark">{{ supervisor.name }}</h6>
                                        <small class="text-muted">{{ supervisor.email }}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-info d-flex align-items-center">
                            <i class="ri-user-unfollow-line me-2 fs-5"></i>
                            <span>No supervisors assigned to this project yet.</span>
                        </div>
                    </div>

                    <!-- Project Students -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-3-line me-2"></i>Project Students</h6>
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
                                    <div>
                                        <h6 class="mb-0 text-dark">{{ student.name }}</h6>
                                        <small class="text-muted">{{ student.email }}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-info d-flex align-items-center">
                            <i class="ri-user-unfollow-line me-2 fs-5"></i>
                            <span>No students assigned to this project yet.</span>
                        </div>
                    </div>

                    <!-- Chapter Submissions -->
                    <div v-if="submissions && submissions.length > 0" class="mb-4">
                        <h6 class="text-muted mb-3">
                            <i class="ri-file-list-3-line me-2"></i>Chapter Submissions ({{ submissions.length }})
                        </h6>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="thead-light">
                                    <tr>
                                        <th class="border-0 rounded-start">#</th>
                                        <th class="border-0">Chapter</th>
                                        <th class="border-0">Uploaded By</th>
                                        <th class="border-0">Uploaded At</th>
                                        <th class="border-0">Status</th>
                                        <th class="border-0">Reviewed By</th>
                                        <th class="border-0">Supervisor Feedback</th>
                                        <th class="border-0 rounded-end text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(submission, index) in submissions" :key="submission.id">
                                        <td>{{ index + 1 }}</td>
                                        <td>
                                            <span class="badge bg-info tw-text-sm tw-font-medium tw-px-2.5 tw-py-1">
                                                {{ getChapterLabel(submission.chapter_type) }}
                                            </span>
                                        </td>
                                        <td>
                                            <div>
                                                <strong>{{ submission.uploaded_by?.name || 'N/A' }}</strong>
                                                <br />
                                                <small class="text-muted">{{
                                                    submission.uploaded_by?.email || ''
                                                }}</small>
                                            </div>
                                        </td>
                                        <td>
                                            <small>{{ formatDate(submission.created_at) }}</small>
                                        </td>
                                        <td>
                                            <span
                                                class="badge tw-text-sm tw-font-medium tw-px-2.5 tw-py-1 tw-rounded-full"
                                                :class="{
                                                    'bg-warning': submission.status === 'pending',
                                                    'bg-success': submission.status === 'approved',
                                                    'bg-danger': submission.status === 'rejected',
                                                }"
                                            >
                                                {{ submission.status }}
                                            </span>
                                        </td>
                                        <td>
                                            <span v-if="submission.reviewer">{{ submission.reviewer.name }}</span>
                                            <span v-else class="text-muted">-</span>
                                        </td>
                                        <td>
                                            <div
                                                v-if="submission.supervisor_feedback"
                                                class="text-wrap"
                                                style="max-width: 300px"
                                            >
                                                <div v-html="submission.supervisor_feedback" class="small"></div>
                                            </div>
                                            <span v-else class="text-muted">-</span>
                                        </td>
                                        <td class="text-end">
                                            <div class="btn-group">
                                                <button
                                                    v-if="submission.file_path"
                                                    @click="downloadFile(submission.file_path)"
                                                    class="btn btn-sm btn-primary"
                                                    title="Download File"
                                                >
                                                    <i class="ri-download-2-line"></i>
                                                </button>
                                                <a
                                                    v-if="submission.code_link"
                                                    :href="submission.code_link"
                                                    target="_blank"
                                                    class="btn btn-sm btn-info"
                                                    title="View Code Link"
                                                >
                                                    <i class="ri-github-line"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
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

                    <!-- Record Information -->
                    <div class="border-top pt-3 mt-4">
                        <div class="row">
                            <div class="col-md-4">
                                <small class="text-muted">Created By:</small>
                                <div class="text-dark">{{ project.creator?.name || 'N/A' }}</div>
                            </div>
                            <div class="col-md-4">
                                <small class="text-muted">Created At:</small>
                                <div class="text-dark">{{ formatDate(project.created_at) }}</div>
                            </div>
                            <div class="col-md-4">
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
