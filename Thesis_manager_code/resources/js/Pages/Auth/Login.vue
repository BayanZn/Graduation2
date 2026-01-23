<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
    canRegister: {
        type: Boolean,
    },
    branches: {
        type: Array,
    },
});

const form = useForm({
    email: '',
    password: '',
    branch_id: null,
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head>
            <title>Log in</title>
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
                                <div class="form-group mb-3">
                                    <label for="email">Email / Username <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text text-tertiary">
                                            <i class="ri-user-fill fs-6"></i>
                                        </span>
                                        <input
                                            v-model="form.email"
                                            type="email"
                                            name="email"
                                            class="form-control"
                                            placeholder=""
                                            id="email"
                                            autofocus
                                        />
                                    </div>
                                    <span v-show="form.errors.email" class="text-danger">{{ form.errors.email }}</span>
                                </div>

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
                                            placeholder=""
                                            class="form-control"
                                            id="password"
                                        />
                                    </div>
                                    <span v-show="form.errors.password" class="text-danger">{{
                                        form.errors.password
                                    }}</span>
                                </div>

                                <div class="d-flex justify-content-between align-items-top mb-4">
                                    <div class="form-check">
                                        <input
                                            v-model="form.remember"
                                            class="form-check-input"
                                            type="checkbox"
                                            value="1"
                                            id="remember"
                                            name="remember"
                                        />
                                        <label class="form-check-label mb-0" for="remember"> Remember me </label>
                                    </div>
                                    <!--                                        <div><Link :href="route('password.request')" class="small text-right">Lost-->
                                    <!--                                            password?</Link></div>-->
                                </div>
                                <div class="d-grid">
                                    <button
                                        :class="{ 'opacity-25': form.processing }"
                                        :disabled="form.processing"
                                        type="submit"
                                        class="btn btn-secondary fw-bolder text-white"
                                    >
                                        Sign in
                                    </button>
                                </div>
                            </form>

                            <div v-if="canRegister" class="d-flex justify-content-center align-items-center mt-4">
                                <span class="fw-normal">
                                    Not registered?
                                    <Link :href="route('register')" class="fw-bold">Create account</Link>
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
