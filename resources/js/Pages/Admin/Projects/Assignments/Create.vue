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
    projects: {
        type: Array,
    },
    supervisors: {
        type: Array,
    },
    students: {
        type: Array,
    },
});

const form = useForm({
    project_id: null,
    supervisors: [],
    students: [],
});

const submit = () => {
    form.post(route('assignments.store'), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'success',
                title: 'Assignment Created!',
            });
        },
    });
};

const resetForm = () => {
    form.reset();
    form.clearErrors();
};
</script>

<template>
    <Head title="Assign Project" />

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
        <li class="breadcrumb-item active" aria-current="page">Assign Project</li>
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
                                    <label>Project <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.project_id"
                                        :options="projects"
                                        :reduce="(project) => project.id"
                                        label="title"
                                        placeholder="Select a project"
                                        :class="{ 'border-2 border-danger': form.errors.project_id }"
                                    >
                                        <template #option="{ title, project_type, department }">
                                            <div>
                                                <strong>{{ title }}</strong>
                                                <br />
                                                <small class="text-muted">
                                                    {{ project_type }} - {{ department?.name || 'N/A' }}
                                                </small>
                                            </div>
                                        </template>
                                    </v-select>
                                    <span v-show="form.errors.project_id" class="text-danger">{{
                                        form.errors.project_id
                                    }}</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Supervisors <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.supervisors"
                                        :options="supervisors"
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
                                        :options="students"
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
                                        <span>Assign Project</span>
                                        <i class="ri-check-double-line ms-1 fs-5"></i>
                                    </button>
                                    <button
                                        type="button"
                                        @click.prevent="resetForm"
                                        class="btn btn-danger d-flex align-items-center ms-2"
                                        :disabled="form.processing"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        data-bs-title="Reset Form"
                                    >
                                        <i class="ri-loop-left-line fs-5"></i>
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
