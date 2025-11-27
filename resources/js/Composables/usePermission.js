import { usePage } from '@inertiajs/vue3';

export default function usePermission(permissions) {
    const userPermissions = usePage().props.auth.user.permissions || [];
    const perms = Array.isArray(permissions) ? permissions : [permissions];

    return perms.some((permission) => userPermissions.includes(permission));
}

export function usePermissionAll(permissions) {
    const userPermissions = usePage().props.auth.user.permissions || [];
    const perms = Array.isArray(permissions) ? permissions : [permissions];

    return perms.every((permission) => userPermissions.includes(permission));
}
