<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { Modal } from 'bootstrap';
import Quill from 'quill';
import 'quill/dist/quill.snow.css';
import { nextTick, ref } from 'vue';

const props = defineProps({
    project: {
        type: Object,
    },
    submissions: {
        type: Array,
        default: () => [],
    },
});

// Track active submission for modal
const activeSubmission = ref(null);
const feedbackModal = ref(null);
let quillInstance = null;

// Feedback form
const feedbackForm = useForm({
    status: '',
    supervisor_feedback: '',
});

// Quill editor ref
const editor = ref(null);

// Open feedback modal and initialize Quill
const openFeedbackModal = async (submission) => {
    activeSubmission.value = submission;
    feedbackForm.status = submission.status;
    feedbackForm.supervisor_feedback = submission.supervisor_feedback || '';
    feedbackForm.clearErrors();

    // Wait for next tick to ensure modal is rendered
    await nextTick();

    // Initialize Quill editor after modal is shown
    setTimeout(() => {
        if (editor.value) {
            // Destroy existing instance if it exists
            if (quillInstance) {
                quillInstance = null;
            }

            // Create new Quill instance
            quillInstance = new Quill(editor.value, {
                theme: 'snow',
                modules: {
                    toolbar: [
                        ['bold', 'italic', 'underline', 'strike'],
                        [{ list: 'ordered' }, { list: 'bullet' }],
                        [{ color: [] }, { background: [] }],
                        ['link'],
                        ['clean'],
                    ],
                },
            });

            // Set initial content
            if (submission.supervisor_feedback) {
                quillInstance.root.innerHTML = submission.supervisor_feedback;
            }

            // Sync Quill content with form
            quillInstance.on('text-change', () => {
                feedbackForm.supervisor_feedback = quillInstance.root.innerHTML;
            });
        }
    }, 200);
};

