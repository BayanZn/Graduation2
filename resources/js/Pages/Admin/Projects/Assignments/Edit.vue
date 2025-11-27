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
    project: {
        type: Object,
    },
    allProjects: {
        type: Array,
    },
    allSupervisors: {
        type: Array,
    },
    allStudents: {
        type: Array,
    },
});

const form = useForm({
    project_id: props.project.id,
    supervisors: props.project.supervisors.map((s) => s.id),
    students: props.project.students.map((s) => s.id),
});

const submit = () => {
    form.put(route('assignments.update', props.project.id), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'success',
                title: 'Assignment Updated!',
            });
        },
    });
};
</script>

<template>
    <Head title="Edit Assignment" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('assignments.index')">Project Assignments</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Edit Assignment</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <form @submit.prevent="submit">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Project</label>
                                    <div class="form-control bg-light d-flex align-items-center">
                                        <div>
                                            <strong>{{ project.title }}</strong>
                                            <span class="badge bg-info ms-2">{{ project.project_type }}</span>
                                            <br />
                                            <small class="text-muted" v-if="project.department">
                                                {{ project.department.name }}
                                            </small>
                                        </div>
                                    </div>
                                    <small class="text-muted">Project cannot be changed in edit mode</small>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Supervisors <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.supervisors"
                                        :options="allSupervisors"
                                        :reduce="(supervisor) => supervisor.id"
                                        label="name"
                                        multiple
                                        placeholder="Select supervisors"
                                        :class="{ 'border-2 border-danger': form.errors.supervisors }"
                                    >
                                        <template #option="{ name, email }">
                                            <div>
                                                <strong>{{ name }}</strong>
                                                <br />
                                                <small class="text-muted">{{ email }}</small>
                                            </div>
                                        </template>
                                    </v-select>
                                    <span v-show="form.errors.supervisors" class="text-danger">{{
                                        form.errors.supervisors
                                    }}</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Students <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.students"
                                        :options="allStudents"
                                        :reduce="(student) => student.id"
                                        label="name"
                                        multiple
                                        placeholder="Select students"
                                        :class="{ 'border-2 border-danger': form.errors.students }"
                                    >
                                        <template #option="{ name, email }">
                                            <div>
                                                <strong>{{ name }}</strong>
                                                <br />
                                                <small class="text-muted">{{ email }}</small>
                                            </div>
                                        </template>
                                    </v-select>
                                    <span v-show="form.errors.students" class="text-danger">{{
                                        form.errors.students
                                    }}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="row">
                            <div class="col-12">
                                <div class="d-flex justify-content-center">
                                    <button
                                        type="submit"
                                        class="btn btn-primary d-flex align-items-center"
                                        :disabled="form.processing"
                                    >
                                        <span>Update Assignment</span>
                                        <i class="ri-check-double-line ms-1 fs-5"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
