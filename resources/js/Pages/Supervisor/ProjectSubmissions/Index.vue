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
    submissions: {
        type: Array,
        default: () => [],
    },
});

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
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
};

const downloadFile = (filePath) => {
    window.open(`/storage/${filePath}`, '_blank');
};
</script>

<template>
    <Head title="Project Submissions" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('supervisor.dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Project Submissions</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-file-list-3-line text-primary me-2"></i>
                        Student Submissions ({{ submissions.length }})
                    </h5>
                </div>
                <div class="card-body">
                    <div v-if="submissions.length === 0" class="alert alert-info">
                        <i class="ri-information-line me-2"></i>
                        No submissions yet from your supervised projects.
                    </div>

                    <div v-else class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="thead-light">
                                <tr>
                                    <th class="border-0 rounded-start">#</th>
                                    <th class="border-0">Project</th>
                                    <th class="border-0">Chapter</th>
                                    <th class="border-0">Student</th>
                                    <th class="border-0">Submitted At</th>
                                    <th class="border-0">Status</th>
                                    <th class="border-0 rounded-end text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(submission, index) in submissions" :key="submission.id">
                                    <td>{{ index + 1 }}</td>
                                    <td>
                                        <strong>{{ submission.project?.title || 'N/A' }}</strong>
                                    </td>
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
                                                @click="downloadFile(submission.file_path)"
                                                class="btn btn-sm btn-primary"
                                                title="Download"
                                            >
                                                <i class="ri-download-2-line"></i>
                                            </button>
                                            <Link
                                                :href="route('supervisor.project-submissions.show', submission.id)"
                                                class="btn btn-sm btn-success"
                                                title="Review"
                                            >
                                                <i class="ri-eye-line"></i>
                                            </Link>
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
