import '../css/app.css';
import './bootstrap';
import './main.js';

import { createInertiaApp } from '@inertiajs/vue3';
import VueDatePicker from '@vuepic/vue-datepicker';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { createApp, h } from 'vue';
import vSelect from 'vue-select';
import { ZiggyVue } from '../../vendor/tightenco/ziggy/dist/vue.m';

const appName = import.meta.env.VITE_APP_NAME || 'Application';

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        // Make user data available globally for Echo
        window.Laravel = window.Laravel || {};
        window.Laravel.user = props.initialPage.props.auth?.user;

        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue, Ziggy)
            .component('v-select', vSelect)
            .component('v-datepicker', VueDatePicker)
            .mount(el);
    },
    progress: {
        color: 'linear-gradient(to right, #4f46e5, #3b82f6, #06b6d4)',
        includeCSS: true,
        showSpinner: false,
    },
});
