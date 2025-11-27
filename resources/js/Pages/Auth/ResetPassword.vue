<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import {Head, useForm, Link} from '@inertiajs/vue3';
import {useAlert} from "@/Composables/useAlert.js";

const props = defineProps({
    email: {
        type: String,
        required: true,
    },
    token: {
        type: String,
        required: true,
    },
});

const form = useForm({
    token: props.token,
    email: props.email,
    password: '',
    password_confirmation: '',
});

const submit = () => {
    let { Toast } = useAlert();

    form.post(route('password.store'), {
        onSuccess: () => {
            Toast.fire({
                icon: 'success',
                title: 'Password Changed!'
            });
        },
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Reset Password"/>

        <section class="vh-lg-100 mt-5 mt-lg-0 bg-soft d-flex align-items-center">
            <div class="container">
                <div class="row justify-content-center form-bg-image">
                    <p class="text-center text-secondary fw-bolder">
                        <Link :href="route('login')"
                           class="d-flex align-items-center justify-content-center">
                            <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                      d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z"
                                      clip-rule="evenodd"></path>
                            </svg>
                            Back to sign in
                        </Link>
                    </p>
                    <div class="col-12 d-flex align-items-center justify-content-center">
                        <div class="bg-white shadow border-0 rounded p-4 p-lg-5 w-100 fmxw-500">
                            <h1 class="h3 mb-4">Reset password</h1>
                            <form @submit.prevent="submit">
                                <!-- Form -->
                                <div class="mb-4">
                                    <label for="email">Your Email <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input v-model="form.email" type="email" class="form-control" placeholder="example@company.com"
                                               id="email" disabled>
                                    </div>
                                    <span v-show="form.errors.email" class="text-danger">{{ form.errors.email }}</span>
                                </div>
                                <!-- End of Form -->
                                <!-- Form -->
                                <div class="form-group mb-4">
                                    <label for="password">New Password <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text" id="basic-addon2">
                                            <svg class="icon icon-xs text-gray-600" fill="currentColor"
                                                 viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd"
                                                      d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z"
                                                      clip-rule="evenodd"></path>
                                            </svg>
                                        </span>
                                        <input v-model="form.password" type="password" placeholder="New Password" class="form-control" id="password">
                                    </div>
                                    <span v-show="form.errors.password" class="text-danger">{{ form.errors.password }}</span>
                                </div>
                                <!-- End of Form -->
                                <!-- Form -->
                                <div class="form-group mb-4">
                                    <label for="confirm_password">Confirm Password <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text" id="basic-addon2">
                                            <svg class="icon icon-xs text-gray-600" fill="currentColor"
                                                 viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd"
                                                      d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z"
                                                      clip-rule="evenodd"></path>
                                            </svg>
                                        </span>
                                        <input v-model="form.password_confirmation" type="password" placeholder="Confirm Password" class="form-control"
                                               id="confirm_password">
                                    </div>
                                    <span v-show="form.errors.password_confirmation" class="text-danger">{{ form.errors.password_confirmation }}</span>
                                </div>
                                <!-- End of Form -->
                                <div class="d-grid">
                                    <button :class="{ 'opacity-25': form.processing }" :disabled="form.processing" type="submit" class="btn btn-secondary fw-bolder">Reset password</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </GuestLayout>
</template>
