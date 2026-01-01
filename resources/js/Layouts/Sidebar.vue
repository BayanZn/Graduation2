<script setup>
import ArrowLink from '@/Components/Icons/ArrowLink.vue';
import usePermission from '@/Composables/usePermission.js';
import useRole from '@/Composables/useRole';
import { Link, router } from '@inertiajs/vue3';
import { computed, ref } from 'vue';

const navbar = ref(null);
const body = ref(document.body);

const toggleNavbar = () => {
    if (navbar.value) {
        if (navbar.value.classList.contains('show')) {
            navbar.value.classList.remove('show');
        }
    }
    if (body.value.style.position === 'fixed') {
        body.value.style.position = 'relative';
    }
};

const isMobile = computed(() => {
    return window.innerWidth < 992;
});

if (isMobile) {
    router.on('success', (event) => {
        toggleNavbar();
    });
}
</script>

<template>
    <!-- Sidebar Menu Start -->
    <nav class="navbar navbar-dark navbar-theme-primary px-4 col-12 d-lg-none">
        <!-- Toggled Logo Start -->
        <Link class="navbar-brand me-lg-5" :href="route('dashboard')">
            <!--            &lt;!&ndash; dark &ndash;&gt;-->
            <!--            <img class="navbar-brand-dark" src="/images/app-logo.png" alt="App logo"/>-->
            <!--            &lt;!&ndash; light &ndash;&gt;-->
            <!--            <img class="navbar-brand-light" src="/images/app-logo.png" alt="App logo"/>-->

            <h5 class="text-white mb-0">Thesis Manager</h5>
        </Link>
        <!-- Toggled Logo End -->
        <!-- Siderbar Toggler Start -->
        <div class="d-flex align-items-center">
            <button
                class="navbar-toggler d-lg-none collapsed"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#sidebarMenu"
                aria-controls="sidebarMenu"
                aria-expanded="false"
                aria-label="Toggle navigation"
            >
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
        <!-- Sidebar Toggler End -->
    </nav>

    <nav
        ref="navbar"
        id="sidebarMenu"
        class="sidebar d-lg-block text-white collapse simplebar-scrollable-y shadow"
        data-simplebar
    >
        <div class="sidebar-inner tw-px-3 tw-pt-0">
            <!-- Mobile Nav Top Start -->
            <div
                class="user-card d-flex d-md-none align-items-center justify-content-between justify-content-md-center pb-4"
            >
                <div class="d-flex align-items-center">
                    <div class="avatar-lg me-4">
                        <img
                            :src="$page.props.auth.user.avatar"
                            class="card-img-top rounded-circle"
                            alt="Bonnie Green"
                        />
                    </div>
                    <div class="d-block">
                        <h2 class="h5 mb-3 mt-3">Welcome, {{ $page.props.auth.user.name }}</h2>
                        <Link
                            :href="route('logout')"
                            method="post"
                            as="button"
                            class="btn btn-secondary btn-sm d-inline-flex align-items-center"
                        >
                            <svg
                                class="icon icon-xxs me-1"
                                fill="none"
                                stroke="currentColor"
                                viewBox="0 0 24 24"
                                xmlns="http://www.w3.org/2000/svg"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
                                ></path>
                            </svg>
                            Logout
                        </Link>
                    </div>
                </div>
                <div class="collapse-close d-md-none">
                    <a
                        href="#sidebarMenu"
                        data-bs-toggle="collapse"
                        data-bs-target="#sidebarMenu"
                        aria-controls="sidebarMenu"
                        aria-expanded="true"
                        aria-label="Toggle navigation"
                    >
                        <i class="ri-close-circle-fill fs-1"></i>
                    </a>
                </div>
            </div>
            <!-- Mobile Nav Top End -->
            <ul class="nav flex-column pt-3 pt-md-1">
                <!-- Logo Start -->
                <li class="nav-item">
                    <Link
                        :href="route('dashboard')"
                        class="nav-link d-flex align-items-center justify-content-center hover:!tw-bg-transparent"
                    ><!--
                        <img class="app-logo me-2" width="30" :src="$page.props.settings.logo" alt="App Logo" />
                        <img
                            class="contracted-app-logo ms-4"
                            width="30"
                            :src="$page.props.settings.logo"
                            alt="App Logo"
                        />-->
                        <h6 class="app-logo mb-0">Thesis Manager</h6>
                        <!-- <h6 class="contracted-app-logo">FUN</h6> -->
                    </Link>
                </li>
                <!-- Logo End -->

                <!-- Menu Start -->
                <li class="nav-item" :class="route().current('*dashboard') ? 'active' : ''">
                    <Link :href="route('dashboard')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-home-2-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Dashboard</span>
                    </Link>
                </li>

                <li
                    v-if="usePermission('access_specializations')"
                    class="nav-item"
                    :class="route().current('specializations*') ? 'active' : ''"
                >
                    <Link :href="route('specializations.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-bookmark-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Specializations</span>
                    </Link>
                </li>

                <li
                    v-if="usePermission('access_departments')"
                    class="nav-item"
                    :class="route().current('departments*') ? 'active' : ''"
                >
                    <Link :href="route('departments.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-building-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Departments</span>
                    </Link>
                </li>

                <li v-if="usePermission('view_projects', 'view_assignments', 'view_defenses')" class="nav-item">
                    <span
                        id="hasArrow"
                        class="nav-link d-flex justify-content-between align-items-center"
                        :class="
                            route().current('projects*') ||
                            route().current('assignments*') ||
                            route().current('defenses*')
                                ? ''
                                : 'collapsed'
                        "
                        data-bs-toggle="collapse"
                        data-bs-target="#submenu-projects"
                    >
                        <span class="d-flex align-items-center">
                            <span class="sidebar-icon d-flex align-items-center">
                                <i
                                    class="ri-folder-2-line"
                                    :class="
                                        route().current('projects*') ||
                                        route().current('assignments*') ||
                                        route().current('defenses*')
                                            ? 'text-secondary'
                                            : ''
                                    "
                                ></i>
                            </span>
                            <span class="sidebar-text d-inline-block">Projects</span>
                        </span>
                        <span class="link-arrow">
                            <ArrowLink />
                        </span>
                    </span>
                    <div
                        class="multi-level collapse"
                        :class="
                            route().current('projects*') ||
                            route().current('assignments*') ||
                            route().current('defenses*')
                                ? 'show'
                                : ''
                        "
                        role="list"
                        id="submenu-projects"
                        aria-expanded="false"
                    >
                        <ul class="flex-column nav">
                            <li
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('projects.index') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('projects.index')">
                                    <span class="sidebar-text-contracted">AP</span>
                                    <span class="sidebar-text">All Projects</span>
                                </Link>
                            </li>
                            <li
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('projects.proposed') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('projects.proposed')">
                                    <span class="sidebar-text-contracted">PP</span>
                                    <span class="sidebar-text">Proposed</span>
                                </Link>
                            </li>
                            <li
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('projects.approved') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('projects.approved')">
                                    <span class="sidebar-text-contracted">AP</span>
                                    <span class="sidebar-text">Approved</span>
                                </Link>
                            </li>
                            <li
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('projects.declined') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('projects.declined')">
                                    <span class="sidebar-text-contracted">DP</span>
                                    <span class="sidebar-text">Declined</span>
                                </Link>
                            </li>
                            <li
                                v-if="usePermission('view_assignments')"
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('assignments*') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('assignments.index')">
                                    <span class="sidebar-text-contracted">AS</span>
                                    <span class="sidebar-text">Assignments</span>
                                </Link>
                            </li>
                            <li
                                v-if="usePermission('view_defenses')"
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('defenses*') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('defenses.index')">
                                    <span class="sidebar-text-contracted">DF</span>
                                    <span class="sidebar-text">Defenses</span>
                                </Link>
                            </li>
                        </ul>
                    </div>
                </li>

                <li
                    v-if="usePermission('view_project_requests')"
                    class="nav-item"
                    :class="route().current('project.requests*') ? 'active' : ''"
                >
                    <Link :href="route('project.requests.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-file-list-3-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Project Requests</span>
                    </Link>
                </li>

                <li
                    v-if="usePermission('view_students')"
                    class="nav-item"
                    :class="route().current('students*') ? 'active' : ''"
                >
                    <Link :href="route('students.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-user-3-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Students</span>
                    </Link>
                </li>

                <li
                    v-if="usePermission('view_supervisors')"
                    class="nav-item"
                    :class="route().current('supervisors*') ? 'active' : ''"
                >
                    <Link :href="route('supervisors.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-user-star-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Supervisors</span>
                    </Link>
                </li>

                <li
                    v-if="usePermission('access_support_chats')"
                    class="nav-item"
                    :class="route().current('chat*') ? 'active' : ''"
                >
                    <Link :href="route('chat.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-message-3-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Support Chats</span>
                    </Link>
                </li>

                <li v-if="usePermission('access_user_management')" class="nav-item">
                    <span
                        id="hasArrow"
                        class="nav-link d-flex justify-content-between align-items-center"
                        :class="route().current('users*') || route().current('roles*') ? '' : 'collapsed'"
                        data-bs-toggle="collapse"
                        data-bs-target="#submenu-user-management"
                    >
                        <span class="d-flex align-items-center">
                            <span class="sidebar-icon d-flex align-items-center">
                                <i
                                    class="ri-admin-line"
                                    :class="
                                        route().current('users*') || route().current('roles*') ? 'text-secondary' : ''
                                    "
                                ></i>
                            </span>
                            <span class="sidebar-text d-inline-block">Access Control</span>
                        </span>
                        <span class="link-arrow">
                            <ArrowLink />
                        </span>
                    </span>
                    <div
                        class="multi-level collapse"
                        :class="route().current('users*') || route().current('roles*') ? 'show' : ''"
                        role="list"
                        id="submenu-user-management"
                        aria-expanded="false"
                    >
                        <ul class="flex-column nav">
                            <li id="subMenuLink" class="nav-item" :class="route().current('users*') ? 'active' : ''">
                                <Link class="nav-link" :href="route('users.index')">
                                    <span class="sidebar-text-contracted">U</span>
                                    <span class="sidebar-text">Users</span>
                                </Link>
                            </li>
                            <li id="subMenuLink" class="nav-item" :class="route().current('roles*') ? 'active' : ''">
                                <Link class="nav-link" :href="route('roles.index')">
                                    <span class="sidebar-text-contracted">RP</span>
                                    <span class="sidebar-text">Manage Roles</span>
                                </Link>
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- <li
                    v-if="usePermission(['access_settings', 'access_currencies', 'access_payment_methods'])"
                    class="nav-item"
                >
                    <span
                        id="hasArrow"
                        class="nav-link d-flex justify-content-between align-items-center"
                        :class="
                            route().current('settings.edit') ||
                            route().current('currencies*') ||
                            route().current('payment-methods*')
                                ? ''
                                : 'collapsed'
                        "
                        data-bs-toggle="collapse"
                        data-bs-target="#submenu-settings"
                    >
                        <span class="d-flex align-items-center">
                            <span class="sidebar-icon d-flex align-items-center">
                                <i
                                    class="ri-settings-3-line"
                                    :class="
                                        route().current('settings.edit') ||
                                        route().current('currencies*') ||
                                        route().current('payment-methods*')
                                            ? 'text-secondary'
                                            : ''
                                    "
                                ></i>
                            </span>
                            <span class="sidebar-text d-inline-block">Settings</span>
                        </span>
                        <span class="link-arrow">
                            <ArrowLink />
                        </span>
                    </span>
                    <div
                        class="multi-level collapse"
                        :class="
                            route().current('settings.edit') ||
                            route().current('currencies*') ||
                            route().current('payment-methods*')
                                ? 'show'
                                : ''
                        "
                        role="list"
                        id="submenu-settings"
                        aria-expanded="false"
                    >
                        <ul class="flex-column nav">
                            <li
                                v-if="usePermission('access_settings')"
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('settings.edit') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('settings.edit')">
                                    <span class="sidebar-text-contracted">GS</span>
                                    <span class="sidebar-text">General</span>
                                </Link>
                            </li>
                            <li
                                v-if="usePermission('access_payment_methods')"
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('payment-methods*') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('payment-methods.index')">
                                    <span class="sidebar-text-contracted">PM</span>
                                    <span class="sidebar-text">Payment Methods</span>
                                </Link>
                            </li>
                            <li
                                v-if="usePermission('access_currencies')"
                                id="subMenuLink"
                                class="nav-item"
                                :class="route().current('currencies*') ? 'active' : ''"
                            >
                                <Link class="nav-link" :href="route('currencies.index')">
                                    <span class="sidebar-text-contracted">C</span>
                                    <span class="sidebar-text">Currencies</span>
                                </Link>
                            </li>
                        </ul>
                    </div>
                </li> -->

                <li
                    v-if="usePermission('access_activity_logs')"
                    class="nav-item"
                    :class="route().current('activity-logs.index') ? 'active' : ''"
                >
                    <Link :href="route('activity-logs.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-time-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Activity Logs</span>
                    </Link>
                </li>
                <!-- Supervisor's Menu -->
                <li
                    v-if="useRole('supervisor')"
                    class="nav-item"
                    :class="route().current('supervisor.projects*') ? 'active' : ''"
                >
                    <Link :href="route('supervisor.projects.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-lightbulb-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Propose Ideas</span>
                    </Link>
                </li>
                <li
                    v-if="useRole('supervisor')"
                    class="nav-item"
                    :class="route().current('supervisor.supervised-projects*') ? 'active' : ''"
                >
                    <Link
                        :href="route('supervisor.supervised-projects.index')"
                        class="nav-link d-flex align-items-center"
                    >
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-folder-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Supervised Projects</span>
                    </Link>
                </li>
                <li
                    v-if="useRole('supervisor')"
                    class="nav-item"
                    :class="route().current('supervisor.students*') ? 'active' : ''"
                >
                    <Link :href="route('supervisor.students.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-user-3-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Supervised Students</span>
                    </Link>
                </li>
                <li
                    v-if="useRole('supervisor')"
                    class="nav-item"
                    :class="route().current('supervisor.defenses*') ? 'active' : ''"
                >
                    <Link :href="route('supervisor.defenses.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-shield-check-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Defense Evaluations</span>
                    </Link>
                </li>
                <li v-if="useRole('supervisor')" class="nav-item" :class="route().current('chat*') ? 'active' : ''">
                    <Link :href="route('chat.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-message-3-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Project Chats</span>
                    </Link>
                </li>

                <!-- Student's Menu -->
                <li
                    v-if="useRole('student')"
                    class="nav-item"
                    :class="route().current('student.assigned-projects*') ? 'active' : ''"
                >
                    <Link :href="route('student.assigned-projects.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-folder-user-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">My Projects</span>
                    </Link>
                </li>

                <li
                    v-if="useRole('student')"
                    class="nav-item"
                    :class="route().current('student.available-projects*') ? 'active' : ''"
                >
                    <Link :href="route('student.available-projects.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-search-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Browse Projects</span>
                    </Link>
                </li>

                <li v-if="useRole('student')" class="nav-item" :class="route().current('chat*') ? 'active' : ''">
                    <Link :href="route('chat.index')" class="nav-link d-flex align-items-center">
                        <span class="sidebar-icon d-flex align-items-center">
                            <i class="ri-message-3-line"></i>
                        </span>
                        <span class="sidebar-text d-inline-block">Project Chats</span>
                    </Link>
                </li>

                <!-- Menu End -->
            </ul>
        </div>
    </nav>
    <!-- Sidebar Menu End -->
</template>
