<script>
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { useUploadImage } from '@/Composables/useUploadImage.js';
import MainLayout from '@/Layouts/MainLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { Tooltip } from 'bootstrap';
import { computed, onMounted, ref } from 'vue';

const props = defineProps({
    user: {
        type: Object,
    },
    roles: {
        type: Object,
    },
    specializations: {
        type: Array,
    },
});

// Tooltip
let tooltip = ref(null);
let btnTooltip = null;

onMounted(() => {
    btnTooltip = new Tooltip(tooltip.value);
});

const form = useForm({
    name: props.user.name,
    email: props.user.email,
    role: props.user.roles[0].name,
    specialization_id: props.user.specialization_id,
    images: [],
});

const isStudent = computed(() => {
    // In edit, form.role might be a name or an ID depending on how it's initialized
    // props.user.roles[0].name is used initially
    const selectedRole = props.roles.find((r) => r.id === form.role || r.name === form.role);
    return selectedRole && selectedRole.name.toLowerCase() === 'student';
});

// Keep saved images for edit
let savedImages = ref([]);

// Keep image paths for edit
let imagePaths = ref(props.user.media.map((img) => img.original_url));
if (imagePaths.value) {
    for (let i = 0; i < imagePaths.value.length; i++) {
        let filename = imagePaths.value[i].substring(imagePaths.value[i].lastIndexOf('/') + 1);
        form.images.push(filename);
    }
}

// Initialize FilePond
let { FilePond, pond, handleFilePondLoad, handleFilePondRevert, handleFilePondInit, handleFilePondRemove } =
    useUploadImage(form, savedImages, imagePaths);

// Update user
const update = () => {
    form.put(route('users.update', props.user), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'info',
                title: 'User Updated!',
            });
        },
    });
};

// Reset form
const resetForm = () => {
    form.reset();
    form.clearErrors();
    btnTooltip.hide();
};
</script>

<template>
    <Head title="Users" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('users.index')" class="fw-bold text-secondary">Users</Link>
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
                            <div class="col-xl-9">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-4">
                                            <label>Name <span class="text-danger">*</span></label>
                                            <input
                                                v-model="form.name"
                                                type="text"
                                                class="form-control"
                                                :class="{ 'border-2 border-danger': form.errors.name }"
                                            />
                                            <span v-show="form.errors.name" class="text-danger">{{
                                                form.errors.name
                                            }}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-4">
                                            <label>Email <span class="text-danger">*</span></label>
                                            <input
                                                v-model="form.email"
                                                type="text"
                                                class="form-control"
                                                :class="{ 'border-2 border-danger': form.errors.email }"
                                            />
                                            <span v-show="form.errors.email" class="text-danger">{{
                                                form.errors.email
                                            }}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-4">
                                            <label>Role <span class="text-danger">*</span></label>
                                            <v-select
                                                v-model="form.role"
                                                :options="roles"
                                                :class="{ 'border-2 border-danger': form.errors.role }"
                                                :placeholder="'Select Role'"
                                                label="name"
                                                :reduce="(role) => role.id"
                                            ></v-select>
                                            <span v-show="form.errors.role" class="text-danger">{{
                                                form.errors.role
                                            }}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-4">
                                            <label>Specialization</label>
                                            <v-select
                                                v-model="form.specialization_id"
                                                :options="specializations"
                                                :class="{ 'border-2 border-danger': form.errors.specialization_id }"
                                                :placeholder="'Select Specialization'"
                                                label="name"
                                                :reduce="(specialization) => specialization.id"
                                            ></v-select>
                                            <span v-show="form.errors.specialization_id" class="text-danger">{{
                                                form.errors.specialization_id
                                            }}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3">
                                <label>Profile Image <span class="text-danger">*</span></label>
                                <file-pond
                                    name="image"
                                    ref="pond"
                                    label-idle="Drag & Drop your files or <span class='filepond--label-action' tabindex='0'>Browse</span>"
                                    :allow-multiple="false"
                                    accepted-file-types="image/jpeg, image/png"
                                    maxFileSize="1MB"
                                    maxParallelUploads="1"
                                    :server="{
                                        url: '',
                                        timeout: 7000,
                                        process: {
                                            url: route('filepond.upload'),
                                            method: 'POST',
                                            onload: handleFilePondLoad,
                                        },
                                        revert: handleFilePondRevert,
                                        remove: handleFilePondRemove,
                                        headers: {
                                            'X-CSRF-TOKEN': $page.props.csrf_token,
                                        },
                                    }"
                                    :credits="''"
                                    :files="savedImages"
                                    @init="handleFilePondInit"
                                    filePosterMaxHeight="150"
                                />
                            </div>
                        </div>

                        <div class="d-flex justify-content-center">
                            <button
                                type="submit"
                                class="btn btn-primary d-flex align-items-center"
                                :disabled="form.processing"
                            >
                                <span>Update User</span>
                                <i class="ri-check-double-line ms-1 fs-5"></i>
                            </button>
                            <button
                                type="button"
                                @click.prevent="resetForm"
                                ref="tooltip"
                                class="btn btn-danger d-flex align-items-center ms-2"
                                :disabled="form.processing"
                                data-bs-toggle="tooltip"
                                data-bs-placement="top"
                                data-bs-title="Reset Form"
                            >
                                <i class="ri-loop-left-line ms-1 fs-5"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
