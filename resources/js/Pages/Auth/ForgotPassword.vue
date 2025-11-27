<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import {Head, useForm, Link} from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <GuestLayout>
        <Head title="Forgot Password"/>

        <section class="vh-lg-100 mt-5 mt-lg-0 bg-soft d-flex align-items-center">
            <div class="container">
                <div class="row justify-content-center form-bg-image">
                    <p class="text-center text-secondary fw-bolder">
                        <Link
                            :href="route('login')"
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
                        <div
                            class="signin-inner my-3 my-lg-0 bg-white shadow border-0 rounded p-4 p-lg-5 w-100 fmxw-500">
                            <div v-if="status" class="alert alert-success">
                                {{ status }}
                            </div>
                            <h1 class="h3">Forgot your password?</h1>
                            <p class="mb-4">Don't panic! Just type in your email that is associated with your account and we will send you a code to reset your password!</p>
                            <form @submit.prevent="submit">
                                <!-- Form -->
                                <div class="mb-4">
                                    <label for="email">Your Email <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input v-model="form.email" type="email" class="form-control" id="email"
                                               placeholder="john@company.com" autofocus>
                                    </div>
                                    <span v-show="form.errors.email" class="text-danger">{{ form.errors.email }}</span>
                                </div>
                                <!-- End of Form -->
                                <div class="d-grid">
                                    <button :class="{ 'opacity-25': form.processing }" :disabled="form.processing" type="submit" class="btn btn-secondary fw-bolder">
                                        Email Password Reset Link
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </GuestLayout>
</template>
