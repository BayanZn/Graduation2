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

const props = defineProps({
    projectRequest: {
        type: Object,
    },
    groupMembers: {
        type: Array,
        default: () => [],
    },
    supervisors: {
        type: Array,
        default: () => [],
    },
});

const approveForm = useForm({
    supervisor_ids: [],
});

const approveRequest = () => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Approve Request?',
        text: 'This will create project assignments for the student(s) and selected supervisor(s).',
        icon: 'question',
        confirmButtonText: 'Yes, Approve',
    }).then((result) => {
        if (result.isConfirmed) {
            approveForm.post(route('project.requests.approve', props.projectRequest.id), {
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Request Approved!',
                    });
                },
                onError: (errors) => {
                    console.log('Approval errors:', errors);
                    Toast.fire({
                        icon: 'error',
                        title: 'Approval Failed!',
                        text: errors.supervisor_ids || 'Please check the form.',
                    });
                },
            });
        }
    });
};

const rejectRequest = () => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Reject Request?',
        text: 'This action cannot be undone.',
        icon: 'warning',
        confirmButtonText: 'Yes, Reject',
    }).then((result) => {
        if (result.isConfirmed) {
            useForm({}).post(route('project.requests.reject', props.projectRequest.id), {
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Request Rejected!',
                    });
                },
            });
        }
    });
};

const resetToPending = () => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Reset to Pending?',
        text: 'This will reset the rejected request back to pending status.',
        icon: 'question',
        confirmButtonText: 'Yes, Reset',
    }).then((result) => {
        if (result.isConfirmed) {
            useForm({}).post(route('project.requests.reset-to-pending', props.projectRequest.id), {
                onSuccess: () => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Request Reset to Pending!',
                    });
                },
            });
        }
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
</script>

