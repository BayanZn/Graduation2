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
import { ref } from 'vue';

const props = defineProps({
    projects: {
        type: Array,
        default: () => [],
    },
    selectedProject: {
        type: Object,
        default: null,
    },
    submissions: {
        type: Array,
        default: () => [],
    },
    groupMembers: {
        type: Array,
        default: () => [],
    },
    chapterOptions: {
        type: Array,
        default: () => [
            'Introduction',
            'Literature Review',
            'Methodology',
            'Result & Analysis',
            'Conclusion',
            'Abstract',
            'Full Draft',
        ],
    },
    chapterTemplate: {
        type: String,
        default: null,
    },
    error: {
        type: String,
        default: null,
    },
});

const uploadForm = useForm({
    project_id: props.selectedProject?.id || null,
    chapter_type: null,
    file: null,
    code_link: null,
});

const fileInput = ref(null);

const handleFileChange = (event) => {
    uploadForm.file = event.target.files[0];
};

const submitChapter = () => {
    uploadForm.post(route('student.project-submissions.store'), {
        onSuccess: () => {
            uploadForm.reset();
            if (fileInput.value) {
                fileInput.value.value = '';
            }
            let { Toast } = useAlert();
            Toast.fire({
                icon: 'success',
                title: 'Chapter submitted successfully!',
            });
        },
        onError: () => {
            let { Toast } = useAlert();
            Toast.fire({
                icon: 'error',
                title: 'Submission failed!',
            });
        },
    });
};

const deleteSubmission = (submissionId) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Delete Submission?',
        text: 'This action cannot be undone.',
        icon: 'warning',
        confirmButtonText: 'Yes, Delete',
    }).then((result) => {
        if (result.isConfirmed) {
            useForm({}).delete(route('student.project-submissions.destroy', submissionId), {
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Submission deleted!',
                    });
                },
            });
        }
    });
};

const getStatusClass = (status) => {
    const classes = {
        pending: 'bg-warning',
        approved: 'bg-success',
        rejected: 'bg-danger',
    };
    return classes[status] || 'bg-secondary';
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
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
};

const downloadFile = (filePath, chapterType) => {
    const fileName = chapterType.replace(/ /g, '_') + '_' + Date.now();
    window.open(`/storage/${filePath}`, '_blank');
};
</script>

<template>
    <Head title="Project Submissions" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('student.dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('student.assigned-projects.index')">My Projects</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Project Submissions</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row justify-content-center">
        <!-- No Project Assigned Alert -->
        <div v-if="projects.length === 0" class="col-12 mb-4">
            <div class="alert alert-warning d-flex align-items-center">
                <i class="ri-alert-line me-3 fs-3"></i>
                <div>
                    <h5 class="mb-1">No Project Assigned</h5>
                    <p class="mb-2">{{ error || 'You are not assigned to any project yet.' }}</p>
                    <Link :href="route('student.available-projects.index')" class="btn btn-sm btn-primary">
                        <i class="ri-search-line me-2"></i>
                        Browse Available Projects
                    </Link>
                </div>
            </div>
        </div>

        <!-- Project Info Card -->
        <div v-if="selectedProject" class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white">
                    <h5 class="card-title mb-0">
                        <i class="ri-folder-2-line text-primary me-2"></i>
                        {{ selectedProject.title }}
                    </h5>
                </div>
                <div class="card-body">
                    <p class="mb-2 text-muted">Submit your project chapters and track their review status.</p>
                    <div v-if="chapterTemplate" class="alert alert-info mb-0 d-flex align-items-center">
                        <i class="ri-file-download-line me-2"></i>
                        <div class="flex-grow-1">
                            <strong>Chapter Template Available</strong>
                            <p class="mb-0 small">Download the template for your specialization chapters.</p>
                        </div>
                        <a
                            :href="`/storage/${chapterTemplate}`"
                            target="_blank"
                            class="btn btn-sm btn-outline-primary"
                        >
                            <i class="ri-download-2-line me-1"></i> Download Template
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Upload Form Card -->
        <div v-if="selectedProject" class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white">
                    <h5 class="card-title mb-0">
                        <i class="ri-upload-2-line text-success me-2"></i>
                        Submit New Chapter
                    </h5>
                </div>
                <div class="card-body">
                    <form @submit.prevent="submitChapter">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Chapter Type <span class="text-danger">*</span></label>
                                <v-select
                                    v-model="uploadForm.chapter_type"
                                    :options="props.chapterOptions"
                                    placeholder="Select chapter type"
                                    :class="{ 'border-danger': uploadForm.errors.chapter_type }"
                                >
                                    <template #option="{ label }">
                                        {{ getChapterLabel(label) }}
                                    </template>
                                    <template #selected-option="{ label }">
                                        {{ getChapterLabel(label) }}
                                    </template>
                                </v-select>
                                <span v-if="uploadForm.errors.chapter_type" class="text-danger small">
                                    {{ uploadForm.errors.chapter_type }}
                                </span>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Upload File (PDF, DOC, DOCX)</label>
                                <input
                                    ref="fileInput"
                                    type="file"
                                    class="form-control"
                                    accept=".pdf,.doc,.docx"
                                    @change="handleFileChange"
                                    :class="{ 'border-danger': uploadForm.errors.file }"
                                />
                                <small class="text-muted">Max file size: 10MB</small>
                                <br />
                                <span v-if="uploadForm.errors.file" class="text-danger small">
                                    {{ uploadForm.errors.file }}
                                </span>
                            </div>

                            <div class="col-md-12 mb-4">
                                <label class="form-label">Code Link (GitHub, GitLab, etc.)</label>
                                <input
                                    v-model="uploadForm.code_link"
                                    type="url"
                                    class="form-control"
                                    placeholder="https://github.com/username/repository"
                                    :class="{ 'border-danger': uploadForm.errors.code_link }"
                                />
                                <small class="text-muted">Optional: Provide a link to your code repository</small>
                                <br />
                                <span v-if="uploadForm.errors.code_link" class="text-danger small">
                                    {{ uploadForm.errors.code_link }}
                                </span>
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary" :disabled="uploadForm.processing">
                                <i class="ri-upload-2-line me-2"></i>
                                {{ uploadForm.processing ? 'Uploading...' : 'Submit Chapter' }}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Submissions Table Card -->
        <div v-if="selectedProject" class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white">
                    <h5 class="card-title mb-0">
                        <i class="ri-file-list-3-line text-info me-2"></i>
                        All Submissions ({{ submissions.length }})
                    </h5>
                </div>
                <div class="card-body">
                    <div v-if="submissions.length === 0" class="alert alert-info">
                        <i class="ri-information-line me-2"></i>
                        No submissions yet. Upload your first chapter above!
                    </div>

                    <div v-else class="table-responsive">
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
                                        <span class="badge bg-info">
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
                                        <span class="badge" :class="getStatusClass(submission.status)">
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
                                                @click="downloadFile(submission.file_path, submission.chapter_type)"
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
                                                v-if="
                                                    submission.status === 'pending' &&
                                                    submission.uploaded_by.id === $page.props.auth.user.id
                                                "
                                                @click="deleteSubmission(submission.id)"
                                                class="btn btn-sm btn-danger"
                                                title="Delete"
                                            >
                                                <i class="ri-delete-bin-line"></i>
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
    <!-- Page Content End -->
</template>
