<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { useQuill } from '@/Composables/useQuill.js';
import { Head, Link, router, useForm } from '@inertiajs/vue3';
import 'quill/dist/quill.snow.css';
import { ref, toRef } from 'vue';

const props = defineProps({
    submission: {
        type: Object,
    },
});

// Quill editor ref
const editor = ref(null);

const form = useForm({
    status: props.submission.status,
    supervisor_feedback: props.submission.supervisor_feedback || '',
});

// Initialize Quill
const { quill, setContents } = useQuill({ containerRef: editor, model: toRef(form, 'supervisor_feedback') });

// Set existing content if available
if (props.submission.supervisor_feedback) {
    setTimeout(() => {
        setContents(props.submission.supervisor_feedback);
    }, 100);
}

const updateStatus = (status) => {
    let { Toast, AlertWithButtons } = useAlert();

    const messages = {
        approved: 'Approve this submission?',
        rejected: 'Reject this submission?',
        pending: 'Reset to pending?',
    };

    AlertWithButtons.fire({
        title: messages[status],
        text:
            status === 'approved'
                ? 'Student will be notified of approval.'
                : status === 'rejected'
                ? 'Make sure to provide feedback below.'
                : 'This will reset the status.',
        icon: 'question',
        confirmButtonText: 'Yes, ' + status.charAt(0).toUpperCase() + status.slice(1),
    }).then((result) => {
        if (result.isConfirmed) {
            form.status = status;
            form.patch(route('supervisor.project-submissions.update-status', props.submission.id), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Status Updated!',
                    });
                },
            });
        }
    });
};

// Update project type
const updateProjectType = (newType) => {
    let { Toast } = useAlert();

    router.patch(
        route('supervisor.supervised-projects.update-type', props.submission.project.id),
        {
            project_type: newType,
        },
        {
            preserveScroll: true,
            preserveState: true,
            onSuccess: () => {
                Toast.fire({
                    icon: 'success',
                    title: 'Project Type Updated!',
                });
            },
        },
    );
};

const getStatusClass = (status) => {
    const classes = {
        pending: 'tw-text-yellow-700 tw-bg-yellow-200',
        approved: 'tw-text-green-700 tw-bg-green-200',
        rejected: 'tw-text-red-700 tw-bg-red-200',
    };
    return classes[status] || 'tw-bg-gray-200';
};

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

const downloadFile = () => {
    window.open(`/storage/${props.submission.file_path}`, '_blank');
};
</script>

