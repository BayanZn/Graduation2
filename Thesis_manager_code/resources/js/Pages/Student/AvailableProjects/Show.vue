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
    project: {
        type: Object,
    },
    existingRequest: {
        type: Object,
        default: null,
    },
    isAssigned: {
        type: Boolean,
        default: false,
    },
    students: {
        type: Array,
        default: () => [],
    },
});

const showRequestForm = ref(false);

const form = useForm({
    request_type: 'individual',
    group_members: [],
    message: '',
});

const submitRequest = () => {
    form.post(route('student.available-projects.request', props.project.id), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();
            Toast.fire({
                icon: 'success',
                title: 'Request Submitted!',
            });
            showRequestForm.value = false;
        },
    });
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

const getStatusClass = (status) => {
    const classes = {
        Proposed: 'bg-warning',
        Approved: 'bg-success',
        Rejected: 'bg-danger',
        Completed: 'bg-primary',
    };
    return classes[status] || 'bg-secondary';
};

const getRequestStatusClass = (status) => {
    const classes = {
        pending: 'bg-warning',
        approved: 'bg-success',
        rejected: 'bg-danger',
    };
    return classes[status] || 'bg-secondary';
};
</script>

<template>
    <Head title="Project Details" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item">
            <Link :href="route('student.dashboard')">Dashboard</Link>
        </li>
        <li class="breadcrumb-item">
            <Link :href="route('student.available-projects.index')">Available Projects</Link>
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
                    </div>
                </div>
                <div class="card-body">
                    <h4 class="text-primary mb-3">{{ project.title }}</h4>

                    <div class="row mb-4">
                        <div class="col-md-6 mb-3">
                            <p class="text-muted mb-1"><i class="ri-building-line me-2"></i>Department</p>
                            <p class="fw-bold">{{ project.department?.name || '-----' }}</p>
                        </div>
                        <div class="col-md-6 mb-3">
                            <p class="text-muted mb-1"><i class="ri-bookmark-line me-2"></i>Specialization</p>
                            <p class="fw-bold">{{ project.specialization?.name || '-----' }}</p>
                        </div>
                    </div>

                    <div class="mb-4">
                        <h6 class="text-muted mb-2"><i class="ri-file-text-line me-2"></i>Description</h6>
                        <div class="border rounded p-3 bg-light" v-html="project.description"></div>
                    </div>

                    <!-- Supervisors -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-star-line me-2"></i>Supervisor(s)</h6>
                        <div class="row">
                            <div
                                v-for="(supervisor, index) in project.supervisors"
                                :key="supervisor.id"
                                class="col-md-6 mb-3"
                            >
                                <div class="border rounded p-3">
                                    <div class="d-flex align-items-center">
                                        <div
                                            class="avatar-sm bg-primary rounded-circle d-flex align-items-center justify-content-center me-3"
                                        >
                                            <i class="ri-user-line text-white fs-5"></i>
                                        </div>
                                        <div>
                                            <p class="fw-bold mb-0">{{ supervisor.name }}</p>
                                            <p class="text-muted small mb-0">{{ supervisor.email }}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div v-if="!project.supervisors || project.supervisors.length === 0" class="col-12">
                                <p class="text-muted">No supervisors assigned yet</p>
                            </div>
                        </div>
                    </div>

                    <!-- Current Students -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3">
                            <i class="ri-group-line me-2"></i>Current Students ({{ project.students?.length || 0 }})
                        </h6>
                        <div class="row">
                            <div v-for="(student, index) in project.students" :key="student.id" class="col-md-6 mb-3">
                                <div class="border rounded p-3">
                                    <div class="d-flex align-items-center">
                                        <div
                                            class="avatar-sm bg-info rounded-circle d-flex align-items-center justify-content-center me-3"
                                        >
                                            <i class="ri-user-3-line text-white fs-5"></i>
                                        </div>
                                        <div>
                                            <p class="fw-bold mb-0">{{ student.name }}</p>
                                            <p class="text-muted small mb-0">{{ student.email }}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div v-if="!project.students || project.students.length === 0" class="col-12">
                                <p class="text-muted">No students assigned yet</p>
                            </div>
                        </div>
                    </div>

                    <!-- Request Status or Request Button -->
                    <div class="mt-4">
                        <div v-if="isAssigned" class="alert alert-success">
                            <i class="ri-checkbox-circle-line me-2"></i>
                            You are already assigned to this project
                        </div>
                        <div v-else-if="existingRequest">
                            <div
                                class="alert"
                                :class="{
                                    'alert-warning': existingRequest.status === 'pending',
                                    'alert-success': existingRequest.status === 'approved',
                                    'alert-danger': existingRequest.status === 'rejected',
                                }"
                            >
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <strong>Request Status:</strong>
                                        <span :class="`badge ms-2 ${getRequestStatusClass(existingRequest.status)}`">
                                            {{ existingRequest.status.toUpperCase() }}
                                        </span>
                                    </div>
                                    <div class="text-muted small">Request Type: {{ existingRequest.request_type }}</div>
                                </div>
                                <div v-if="existingRequest.message" class="mt-2">
                                    <strong>Your Message:</strong> {{ existingRequest.message }}
                                </div>
                            </div>
                        </div>
                        <div v-else>
                            <button
                                v-if="!showRequestForm"
                                @click="showRequestForm = true"
                                class="btn btn-primary btn-lg w-100"
                            >
                                <i class="ri-send-plane-fill me-2"></i>Request This Project
                            </button>

                            <!-- Request Form -->
                            <div v-if="showRequestForm" class="card border-primary">
                                <div class="card-header bg-primary text-white">
                                    <h6 class="mb-0"><i class="ri-file-list-3-line me-2"></i>Submit Project Request</h6>
                                </div>
                                <div class="card-body">
                                    <form @submit.prevent="submitRequest">
                                        <div class="mb-3">
                                            <label class="form-label"
                                                >Request Type <span class="text-danger">*</span></label
                                            >
                                            <div class="form-check">
                                                <input
                                                    v-model="form.request_type"
                                                    class="form-check-input"
                                                    type="radio"
                                                    value="individual"
                                                    id="individual"
                                                />
                                                <label class="form-check-label" for="individual">
                                                    Individual Request
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input
                                                    v-model="form.request_type"
                                                    class="form-check-input"
                                                    type="radio"
                                                    value="group"
                                                    id="group"
                                                />
                                                <label class="form-check-label" for="group"> Group Request </label>
                                            </div>
                                            <span v-show="form.errors.request_type" class="text-danger">{{
                                                form.errors.request_type
                                            }}</span>
                                        </div>

                                        <div v-if="form.request_type === 'group'" class="mb-3">
                                            <label class="form-label"
                                                >Group Members <span class="text-danger">*</span></label
                                            >
                                            <v-select
                                                v-model="form.group_members"
                                                :options="students"
                                                :reduce="(student) => student.id"
                                                label="name"
                                                multiple
                                                placeholder="Select group members"
                                                :class="{ 'border-danger': form.errors.group_members }"
                                            >
                                                <template #option="{ name, email }">
                                                    <div>
                                                        <strong>{{ name }}</strong>
                                                        <br />
                                                        <small class="text-muted">{{ email }}</small>
                                                    </div>
                                                </template>
                                            </v-select>
                                            <small class="text-muted"
                                                >Select the students who will be part of your group</small
                                            >
                                            <br />
                                            <span v-show="form.errors.group_members" class="text-danger">{{
                                                form.errors.group_members
                                            }}</span>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Message (Optional)</label>
                                            <textarea
                                                v-model="form.message"
                                                class="form-control"
                                                rows="3"
                                                placeholder="Add a message to your request..."
                                                :class="{ 'border-2 border-danger': form.errors.message }"
                                            ></textarea>
                                            <span v-show="form.errors.message" class="text-danger">{{
                                                form.errors.message
                                            }}</span>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-primary" :disabled="form.processing">
                                                <i class="ri-send-plane-fill me-2"></i>Submit Request
                                            </button>
                                            <button
                                                type="button"
                                                @click="showRequestForm = false"
                                                class="btn btn-secondary"
                                                :disabled="form.processing"
                                            >
                                                Cancel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page Content End -->
</template>

<style scoped>
.avatar-sm {
    width: 40px;
    height: 40px;
}
</style>
