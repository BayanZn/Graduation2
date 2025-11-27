<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

defineProps({
    roles: {
        type: Array,
        required: true,
    },
});

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    role_id: null,
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head>
            <title>Register</title>
            <link rel="icon" type="image/png" sizes="32x32" :href="$page.props.settings?.favicon" />
        </Head>

        <section class="vh-lg-100 mt-5 mt-lg-0 bg-soft d-flex align-items-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 d-flex align-items-center justify-content-center">
                        <div class="bg-white shadow border-0 rounded border-light p-4 p-lg-4 w-100 fmxw-500">
                            <!-- App Logo -->
                            <div class="d-flex justify-content-center align-items-center">
                                <img width="100" class="py-2" src="/images/app-logo-dark.png" alt="App Logo" />
                            </div>

                            <form @submit.prevent="submit" class="mt-3">
                                <!-- Name Field -->
                                <div class="form-group mb-3">
                                    <label for="name">Full Name <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text text-tertiary">
                                            <i class="ri-user-fill fs-6"></i>
                                        </span>
                                        <input
                                            v-model="form.name"
                                            type="text"
                                            name="name"
                                            class="form-control"
                                            placeholder="Enter your full name"
                                            id="name"
                                            autofocus
                                            required
                                        />
                                    </div>
                                    <span v-show="form.errors.name" class="text-danger">{{ form.errors.name }}</span>
                                </div>

                                <!-- Email Field -->
                                <div class="form-group mb-3">
                                    <label for="email">Email <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text text-tertiary">
                                            <i class="ri-mail-fill fs-6"></i>
                                        </span>
                                        <input
                                            v-model="form.email"
                                            type="email"
                                            name="email"
                                            class="form-control"
                                            placeholder="name@example.com"
                                            id="email"
                                            required
                                        />
                                    </div>
                                    <span v-show="form.errors.email" class="text-danger">{{ form.errors.email }}</span>
                                </div>

                                <!-- Role Field -->
                                <div class="mb-3">
                                    <label for="branch">Register as <span class="text-danger">*</span></label>
                                    <div class="d-flex">
                                        <div class="input-group-text text-tertiary !tw-border-r-0 !tw-rounded-r-none">
                                            <i class="ri-briefcase-fill fs-6"></i>
                                        </div>
                                        <v-select
                                            class="w-100 branch-select"
                                            v-model="form.role_id"
                                            :options="roles"
                                            label="name"
                                            :reduce="(role) => role.id"
                                            placeholder="Select Role"
                                        />
                                    </div>
                                    <span v-show="form.errors.role_id" class="text-danger">{{
                                        form.errors.role_id
                                    }}</span>
                                </div>

                                <!-- Password Field -->
                                <div class="form-group mb-3">
                                    <label for="password">Password <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text text-tertiary">
                                            <i class="ri-lock-password-fill fs-6"></i>
                                        </span>
                                        <input
                                            v-model="form.password"
                                            type="password"
                                            name="password"
                                            placeholder="Enter password"
                                            class="form-control"
                                            id="password"
                                            required
                                        />
                                    </div>
                                    <span v-show="form.errors.password" class="text-danger">{{
                                        form.errors.password
                                    }}</span>
                                </div>

                                <!-- Confirm Password Field -->
                                <div class="form-group mb-3">
                                    <label for="password_confirmation"
                                        >Confirm Password <span class="text-danger">*</span></label
                                    >
                                    <div class="input-group">
                                        <span class="input-group-text text-tertiary">
                                            <i class="ri-lock-password-line fs-6"></i>
                                        </span>
                                        <input
                                            v-model="form.password_confirmation"
                                            type="password"
                                            name="password_confirmation"
                                            placeholder="Re-enter password"
                                            class="form-control"
                                            id="password_confirmation"
                                            required
                                        />
                                    </div>
                                    <span v-show="form.errors.password_confirmation" class="text-danger">{{
                                        form.errors.password_confirmation
                                    }}</span>
                                </div>

                                <!-- Submit Button -->
                                <div class="d-grid">
                                    <button
                                        :class="{ 'opacity-25': form.processing }"
                                        :disabled="form.processing"
                                        type="submit"
                                        class="btn btn-secondary fw-bolder text-white"
                                    >
                                        Create Account
                                    </button>
                                </div>
                            </form>

                            <!-- Login Link -->
                            <div class="d-flex justify-content-center align-items-center mt-4">
                                <span class="fw-normal">
                                    Already registered?
                                    <Link :href="route('login')" class="fw-bold">Sign in</Link>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </GuestLayout>
</template>

<style scoped>
.branch-select ::v-deep .vs__dropdown-toggle {
    border-top-left-radius: 0 !important;
    border-bottom-left-radius: 0 !important;
    padding: 0.4rem 1rem !important;
}
</style>
