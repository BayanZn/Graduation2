<script>
export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import PermissionGroup from '@/Components/PermissionGroup.vue';
import { useAlert } from '@/Composables/useAlert.js';
import MainLayout from '@/Layouts/MainLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { Tooltip } from 'bootstrap';
import { computed, onMounted, ref } from 'vue';

const props = defineProps({
    permissions: {
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
    name: '',
    permissions: [],
});

// Group permissions by category
const permissionGroups = computed(() => {
    const groups = [
        {
            title: 'Dashboard',
            icon: 'ri-dashboard-line',
            permissions: props.permissions.filter((p) => p.name === 'dashboard'),
        },
        {
            title: 'Specializations',
            icon: 'ri-book-mark-line',
            permissions: props.permissions.filter((p) => p.name.includes('specialization')),
        },
        {
            title: 'Departments',
            icon: 'ri-building-line',
            permissions: props.permissions.filter((p) => p.name.includes('department')),
        },
        {
            title: 'Projects',
            icon: 'ri-folder-line',
            permissions: props.permissions.filter(
                (p) => p.name.includes('project') && !p.name.includes('assignment') && !p.name.includes('defense'),
            ),
        },
        {
            title: 'Students',
            icon: 'ri-user-3-line',
            permissions: props.permissions.filter((p) => p.name.includes('student')),
        },
        {
            title: 'Supervisors',
            icon: 'ri-user-star-line',
            permissions: props.permissions.filter((p) => p.name.includes('supervisor')),
        },
        {
            title: 'Assignments',
            icon: 'ri-user-add-line',
            permissions: props.permissions.filter(
                (p) =>
                    p.name.includes('assignment') ||
                    p.name.includes('assign_student') ||
                    p.name.includes('assign_supervisor'),
            ),
        },
        {
            title: 'Defenses',
            icon: 'ri-calendar-event-line',
            permissions: props.permissions.filter((p) => p.name.includes('defense')),
        },
        {
            title: 'User Management',
            icon: 'ri-user-settings-line',
            permissions: props.permissions.filter((p) => p.name.includes('user') || p.name.includes('role')),
        },
        {
            title: 'Settings',
            icon: 'ri-settings-3-line',
            permissions: props.permissions.filter((p) => p.name.includes('settings')),
        },
        {
            title: 'Currencies',
            icon: 'ri-money-dollar-circle-line',
            permissions: props.permissions.filter((p) => p.name.includes('currency') || p.name.includes('currencies')),
        },
        {
            title: 'Reports',
            icon: 'ri-bar-chart-box-line',
            permissions: props.permissions.filter((p) => p.name.includes('report')),
        },
        {
            title: 'Activity Logs',
            icon: 'ri-history-line',
            permissions: props.permissions.filter((p) => p.name.includes('activity')),
        },
        {
            title: 'Support Chats',
            icon: 'ri-message-3-line',
            permissions: props.permissions.filter((p) => p.name.includes('support_chat')),
        },
        {
            title: 'Recycle Bin',
            icon: 'ri-delete-bin-line',
            permissions: props.permissions.filter((p) => p.name.includes('trash')),
        },
        {
            title: 'Settings',
            icon: 'ri-settings-3-line',
            permissions: props.permissions.filter((p) => p.name === 'setting'),
        },
        {
            title: 'Payment Methods',
            icon: 'ri-bank-card-line',
            permissions: props.permissions.filter((p) => p.name.includes('payment_method')),
        },
        {
            title: 'Taxes',
            icon: 'ri-percent-line',
            permissions: props.permissions.filter((p) => p.name.includes('tax')),
        },
        {
            title: 'Discounts',
            icon: 'ri-coupon-3-line',
            permissions: props.permissions.filter((p) => p.name.includes('discount')),
        },
        {
            title: 'Event Types',
            icon: 'ri-calendar-event-line',
            permissions: props.permissions.filter((p) => p.name.includes('event_type')),
        },
        {
            title: 'Units',
            icon: 'ri-scales-3-line',
            permissions: props.permissions.filter((p) => p.name.includes('unit')),
        },
        {
            title: 'Branches',
            icon: 'ri-building-4-line',
            permissions: props.permissions.filter((p) => p.name.includes('branch')),
        },
        {
            title: 'Event Calendar',
            icon: 'ri-calendar-2-line',
            permissions: props.permissions.filter((p) => p.name.includes('event') && !p.name.includes('type')),
        },
        {
            title: 'Products',
            icon: 'ri-shopping-bag-line',
            permissions: props.permissions.filter((p) => p.name.includes('product')),
        },
        {
            title: 'Customers',
            icon: 'ri-user-smile-line',
            permissions: props.permissions.filter((p) => p.name.includes('customer')),
        },
        {
            title: 'Quotations',
            icon: 'ri-file-text-line',
            permissions: props.permissions.filter((p) => p.name.includes('quotation')),
        },
        {
            title: 'Suppliers',
            icon: 'ri-truck-line',
            permissions: props.permissions.filter((p) => p.name.includes('supplier')),
        },
        {
            title: 'Purchases',
            icon: 'ri-shopping-cart-line',
            permissions: props.permissions.filter((p) => p.name.includes('purchase')),
        },
        {
            title: 'Sales',
            icon: 'ri-shopping-basket-line',
            permissions: props.permissions.filter((p) => p.name.includes('sale') && !p.name.includes('return')),
        },
        {
            title: 'Sale Returns',
            icon: 'ri-arrow-go-back-line',
            permissions: props.permissions.filter((p) => p.name.includes('sale_return')),
        },
        {
            title: 'Coupons',
            icon: 'ri-coupon-line',
            permissions: props.permissions.filter((p) => p.name.includes('coupon')),
        },
    ];

    // Filter out groups with no permissions
    return groups.filter((group) => group.permissions.length > 0);
});

// Store role
const store = () => {
    form.post(route('roles.store'), {
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'success',
                title: 'Role Created!',
            });

            form.reset();
        },
    });
};

// Reset form fields
const resetForm = () => {
    form.reset();
    form.clearErrors();
    btnTooltip.hide();
};
</script>

<template>
    <Head title="Roles" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('roles.index')" class="fw-bold text-secondary">Roles</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Create</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <form @submit.prevent="store">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Role Name <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.name"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.name }"
                                    />
                                    <span v-show="form.errors.name" class="text-danger">{{ form.errors.name }}</span>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label class="w-semibold mb-3"
                                        >Assigned Permissions <span class="text-danger">*</span></label
                                    >
                                    <span v-show="form.errors.permissions" class="text-danger d-block mb-2">{{
                                        form.errors.permissions
                                    }}</span>

                                    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-3">
                                        <div v-for="group in permissionGroups" :key="group.title" class="col">
                                            <PermissionGroup
                                                :title="group.title"
                                                :icon="group.icon"
                                                :permissions="group.permissions"
                                                v-model="form.permissions"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center">
                            <button
                                type="submit"
                                class="btn btn-primary d-flex align-items-center"
                                :disabled="form.processing"
                            >
                                <span>Create Role</span>
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
                                <i class="ri-loop-left-line fs-5"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
