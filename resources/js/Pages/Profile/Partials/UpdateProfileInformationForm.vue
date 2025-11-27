<script setup>
import { useForm, usePage } from '@inertiajs/vue3';
import {useAlert} from "@/Composables/useAlert.js";
import {useUploadImage} from "@/Composables/useUploadImage.js";
import {ref} from "vue";

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const form = useForm({
    name: usePage().props.auth.user.name,
    email: usePage().props.auth.user.email,
    first_name: usePage().props.auth.user.first_name,
    last_name: usePage().props.auth.user.last_name,
    mobile: usePage().props.auth.user.mobile,
    address: usePage().props.auth.user.address,
    gender: usePage().props.auth.user.gender,
    date_of_birth: usePage().props.auth.user.date_of_birth,
    images: []
});

let savedImages = ref([]);

let imagePaths = ref(usePage().props.auth.user.media_urls);
if (imagePaths.value) {
    for(let i = 0; i < imagePaths.value.length; i++) {
        let filename = imagePaths.value[i].substring(imagePaths.value[i].lastIndexOf('/') + 1);
        form.images.push(filename);
    }
}

let {
    FilePond,
    pond,
    handleFilePondLoad,
    handleFilePondRevert,
    handleFilePondInit,
    handleFilePondRemove
} = useUploadImage(form, savedImages, imagePaths);

const updateProfile = () => {
    form.patch(route('profile.update'), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'success',
                title: 'Profile Updated!'
            });
        }
    });
}
</script>

<template>
    <div class="card border-0 shadow mb-4 mb-md-0">
        <div class="card-header">
            <h5 class="mb-0"><i class="ri-user-3-fill me-2 text-primary"></i>Update Profile Information</h5>
        </div>
        <div class="card-body">
            <form @submit.prevent="updateProfile">
                <label for="image">Avatar</label>
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
                                onload: handleFilePondLoad
                            },
                            revert: handleFilePondRevert,
                            remove: handleFilePondRemove,
                            headers: {
                                'X-CSRF-TOKEN': $page.props.csrf_token
                            },
                        }"
                    :credits="''"
                    :files="savedImages"
                    @init="handleFilePondInit"
                    filePosterMaxHeight="150"
                />
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-4">
                            <label for="name">Username <span class="text-danger">*</span></label>
                            <input v-model="form.name" type="text" name="name" class="form-control" id="name">
                            <span v-show="form.errors.name" class="text-danger">{{ form.errors.name }}</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-4">
                            <label for="email">Email address <span class="text-danger">*</span></label>
                            <input v-model="form.email" type="email" name="email" class="form-control" id="email">
                            <span v-show="form.errors.email" class="text-danger">{{ form.errors.email }}</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-4">
                            <label for="first_name">First Name</label>
                            <input v-model="form.first_name" type="text" name="first_name" class="form-control" id="first_name">
                            <span v-show="form.errors.first_name" class="text-danger">{{ form.errors.first_name }}</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-4">
                            <label for="last_name">Last Name</label>
                            <input v-model="form.last_name" type="text" name="last_name" class="form-control" id="last_name">
                            <span v-show="form.errors.last_name" class="text-danger">{{ form.errors.last_name }}</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="mb-4">
                            <label for="mobile">Contact Number</label>
                            <input v-model="form.mobile" type="text" name="mobile" class="form-control" id="mobile">
                            <span v-show="form.errors.mobile" class="text-danger">{{ form.errors.mobile }}</span>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-4">
                            <label for="gender">Gender</label>
                            <v-select
                                v-model="form.gender"
                                :options="['Male', 'Female']"
                                :placeholder="'Select Gender'"
                            ></v-select>
                            <span v-show="form.errors.gender" class="text-danger">{{ form.errors.gender }}</span>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-4">
                            <label for="date_of_birth">Date of Birth</label>
                            <v-datepicker
                                v-model="form.date_of_birth"
                                :placeholder="'Select Date'"
                                :teleport="true"
                                :enable-time-picker="false"
                                :format="'dd/MM/yyyy'"
                            >
                            </v-datepicker>
                            <span v-show="form.errors.date_of_birth" class="text-danger">{{ form.errors.date_of_birth }}</span>
                        </div>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="address">Address</label>
                    <input v-model="form.address" type="text" name="address" class="form-control" id="address">
                    <span v-show="form.errors.address" class="text-danger">{{ form.errors.address }}</span>
                </div>
                <div>
                    <button type="submit" class="btn btn-primary d-flex align-items-center" :disabled="form.processing">
                        <span>Save Changes</span>
                        <i class="ri-check-double-line ms-1 fs-5"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
</template>
