<script setup>
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';
import MainLayout from "@/Layouts/MainLayout.vue";

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});
</script>

<template>
    <Head title="Profile" />

    <MainLayout>
        <template #breadcrumb>
            <li class="breadcrumb-item active" aria-current="page">Edit Profile</li>
        </template>

        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="card border-0 shadow pattern-1">
                    <div class="card-body py-5">
                        <div class="d-flex flex-column align-items-center">
                            <img width="120" class="img-thumbnail rounded-circle" :src="$page.props.auth.user.avatar" alt="Profile Image">
                            <h2 class="display-3 mt-2 mb-2">
                                {{ $page.props.auth.user.name }}
                                <span class="badge rounded-pill bg-success px-4 py-2 mt-2">
                                    <span>Active</span>
                                </span>
                            </h2>
                            <h4 class="display-5">{{ $page.props.auth.user.email }}</h4>
                            <div class="badge rounded-pill bg-primary px-4 py-2">
                                <span v-for="role in $page.props.auth.user.roles" :key="role">{{ role }} <span v-if="$page.props.auth.user.roles.length > 1">|</span> </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12 mb-4">
                <div class="row">
                    <div class="col-md-7">
                        <UpdateProfileInformationForm
                            :must-verify-email="mustVerifyEmail"
                            :status="status"
                        />
                    </div>
                    <div class="col-md-5">
                        <UpdatePasswordForm />
                    </div>
                </div>
            </div>
        </div>
    </MainLayout>
</template>
