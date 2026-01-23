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
import { Head, Link, useForm } from '@inertiajs/vue3';
import 'quill/dist/quill.snow.css';
import { ref, toRef } from 'vue';

const props = defineProps({
    projects: {
        type: Array,
    },
    supervisors: {
        type: Array,
    },
});

// Quill editor ref
const editor = ref(null);

const form = useForm({
    project_id: null,
    discussion_hall: '',
    discussion_date: '',
    discussion_type: '',
    members: [],
    notes: '',
});

// Initialize Quill
const { quill, setContents } = useQuill({ containerRef: editor, model: toRef(form, 'notes') });

const submit = () => {
    form.post(route('defenses.store'), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'success',
                title: 'Defense Scheduled!',
            });
        },
    });
};

const resetForm = () => {
    form.reset();
    form.clearErrors();
    setContents('');
};
</script>

<template>
    <Head title="Schedule Defense" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('defenses.index')">Defense Scheduling</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Schedule Defense</li>
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

                            <div class="col-md-4">
                                <div class="mb-4">
                                    <label>Discussion Hall <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.discussion_hall"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.discussion_hall }"
                                        placeholder="e.g., Room 101, Auditorium A"
                                    />
                                    <span v-show="form.errors.discussion_hall" class="text-danger">{{
                                        form.errors.discussion_hall
                                    }}</span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="mb-4">
                                    <label>Discussion Date & Time <span class="text-danger">*</span></label>
                                    <v-datepicker
                                        v-model="form.discussion_date"
                                        :placeholder="'Select discussion date and time'"
                                        :teleport="true"
                                        :enable-time-picker="true"
                                        :format="'dd/MM/yyyy HH:mm'"
                                        :auto-apply="true"
                                        :close-on-auto-apply="true"
                                        :class="{ 'border-2 border-danger': form.errors.discussion_date }"
                                    >
                                    </v-datepicker>
                                    <span v-show="form.errors.discussion_date" class="text-danger">{{
                                        form.errors.discussion_date
                                    }}</span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="mb-4">
                                    <label>Discussion Type <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.discussion_type"
                                        :options="[
                                            { label: 'Proposal Defense', value: 'proposal' },
                                            { label: 'Seminar Defense', value: 'seminar' },
                                            { label: 'Final Defense', value: 'final' },
                                        ]"
                                        :reduce="(option) => option.value"
                                        label="label"
                                        placeholder="Select type"
                                        :class="{ 'border-2 border-danger': form.errors.discussion_type }"
                                    ></v-select>
                                    <span v-show="form.errors.discussion_type" class="text-danger">{{
                                        form.errors.discussion_type
                                    }}</span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Defense Members (Supervisors) <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.members"
                                        :options="supervisors"
                                        :reduce="(supervisor) => supervisor.id"
                                        label="name"
                                        multiple
                                        placeholder="Select defense members"
                                        :class="{ 'border-2 border-danger': form.errors.members }"
                                    >
                                        <template #option="{ name, email }">
                                            <div>
                                                <strong>{{ name }}</strong>
                                                <br />
                                                <small class="text-muted">{{ email }}</small>
                                            </div>
                                        </template>
                                    </v-select>
                                    <span v-show="form.errors.members" class="text-danger">{{
                                        form.errors.members
                                    }}</span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Notes</label>
                                    <div
                                        ref="editor"
                                        style="height: 200px"
                                        :class="{ 'border-2 border-danger': form.errors.notes }"
                                    ></div>
                                    <span v-show="form.errors.notes" class="text-danger">{{ form.errors.notes }}</span>
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
                                        <span>Schedule Defense</span>
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
