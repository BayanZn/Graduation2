<script setup>
import { useForm } from '@inertiajs/vue3';
import { ref } from 'vue';
import {useAlert} from "@/Composables/useAlert.js";

const passwordInput = ref(null);
const currentPasswordInput = ref(null);

const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updatePassword = () => {
    form.put(route('password.update'), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'success',
                title: 'Password Updated!'
            });

            form.reset();
        },
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                passwordInput.value.focus();
            }
            if (form.errors.current_password) {
                form.reset('current_password');
                currentPasswordInput.value.focus();
            }
        },
    });
};
</script>

<template>
    <div class="card border-0 shadow">
        <div class="card-header">
            <h5 class="mb-0"><i class="ri-lock-2-fill me-2 text-primary"></i>Update Password</h5>
        </div>
        <div class="card-body">
            <form @submit.prevent="updatePassword">
                <div class="mb-4">
                    <label for="current_password">Current Password <span class="text-danger">*</span></label>
                    <input v-model="form.current_password" type="password" name="current_password" class="form-control" id="current_password">
                    <span v-show="form.errors.current_password" class="text-danger">{{ form.errors.current_password }}</span>
                </div>
                <div class="mb-4">
                    <label for="password">New Password <span class="text-danger">*</span></label>
                    <input v-model="form.password" type="password" name="password" class="form-control" id="password">
                    <span v-show="form.errors.password" class="text-danger">{{ form.errors.password }}</span>
                </div>
                <div class="mb-4">
                    <label for="password_confirmation">Confirm Password <span class="text-danger">*</span></label>
                    <input v-model="form.password_confirmation" type="password" name="password_confirmation" class="form-control" id="password_confirmation">
                    <span v-show="form.errors.password_confirmation" class="text-danger">{{ form.errors.password_confirmation }}</span>
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