<template>
    <Head title="Review Submission" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('supervisor.dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('supervisor.project-submissions.index')">Project Submissions</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Review Submission</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row justify-content-center">
        <!-- Submission Details Card -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-file-text-line text-primary me-2"></i>
                        Submission Details
                    </h5>
                    <span
                        class="badge fs-6 p-2 tw-text-sm tw-font-medium tw-px-3 tw-py-1.5 tw-rounded-full"
                        :class="getStatusClass(submission.status)"
                    >
                        <i class="ri-flag-line me-1"></i>{{ submission.status }}
                    </span>
                </div>
                <div class="card-body">
                    <!-- Project & Chapter Info -->
                    <div class="row mb-4">
                        <div class="col-md-6 mb-3">
                            <h6 class="text-muted mb-2"><i class="ri-folder-2-line me-2"></i>Project</h6>
                            <div class="border rounded p-3 bg-light">
                                <h5 class="text-dark mb-0">{{ submission.project?.title || 'N/A' }}</h5>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <h6 class="text-muted mb-2"><i class="ri-book-line me-2"></i>Chapter Type</h6>
                            <div class="border rounded p-3 bg-light">
                                <span class="badge bg-info fs-6">
                                    {{ getChapterLabel(submission.chapter_type) }}
                                </span>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <h6 class="text-muted mb-2"><i class="ri-file-list-line me-2"></i>Project Type</h6>
                            <div class="border rounded p-3 bg-light">
                                <select
                                    :value="submission.project?.project_type"
                                    @change="updateProjectType($event.target.value)"
                                    :class="[
                                        'tw-text-sm tw-text-center tw-font-medium tw-px-2 tw-py-1 tw-rounded-full tw-border-0 tw-cursor-pointer tw-appearance-none tw-bg-transparent hover:tw-opacity-80 focus:tw-outline-none focus:tw-ring-2 focus:tw-ring-offset-1',
                                        submission.project?.project_type === 'Semester'
                                            ? 'tw-text-blue-700 tw-bg-blue-200 focus:tw-ring-blue-500'
                                            : '',
                                        submission.project?.project_type === 'Graduation 1'
                                            ? 'tw-text-purple-700 tw-bg-purple-200 focus:tw-ring-purple-500'
                                            : '',
                                        submission.project?.project_type === 'Graduation 2'
                                            ? 'tw-text-indigo-700 tw-bg-indigo-200 focus:tw-ring-indigo-500'
                                            : '',
                                    ]"
                                    style="width: auto; display: inline-block; background-image: none"
                                >
                                    <option value="Semester" class="tw-bg-white">Semester</option>
                                    <option value="Graduation 1" class="tw-bg-white">Graduation 1</option>
                                    <option value="Graduation 2" class="tw-bg-white">Graduation 2</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Student Info -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-2"><i class="ri-user-line me-2"></i>Submitted By</h6>
                        <div class="border rounded p-3 bg-light">
                            <h6 class="text-dark mb-1">{{ submission.uploaded_by?.name || 'N/A' }}</h6>
                            <small class="text-muted">{{ submission.uploaded_by?.email || 'N/A' }}</small>
                        </div>
                    </div>

                    <!-- Submission Date -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-2"><i class="ri-calendar-line me-2"></i>Submission Details</h6>
                        <div class="row">
                            <div class="col-md-6 mb-2">
                                <div class="border rounded p-3 bg-light">
                                    <small class="text-muted">Submitted At:</small>
                                    <div class="text-dark">{{ formatDate(submission.created_at) }}</div>
                                </div>
                            </div>
                            <div v-if="submission.reviewed_at" class="col-md-6 mb-2">
                                <div class="border rounded p-3 bg-light">
                                    <small class="text-muted">Reviewed At:</small>
                                    <div class="text-dark">{{ formatDate(submission.reviewed_at) }}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Download File -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-2"><i class="ri-file-download-line me-2"></i>File</h6>
                        <button @click="downloadFile" class="btn btn-primary">
                            <i class="ri-download-2-line me-2"></i>
                            Download Submission
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Feedback & Status Update Card -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white">
                    <h5 class="card-title mb-0">
                        <i class="ri-message-3-line text-success me-2"></i>
                        Supervisor Feedback & Review
                    </h5>
                </div>
                <div class="card-body">
                    <form @submit.prevent="updateStatus(form.status)">
                        <div class="mb-4">
                            <label class="form-label">
                                Feedback Message
                                <span class="text-muted">(Optional - Use rich text editor)</span>
                            </label>
                            <div ref="editor" class="border rounded" style="min-height: 200px"></div>
                            <span v-if="form.errors.supervisor_feedback" class="text-danger small">
                                {{ form.errors.supervisor_feedback }}
                            </span>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Review Status</label>
                            <div class="d-flex gap-2 flex-wrap">
                                <button
                                    type="button"
                                    @click="updateStatus('approved')"
                                    class="btn btn-success"
                                    :disabled="form.processing"
                                >
                                    <i class="ri-check-line me-2"></i>
                                    Approve Submission
                                </button>
                                <button
                                    type="button"
                                    @click="updateStatus('rejected')"
                                    class="btn btn-danger"
                                    :disabled="form.processing"
                                >
                                    <i class="ri-close-line me-2"></i>
                                    Reject Submission
                                </button>
                                <button
                                    type="button"
                                    @click="updateStatus('pending')"
                                    class="btn btn-warning"
                                    :disabled="form.processing"
                                >
                                    <i class="ri-refresh-line me-2"></i>
                                    Reset to Pending
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Existing Feedback (if any) -->
        <div v-if="submission.supervisor_feedback && !form.processing" class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white">
                    <h6 class="card-title mb-0">
                        <i class="ri-chat-3-line text-info me-2"></i>
                        Current Feedback
                    </h6>
                </div>
                <div class="card-body">
                    <div v-html="submission.supervisor_feedback" class="border rounded p-3 bg-light"></div>
                    <div v-if="submission.reviewer" class="mt-3">
                        <small class="text-muted">
                            Reviewed by: <strong>{{ submission.reviewer.name }}</strong>
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page Content End -->
</template>
