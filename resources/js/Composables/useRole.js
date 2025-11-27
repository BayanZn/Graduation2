import { usePage } from '@inertiajs/vue3';

export default function useRole(role) {
    const userRoles = usePage().props.auth.user.roles?.map((r) => r) || [];

    if (Array.isArray(role)) {
        return role.some((r) => userRoles.includes(r));
    }

    return userRoles.includes(role);
}
