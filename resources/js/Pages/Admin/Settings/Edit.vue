<script>
import MainLayout from '@/Layouts/MainLayout.vue';

export default {
    layout: MainLayout,
};
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { Tooltip } from 'bootstrap';
import { onMounted, ref } from 'vue';

const props = defineProps({
    setting: {
        type: Object,
    },
    currencies: {
        type: Array,
    },
    timezones: {
        type: Array,
    },
});

console.log(props.timezones);

// Tooltip
let tooltip = ref(null);
let btnTooltip;

onMounted(() => {
    btnTooltip = new Tooltip(tooltip.value);
});

const form = useForm({
    currency_id: props.setting.currency_id,
    company_name: props.setting.company_name,
    company_email: props.setting.company_email,
    company_mobile: props.setting.company_mobile,
    currency_position: props.setting.currency_position,
    company_address: props.setting.company_address,
    vat_id: props.setting.vat_id,
    tax_percentage: props.setting.tax_percentage,
    decimal_point: props.setting.decimal_point,
    date_format: props.setting.date_format,
    time_format: props.setting.time_format,
    time_zone: props.setting.time_zone,
    logo: '',
    favicon: '',
});

// Update settings
const updateSettings = () => {
    form.post(route('settings.update', props.setting), {
        _method: 'put',
        preserveScroll: true,
        onSuccess: () => {
            let { Toast } = useAlert();

            Toast.fire({
                icon: 'info',
                title: 'Settings Updated!',
            });

            form.reset('logo', 'favicon');
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
    <Head title="Settings" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('settings.edit')" class="fw-bold text-secondary">Settings</Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Edit</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <form @submit.prevent="updateSettings">
                        <div class="row">
                            <div class="col-12">
                                <p class="border-bottom border-gray-200 fs-5 text-secondary">Company Settings</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Logo</label>
                                    <img
                                        style="min-width: 65px; max-height: 100px"
                                        :src="$page.props.settings.logo"
                                        alt="Logo"
                                        class="d-block mb-2"
                                    />
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.logo }"
                                        @input="form.logo = $event.target.files[0]"
                                    />
                                    <span v-show="form.errors.logo" class="text-danger">{{ form.errors.logo }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Favicon</label>
                                    <img
                                        style="min-width: 65px; max-height: 100px"
                                        :src="$page.props.settings.favicon"
                                        alt="Favicon"
                                        class="d-block mb-2"
                                    />
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.favicon }"
                                        @input="form.favicon = $event.target.files[0]"
                                    />
                                    <span v-show="form.errors.favicon" class="text-danger">{{
                                        form.errors.favicon
                                    }}</span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-4">
                                    <label>Company Name <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.company_name"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.company_name }"
                                    />
                                    <span v-show="form.errors.company_name" class="text-danger">{{
                                        form.errors.company_name
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-4">
                                    <label>Email <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.company_email"
                                        type="email"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.company_email }"
                                    />
                                    <span v-show="form.errors.company_email" class="text-danger">{{
                                        form.errors.company_email
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-4">
                                    <label>Mobile No. <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.company_mobile"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.company_mobile }"
                                    />
                                    <span v-show="form.errors.company_mobile" class="text-danger">{{
                                        form.errors.company_mobile
                                    }}</span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Address <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.company_address"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.company_address }"
                                    />
                                    <span v-show="form.errors.company_address" class="text-danger">{{
                                        form.errors.company_address
                                    }}</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <p class="border-bottom border-gray-200 fs-5 text-secondary">Tax Info</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>GST Number</label>
                                    <input
                                        v-model="form.vat_id"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.vat_id }"
                                    />
                                    <span v-show="form.errors.vat_id" class="text-danger">{{
                                        form.errors.vat_id
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Default Tax Percentage (%) <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.tax_percentage"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.tax_percentage }"
                                    />
                                    <span v-show="form.errors.tax_percentage" class="text-danger">{{
                                        form.errors.tax_percentage
                                    }}</span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <p class="border-bottom border-gray-200 fs-5 text-secondary">Time Settings</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-5">
                                <div class="mb-4">
                                    <label>Date Format <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.date_format"
                                        label="label"
                                        :options="[
                                            { value: 'DD-MM-YYYY', label: '(09-11-1998) DD-MM-YYYY' },
                                            { value: 'MM-DD-YYYY', label: '(11-09-1998) MM-DD-YYYY' },
                                            { value: 'DD/MM/YYYY', label: '(09/11/1998) DD/MM/YYYY' },
                                            { value: 'MM/DD/YYYY', label: '(11/09/1998) MM/DD/YYYY' },
                                            { value: 'Do MMM, YYYY', label: '(9th Nov, 1998) Do MMM, YYYY' },
                                        ]"
                                        :placeholder="'Select Date Format'"
                                        :class="{ 'border-2 border-danger': form.errors.date_format }"
                                        :reduce="(option) => option.value"
                                    ></v-select>
                                    <span v-show="form.errors.date_format" class="text-danger">{{
                                        form.errors.date_format
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-4">
                                    <label>Timezone <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.time_zone"
                                        label="label"
                                        :options="timezones"
                                        :placeholder="'Select Timezone'"
                                        :class="{ 'border-2 border-danger': form.errors.time_zone }"
                                    ></v-select>
                                    <span v-show="form.errors.time_zone" class="text-danger">{{
                                        form.errors.time_zone
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-4">
                                    <label>Time Format <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.time_format"
                                        label="label"
                                        :options="[
                                            { value: '24H', label: '24 Hours' },
                                            { value: '12H', label: '12 Hours' },
                                        ]"
                                        :placeholder="'Select Time Format'"
                                        :class="{ 'border-2 border-danger': form.errors.time_format }"
                                        :reduce="(option) => option.value"
                                    ></v-select>
                                    <span v-show="form.errors.time_format" class="text-danger">{{
                                        form.errors.time_format
                                    }}</span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <p class="border-bottom border-gray-200 fs-5 text-secondary">Currency Settings</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-5">
                                <div class="mb-4">
                                    <label>Default Currency <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.currency_id"
                                        :options="currencies"
                                        :class="{ 'border-2 border-danger': form.errors.currency_id }"
                                        :placeholder="'Select Currency'"
                                        label="currency_name"
                                        :reduce="(currency) => currency.id"
                                    ></v-select>
                                    <span v-show="form.errors.currency_id" class="text-danger">{{
                                        form.errors.currency_id
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="mb-4">
                                    <label>Currency Position <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.currency_position"
                                        label="label"
                                        :options="[
                                            { value: 'suffix', label: 'Suffix (ex: 1,000$)' },
                                            { value: 'prefix', label: 'Prefix (ex: $1,000)' },
                                            { value: 'suffix_space', label: 'Suffix with space (ex: 1,000 $)' },
                                            { value: 'prefix_space', label: 'Prefix with space (ex: $ 1,000)' },
                                        ]"
                                        :placeholder="'Select Opening Balance Type'"
                                        :class="{ 'border-2 border-danger': form.errors.currency_position }"
                                        :reduce="(option) => option.value"
                                    ></v-select>
                                    <span v-show="form.errors.currency_position" class="text-danger">{{
                                        form.errors.currency_position
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="mb-4">
                                    <label>Decimal Point <span class="text-danger">*</span></label>
                                    <div class="form-check form-switch">
                                        <input
                                            class="form-check-input cursor-pointer"
                                            type="checkbox"
                                            id="decimal_point"
                                            v-model="form.decimal_point"
                                            true-value="1"
                                            false-value="0"
                                        />
                                        <label class="form-check-label cursor-pointer" for="decimal_point">
                                            <span v-if="form.decimal_point == 1" class="text-success"
                                                >Enabled
                                                <span class="text-info"
                                                    >(If disabled then value will round up)</span
                                                ></span
                                            >
                                            <span v-else class="text-danger"
                                                >Disabled
                                                <span class="text-info"
                                                    >(If disabled then money will round up)</span
                                                ></span
                                            >
                                        </label>
                                    </div>
                                    <span v-show="form.errors.decimal_point" class="text-danger">{{
                                        form.errors.decimal_point
                                    }}</span>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center">
                            <button
                                type="submit"
                                class="btn btn-primary d-flex align-items-center"
                                :disabled="form.processing"
                            >
                                <span>Update Settings</span>
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