// Submit feedback
const submitFeedback = () => {
    // Validate feedback is not empty (strip HTML tags to check for actual content)
    const feedbackText = feedbackForm.supervisor_feedback.replace(/<[^>]*>/g, '').trim();

    if (!feedbackText) {
        feedbackForm.setError('supervisor_feedback', 'Please provide feedback before submitting.');
        return;
    }

    let { Toast } = useAlert();

    feedbackForm.patch(route('supervisor.supervised-projects.update-submission-status', activeSubmission.value.id), {
        preserveScroll: true,
        onSuccess: () => {
            Toast.fire({
                icon: 'success',
                title: 'Feedback Updated!',
            });

            // Close modal
            const modal = Modal.getInstance(feedbackModal.value);
            if (modal) {
                modal.hide();
            }

            // Clean up
            activeSubmission.value = null;
            if (quillInstance) {
                quillInstance = null;
            }
        },
    });
};

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
        pending: 'bg-warning',
        approved: 'bg-success',
        rejected: 'bg-danger',
        Proposed: 'bg-warning',
        Approved: 'bg-success',
        Rejected: 'bg-danger',
        Completed: 'bg-primary',
        proposed: 'bg-warning',
        approved: 'bg-success',
        declined: 'bg-danger',
        completed: 'bg-primary',
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
    <Head title="Project Details" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('supervisor.supervised-projects.index')">Supervised Projects</Link>
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
                        <span
                            class="badge fs-6 p-2"
                            :class="
                                project.project_type === 'Semester'
                                    ? 'bg-info'
                                    : project.project_type === 'Graduation 1'
                                    ? 'bg-primary'
                                    : 'bg-success'
                            "
                        >
                            <i class="ri-book-line me-1"></i>{{ project.project_type }}
                        </span>
                        <span class="badge fs-6 p-2" :class="getStatusClass(project.status)">
                            <i class="ri-flag-line me-1"></i>{{ project.status }}
                        </span>
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

        <!-- Student Submissions Section -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-file-text-line text-success me-2"></i>
                        Student Chapter Submissions ({{ submissions.length }})
                    </h5>
                </div>
                <div class="card-body">
                    <div v-if="submissions.length === 0" class="alert alert-info d-flex align-items-center">
                        <i class="ri-information-line me-2 fs-5"></i>
                        <span>No chapter submissions yet from students.</span>
                    </div>

                    <div v-else class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="thead-light">
                                <tr>
                                    <th class="border-0 rounded-start">#</th>
                                    <th class="border-0">Chapter</th>
                                    <th class="border-0">Student</th>
                                    <th class="border-0">Submitted</th>
                                    <th class="border-0">Status</th>
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
                                            <small class="text-muted">{{ submission.uploaded_by?.email || '' }}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <small>{{ formatDate(submission.created_at) }}</small>
                                    </td>
                                    <td>
                                        <span
                                            class="badge tw-text-sm tw-font-medium tw-px-2.5 tw-py-1 tw-rounded-full"
                                            :class="getStatusClass(submission.status)"
                                        >
                                            {{ submission.status }}
                                        </span>
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
                                            <button
                                                @click="openFeedbackModal(submission)"
                                                class="btn btn-sm btn-success"
                                                data-bs-toggle="modal"
                                                data-bs-target="#feedbackModal"
                                                title="Provide Feedback"
                                            >
                                                <i class="ri-message-3-line"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Feedback Modal -->
    <div
        ref="feedbackModal"
        class="modal fade"
        id="feedbackModal"
        tabindex="-1"
        aria-labelledby="feedbackModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="feedbackModalLabel">
                        <i class="ri-message-3-line me-2"></i>
                        Review Submission
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form @submit.prevent="submitFeedback">
                    <div class="modal-body">
                        <div v-if="activeSubmission">
                            <!-- Submission Info -->
                            <div class="alert alert-info">
                                <div class="row">
                                    <div class="col-md-6">
                                        <strong>Chapter:</strong>
                                        {{ getChapterLabel(activeSubmission.chapter_type) }}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Student:</strong> {{ activeSubmission.uploaded_by?.name }}
                                    </div>
                                </div>
                            </div>

                            <!-- Existing Feedback Display -->
                            <div
                                v-if="
                                    activeSubmission.supervisor_feedback && activeSubmission.supervisor_feedback.trim()
                                "
                                class="mb-3"
                            >
                                <label class="form-label fw-bold">Current Feedback:</label>
                                <div
                                    class="border rounded bg-light tw-prose p-3"
                                    v-html="activeSubmission.supervisor_feedback"
                                ></div>
                                <div v-if="activeSubmission.reviewer" class="mt-2">
                                    <small class="text-muted">
                                        Reviewed by: <strong>{{ activeSubmission.reviewer.name }}</strong> on
                                        {{ formatDate(activeSubmission.reviewed_at) }}
                                    </small>
                                </div>
                            </div>

                            <!-- Status Selection -->
                            <div class="mb-3">
                                <label class="form-label"> Review Status <span class="text-danger">*</span> </label>
                                <select
                                    v-model="feedbackForm.status"
                                    class="form-select"
                                    :class="{
                                        'border-2 border-danger': feedbackForm.errors.status,
                                    }"
                                    required
                                >
                                    <option value="pending">Pending</option>
                                    <option value="approved">Approved</option>
                                    <option value="rejected">Rejected</option>
                                </select>
                                <span v-if="feedbackForm.errors.status" class="text-danger">
                                    {{ feedbackForm.errors.status }}
                                </span>
                            </div>

                            <!-- Feedback Editor -->
                            <div class="mb-3">
                                <label class="form-label">Feedback Message</label>
                                <div ref="editor" class="border rounded bg-white"></div>
                                <span v-if="feedbackForm.errors.supervisor_feedback" class="text-danger">
                                    {{ feedbackForm.errors.supervisor_feedback }}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success" :disabled="feedbackForm.processing">
                            <span v-if="feedbackForm.processing"> <i class="ri-loader-4-line"></i> Updating... </span>
                            <span v-else> <i class="ri-save-line"></i> Save Feedback </span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* Ensure Quill editor has proper clickable height */
:deep(.ql-container) {
    min-height: 200px;
}

:deep(.ql-editor) {
    min-height: 200px;
}
</style>
