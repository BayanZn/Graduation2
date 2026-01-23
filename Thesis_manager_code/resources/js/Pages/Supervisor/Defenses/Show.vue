<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { computed, ref } from 'vue';

const props = defineProps({
    defense: {
        type: Object,
    },
    myGrade: {
        type: Object,
        default: null,
    },
    maxGrade: {
        type: Number,
        default: 0,
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
        scheduled: 'bg-info',
        completed: 'bg-success',
        cancelled: 'bg-danger',
    };
    return classes[status] || 'bg-secondary';
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

// Formatted type name
const formattedType = computed(() => {
    const types = {
        proposal: 'Proposal Defense',
        seminar: 'Seminar Defense',
        code: 'Code Defense',
        final: 'Final Defense',
    };
    return types[props.defense.discussion_type] || props.defense.discussion_type;
});

// Grade form
const gradeForm = useForm({
    grade: props.myGrade?.grade || null,
    feedback: props.myGrade?.feedback || '',
});

const showGradeForm = ref(false);

const submitGrade = () => {
    gradeForm.post(route('supervisor.defenses.submit-grade', props.defense.id), {
        preserveScroll: true,
        onSuccess: () => {
            showGradeForm.value = false;
        },
    });
};
</script>

<template>
    <Head title="Defense Details" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('supervisor.defenses.index')">Defense Evaluations</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Defense Details</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row justify-content-center">
        <!-- Defense Overview Card -->
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="ri-shield-check-line text-primary me-2"></i>
                        Defense Details
                    </h5>
                    <div class="d-flex gap-2 align-items-center flex-wrap">
                        <span class="badge fs-6 p-2" :class="getTypeClass(defense.discussion_type)">
                            <i class="ri-calendar-event-line me-1"></i>{{ formattedType }}
                        </span>
                        <span class="badge fs-6 p-2" :class="getStatusClass(defense.status)">
                            <i class="ri-information-line me-1"></i>{{ defense.status.toUpperCase() }}
                        </span>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Project Information -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-folder-2-line me-2"></i>Project Information</h6>
                        <div class="border rounded p-3 bg-light">
                            <h4 class="text-primary mb-3">{{ defense.project.title }}</h4>
                            <div class="row">
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Project Type:</strong>
                                    <div>
                                        <span class="badge bg-info">{{ defense.project.project_type }}</span>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Status:</strong>
                                    <div>
                                        <span class="badge bg-success">{{ defense.project.status }}</span>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <strong class="text-muted small">Department:</strong>
                                    <div class="text-dark">{{ defense.project.department?.name || 'N/A' }}</div>
                                </div>
                                <div class="col-md-12 mb-2">
                                    <strong class="text-muted small">Specialization:</strong>
                                    <div class="text-dark">{{ defense.project.specialization?.name || 'N/A' }}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Defense Schedule -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-time-line me-2"></i>Defense Schedule</h6>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-door-open-line text-warning fs-2 mb-2"></i>
                                    <h4 class="text-dark mb-1">{{ defense.discussion_hall }}</h4>
                                    <small class="text-muted">Discussion Hall</small>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="border rounded p-3 text-center bg-light">
                                    <i class="ri-calendar-2-line text-primary fs-2 mb-2"></i>
                                    <h5 class="text-dark mb-1">{{ formatDate(defense.discussion_date) }}</h5>
                                    <small class="text-muted">Date & Time</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Defense Committee Members -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3">
                            <i class="ri-shield-user-line me-2"></i>Defense Committee Members
                        </h6>
                        <div v-if="defense.members && defense.members.length > 0" class="row">
                            <div v-for="(member, index) in defense.members" :key="member.id" class="col-md-6 mb-3">
                                <div class="border rounded p-3 bg-light d-flex align-items-center">
                                    <div class="avatar-lg me-3">
                                        <img
                                            :src="
                                                member.media.length === 0
                                                    ? 'https://gravatar.com/avatar/placeholder'
                                                    : member.media[0]?.original_url
                                            "
                                            class="rounded-circle object-contain"
                                            alt="Member"
                                            width="50"
                                            height="50"
                                        />
                                    </div>
                                    <div>
                                        <h6 class="mb-0 text-dark">{{ member.name }}</h6>
                                        <small class="text-muted">{{ member.email }}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-info d-flex align-items-center">
                            <i class="ri-user-unfollow-line me-2 fs-5"></i>
                            <span>No committee members assigned to this defense.</span>
                        </div>
                    </div>

                    <!-- Project Students -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-3-line me-2"></i>Project Students</h6>
                        <div v-if="defense.project.students && defense.project.students.length > 0" class="row">
                            <div
                                v-for="(student, index) in defense.project.students"
                                :key="student.id"
                                class="col-md-6 mb-3"
                            >
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
                            <span>No students assigned to this project.</span>
                        </div>
                    </div>

                    <!-- Project Supervisors -->
                    <div class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-user-star-line me-2"></i>Project Supervisors</h6>
                        <div v-if="defense.project.supervisors && defense.project.supervisors.length > 0" class="row">
                            <div
                                v-for="(supervisor, index) in defense.project.supervisors"
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
                            <span>No supervisors assigned to this project.</span>
                        </div>
                    </div>

                    <!-- Additional Notes -->
                    <div v-if="defense.notes" class="mb-4">
                        <h6 class="text-muted mb-3"><i class="ri-file-text-line me-2"></i>Additional Notes</h6>
                        <div class="border rounded p-3 bg-light">
                            <div v-html="defense.notes" class="text-dark" style="line-height: 1.6"></div>
                        </div>
                    </div>

                    <!-- Grading Section -->
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="text-muted mb-0">
                                <i class="ri-star-line me-2"></i>My Grade
                            </h6>
                            <span class="badge bg-secondary">Max Grade: {{ maxGrade }}</span>
                        </div>

                        <!-- Display current grade if exists -->
                        <div v-if="myGrade && myGrade.grade !== null" class="border rounded p-3 bg-light mb-3">
                            <div class="row">
                                <div class="col-md-6">
                                    <strong class="text-muted small">Grade:</strong>
                                    <div class="text-dark fs-4 fw-bold text-primary">
                                        {{ myGrade.grade }} / {{ maxGrade }}
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <strong class="text-muted small">Graded At:</strong>
                                    <div class="text-dark">{{ formatDate(myGrade.graded_at) }}</div>
                                </div>
                                <div v-if="myGrade.feedback" class="col-12 mt-3">
                                    <strong class="text-muted small">Feedback:</strong>
                                    <div class="text-dark">{{ myGrade.feedback }}</div>
                                </div>
                            </div>
                            <button
                                @click="showGradeForm = true"
                                class="btn btn-sm btn-outline-primary mt-3"
                            >
                                <i class="ri-edit-line me-1"></i>Update Grade
                            </button>
                        </div>

                        <!-- Grade submission form -->
                        <div v-else class="alert alert-warning">
                            <i class="ri-error-warning-line me-2"></i>
                            You haven't submitted your grade for this defense yet.
                            <button @click="showGradeForm = true" class="btn btn-sm btn-primary ms-2">
                                <i class="ri-add-line me-1"></i>Submit Grade
                            </button>
                        </div>

                        <!-- Grade Form -->
                        <div v-if="showGradeForm" class="border rounded p-3 bg-white mt-3">
                            <h6 class="mb-3">{{ myGrade ? 'Update' : 'Submit' }} Grade</h6>
                            <form @submit.prevent="submitGrade">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">
                                        Grade (out of {{ maxGrade }})
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input
                                        v-model="gradeForm.grade"
                                        type="number"
                                        step="0.01"
                                        min="0"
                                        :max="maxGrade"
                                        class="form-control"
                                        :class="{ 'is-invalid': gradeForm.errors.grade }"
                                        required
                                    />
                                    <div v-if="gradeForm.errors.grade" class="invalid-feedback">
                                        {{ gradeForm.errors.grade }}
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Feedback</label>
                                    <textarea
                                        v-model="gradeForm.feedback"
                                        class="form-control"
                                        rows="4"
                                        :class="{ 'is-invalid': gradeForm.errors.feedback }"
                                        placeholder="Enter your feedback..."
                                    ></textarea>
                                    <div v-if="gradeForm.errors.feedback" class="invalid-feedback">
                                        {{ gradeForm.errors.feedback }}
                                    </div>
                                </div>
                                <div class="d-flex gap-2">
                                    <button
                                        type="submit"
                                        class="btn btn-primary"
                                        :disabled="gradeForm.processing"
                                    >
                                        <i class="ri-save-line me-1"></i>
                                        {{ gradeForm.processing ? 'Submitting...' : 'Submit Grade' }}
                                    </button>
                                    <button
                                        type="button"
                                        @click="showGradeForm = false"
                                        class="btn btn-outline-secondary"
                                        :disabled="gradeForm.processing"
                                    >
                                        Cancel
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Total Grade Display (if fully graded) -->
                        <div
                            v-if="defense.total_grade !== null"
                            class="border rounded p-3 bg-success bg-opacity-10 mt-3"
                        >
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <strong class="text-muted small">Total Defense Grade:</strong>
                                    <div class="text-success fs-4 fw-bold">
                                        {{ defense.total_grade }} / {{ maxGrade }}
                                    </div>
                                    <small class="text-muted">Average of all committee members' grades</small>
                                </div>
                                <i class="ri-checkbox-circle-fill text-success fs-1"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Record Information -->
                    <div class="border-top pt-3 mt-4">
                        <div class="row">
                            <div class="col-md-6">
                                <small class="text-muted">Created By:</small>
                                <div class="text-dark">{{ defense.creator?.name || 'N/A' }}</div>
                            </div>
                            <div class="col-md-6">
                                <small class="text-muted">Created At:</small>
                                <div class="text-dark">{{ formatDate(defense.created_at) }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