<template>
    <Head title="Project Request Details" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('project.requests.index')">Project Requests</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Request Details</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row justify-content-center">
        <!-- Request Overview Card -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-information-line text-primary me-2"></i>
                        Request Information
                    </h5>
                    <div class="d-flex gap-2 align-items-center flex-wrap">
                        <span
                            :class="[
                                'badge fs-6 p-2',
                                projectRequest.request_type === 'individual' ? 'bg-info' : 'bg-primary',
                            ]"
                        >
                            <i class="ri-team-line me-1"></i>{{ projectRequest.request_type }}
                        </span>
                        <span
                            :class="[
                                'badge fs-6 p-2',
                                projectRequest.status === 'pending'
                                    ? 'bg-warning'
                                    : projectRequest.status === 'approved'
                                    ? 'bg-success'
                                    : 'bg-danger',
                            ]"
                        >
                            <i class="ri-flag-line me-1"></i>{{ projectRequest.status }}
                        </span>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Student Information -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-line me-2"></i>Student Information</h6>
                        <div class="border rounded p-3 bg-light">
                            <h5 class="text-dark mb-1">{{ projectRequest.student?.name || 'N/A' }}</h5>
                            <p class="text-muted mb-0">{{ projectRequest.student?.email || 'N/A' }}</p>
                        </div>
                    </div>

                    <!-- Request Details -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-calendar-line me-2"></i>Request Details</h6>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-calendar-event-line text-primary fs-2 mb-2"></i>
                                    <h6 class="text-dark mb-1">{{ formatDate(projectRequest.created_at) }}</h6>
                                    <small class="text-muted">Requested Date</small>
                                </div>
                            </div>
                            <div v-if="projectRequest.reviewed_at" class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-check-line text-success fs-2 mb-2"></i>
                                    <h6 class="text-dark mb-1">{{ formatDate(projectRequest.reviewed_at) }}</h6>
                                    <small class="text-muted">Reviewed Date</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Message -->
                    <div v-if="projectRequest.message" class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-message-3-line me-2"></i>Student's Message</h6>
                        <div class="border rounded p-3 bg-light">
                            <p class="mb-0">{{ projectRequest.message }}</p>
                        </div>
                    </div>

                    <!-- Group Members (if group request) -->
                    <div v-if="projectRequest.request_type === 'group' && groupMembers.length > 0" class="mb-4">
                        <h6 class="text-muted mb-3">
                            <i class="ri-group-line me-2"></i>Group Members ({{ groupMembers.length }})
                        </h6>
                        <div class="row">
                            <div v-for="member in groupMembers" :key="member.id" class="col-md-6 mb-3">
                                <div class="border rounded p-3 bg-light d-flex align-items-center">
                                    <div class="avatar-lg me-3">
                                        <div
                                            class="rounded-circle bg-info d-flex align-items-center justify-content-center"
                                            style="width: 50px; height: 50px"
                                        >
                                            <i class="ri-user-3-line text-white fs-4"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 text-dark">{{ member.name }}</h6>
                                        <small class="text-muted">{{ member.email }}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Project Details -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-folder-2-line me-2"></i>Project Details</h6>
                        <div class="border rounded p-3 bg-light">
                            <h4 class="text-primary mb-3">{{ projectRequest.project?.title || 'N/A' }}</h4>
                            <div class="row mb-3">
                                <div class="col-md-4 mb-2">
                                    <strong>Type:</strong> {{ projectRequest.project?.project_type || 'N/A' }}
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong>Department:</strong>
                                    {{ projectRequest.project?.department?.name || 'N/A' }}
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong>Specialization:</strong>
                                    {{ projectRequest.project?.specialization?.name || 'N/A' }}
                                </div>
                            </div>
                            <div v-html="projectRequest.project?.description" class="text-dark mt-3"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Approve/Reject Actions (Only for Pending) -->
        <div v-if="projectRequest.status === 'pending'" class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white">
                    <h5 class="card-title mb-0">
                        <i class="ri-user-star-line text-primary me-2"></i>
                        Select Supervisors & Approve Request
                    </h5>
                </div>
                <div class="card-body">
                    <form @submit.prevent="approveRequest">
                        <div class="mb-4">
                            <label class="form-label"> Select Supervisor(s) <span class="text-danger">*</span> </label>
                            <v-select
                                v-model="approveForm.supervisor_ids"
                                :options="supervisors"
                                :reduce="(supervisor) => supervisor.id"
                                label="name"
                                multiple
                                placeholder="Select one or more supervisors"
                                :class="{ 'border-danger': approveForm.errors.supervisor_ids }"
                            >
                                <template #option="{ name, email }">
                                    <div>
                                        <strong>{{ name }}</strong>
                                        <br />
                                        <small class="text-muted">{{ email }}</small>
                                    </div>
                                </template>
                            </v-select>
                            <small class="text-muted">
                                The selected supervisors will be assigned to this project
                            </small>
                            <br />
                            <span v-show="approveForm.errors.supervisor_ids" class="text-danger">
                                {{ approveForm.errors.supervisor_ids }}
                            </span>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-success" :disabled="approveForm.processing">
                                <i class="ri-check-line me-2"></i>
                                {{ approveForm.processing ? 'Processing...' : 'Approve & Assign' }}
                            </button>
                            <button
                                type="button"
                                @click="rejectRequest"
                                class="btn btn-danger"
                                :disabled="approveForm.processing"
                            >
                                <i class="ri-close-line me-2"></i>
                                Reject Request
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Already Processed -->
        <div v-else class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div v-if="projectRequest.status === 'approved'" class="alert alert-success mb-0">
                        <i class="ri-checkbox-circle-line me-2"></i>
                        This request has been <strong>approved</strong>
                        <span v-if="projectRequest.reviewer">
                            by <strong>{{ projectRequest.reviewer.name }}</strong>
                        </span>
                        <span v-if="projectRequest.reviewed_at">
                            on <strong>{{ formatDate(projectRequest.reviewed_at) }}</strong>
                        </span>
                    </div>
                    <div v-else-if="projectRequest.status === 'rejected'" class="alert alert-danger mb-0">
                        <i class="ri-close-circle-line me-2"></i>
                        This request has been <strong>rejected</strong>
                        <span v-if="projectRequest.reviewer">
                            by <strong>{{ projectRequest.reviewer.name }}</strong>
                        </span>
                        <span v-if="projectRequest.reviewed_at">
                            on <strong>{{ formatDate(projectRequest.reviewed_at) }}</strong>
                        </span>
                        <div class="mt-3">
                            <button @click="resetToPending" class="btn btn-warning">
                                <i class="ri-refresh-line me-2"></i>
                                Reset to Pending
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Project Assignments (Only for Approved) -->
        <div
            v-if="projectRequest.status === 'approved' && projectRequest.project?.assignments?.length > 0"
            class="col-12 mb-4"
        >
            <div class="card border-0 shadow">
                <div class="card-header bg-white">
                    <h5 class="card-title mb-0">
                        <i class="ri-team-line text-success me-2"></i>
                        Project Assignments ({{ projectRequest.project.assignments.length }})
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <!-- Students -->
                        <div class="col-md-6 mb-3">
                            <h6 class="text-muted mb-3"><i class="ri-user-3-line me-2"></i>Students</h6>
                            <div
                                v-for="assignment in projectRequest.project.assignments.filter(
                                    (a) => a.role === 'student',
                                )"
                                :key="assignment.id"
                                class="border rounded p-3 bg-light mb-2"
                            >
                                <h6 class="mb-1 text-dark">{{ assignment.user?.name || 'N/A' }}</h6>
                                <small class="text-muted">{{ assignment.user?.email || 'N/A' }}</small>
                            </div>
                        </div>

                        <!-- Supervisors -->
                        <div class="col-md-6 mb-3">
                            <h6 class="text-muted mb-3"><i class="ri-user-star-line me-2"></i>Supervisors</h6>
                            <div
                                v-for="assignment in projectRequest.project.assignments.filter(
                                    (a) => a.role === 'supervisor',
                                )"
                                :key="assignment.id"
                                class="border rounded p-3 bg-light mb-2"
                            >
                                <h6 class="mb-1 text-dark">{{ assignment.user?.name || 'N/A' }}</h6>
                                <small class="text-muted">{{ assignment.user?.email || 'N/A' }}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page Content End -->
</template>
