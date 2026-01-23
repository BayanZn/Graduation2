<script>
import { useTooltips } from '@/Composables/useTooltips';
import MainLayout from '@/Layouts/MainLayout.vue';

export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { useQuill } from '@/Composables/useQuill.js';
import { Head, Link, useForm } from '@inertiajs/vue3';
import 'quill/dist/quill.snow.css';
import { onMounted, ref, toRef } from 'vue';

useTooltips();

const props = defineProps({
    project: {
        type: Object,
    },
    departments: {
        type: Array,
    },
    specializations: {
        type: Array,
    },
    user_specialization_id: {
        type: Number,
        default: null,
    },
});

// Quill editor ref
const editor = ref(null);

onMounted(() => {
    // Set initial Quill content
    if (props.project.description) {
        setContents(props.project.description);
    }
});

const form = useForm({
    title: props.project.title,
    description: props.project.description,
    project_type: props.project.project_type,
    specialization_id: props.project.specialization_id,
    department_id: props.project.department_id,
});

// Initialize Quill
const { quill, setContents } = useQuill({ containerRef: editor, model: toRef(form, 'description') });

// Update project
const update = () => {
    form.put(route('supervisor.projects.update', props.project.id), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'success',
                title: 'Project Updated!',
            });
        },
    });
};
</script>

<template>
    <Head title="Edit Project" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item">
            <Link :href="route('supervisor.dashboard')">Dashboard</Link>
        </li>
        <li class="breadcrumb-item">
            <Link :href="route('supervisor.projects.index')">My Project Ideas</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Edit</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <form @submit.prevent="update">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Title <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.title"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.title }"
                                    />
                                    <span v-show="form.errors.title" class="text-danger">{{ form.errors.title }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Project Type <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.project_type"
                                        :options="['Semester', 'Graduation 1', 'Graduation 2']"
                                        placeholder="Select Project Type"
                                        :class="{ 'border-2 border-danger': form.errors.project_type }"
                                    ></v-select>
                                    <span v-show="form.errors.project_type" class="text-danger">{{
                                        form.errors.project_type
                                    }}</span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Department <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.department_id"
                                        :options="departments"
                                        :reduce="(department) => department.id"
                                        label="name"
                                        placeholder="Select Department"
                                        :class="{ 'border-2 border-danger': form.errors.department_id }"
                                    ></v-select>
                                    <span v-show="form.errors.department_id" class="text-danger">{{
                                        form.errors.department_id
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Specialization <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.specialization_id"
                                        :options="specializations"
                                        :reduce="(specialization) => specialization.id"
                                        label="name"
                                        placeholder="Select Specialization"
                                        :disabled="!!user_specialization_id"
                                        :class="{ 'border-2 border-danger': form.errors.specialization_id }"
                                    ></v-select>
                                    <span v-show="form.errors.specialization_id" class="text-danger">{{
                                        form.errors.specialization_id
                                    }}</span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Description <span class="text-danger">*</span></label>
                                    <div
                                        ref="editor"
                                        style="height: 200px"
                                        :class="{ 'border-2 border-danger': form.errors.description }"
                                    ></div>
                                    <span v-show="form.errors.description" class="text-danger">{{
                                        form.errors.description
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
                                        <span>Update Project</span>
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
