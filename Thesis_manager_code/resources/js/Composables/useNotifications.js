import { router } from '@inertiajs/vue3';
import axios from 'axios';
import { onMounted, onUnmounted, ref } from 'vue';

export function useNotifications(pollingInterval = 30000) {
    const notifications = ref([]);
    const unreadCount = ref(0);
    const loading = ref(false);
    let intervalId = null;

    const fetchNotifications = async () => {
        try {
            loading.value = true;
            const response = await axios.get('/notifications');
            notifications.value = response.data.notifications;
            unreadCount.value = response.data.unread_count;
        } catch (error) {
            console.error('Failed to fetch notifications:', error);
        } finally {
            loading.value = false;
        }
    };

    const markAsRead = async (notificationId) => {
        try {
            await axios.post(`/notifications/${notificationId}/read`);
            // Update local state
            const notification = notifications.value.find((n) => n.id === notificationId);
            if (notification) {
                notifications.value = notifications.value.filter((n) => n.id !== notificationId);
                unreadCount.value = Math.max(0, unreadCount.value - 1);
            }
        } catch (error) {
            console.error('Failed to mark notification as read:', error);
        }
    };

    const markAllAsRead = async () => {
        try {
            await axios.post('/notifications/read-all');
            notifications.value = [];
            unreadCount.value = 0;
        } catch (error) {
            console.error('Failed to mark all notifications as read:', error);
        }
    };

    const deleteNotification = async (notificationId) => {
        try {
            await axios.delete(`/notifications/${notificationId}`);
            notifications.value = notifications.value.filter((n) => n.id !== notificationId);
            unreadCount.value = Math.max(0, unreadCount.value - 1);
        } catch (error) {
            console.error('Failed to delete notification:', error);
        }
    };

    const handleNotificationClick = (notification) => {
        markAsRead(notification.id);
        if (notification.url) {
            router.visit(notification.url);
        }
    };

    const startPolling = () => {
        // Fetch immediately
        fetchNotifications();

        // Then poll at interval
        intervalId = setInterval(() => {
            fetchNotifications();
        }, pollingInterval);
    };

    const stopPolling = () => {
        if (intervalId) {
            clearInterval(intervalId);
            intervalId = null;
        }
    };

    const setupRealtimeNotifications = (userId) => {
        if (window.Echo) {
            // Listen to user's private channel for notifications
            window.Echo.private(`App.Models.User.${userId}`)
                .notification((notification) => {
                    console.log('Real-time notification received:', notification);
                    
                    // Add the new notification to the list
                    const newNotification = {
                        id: notification.id,
                        type: notification.type || 'info',
                        title: notification.title || 'Notification',
                        message: notification.message || '',
                        url: notification.url || null,
                        icon: notification.icon || 'ri-notification-line',
                        icon_color: notification.icon_color || 'text-primary',
                        created_at: 'Just now',
                    };
                    
                    notifications.value.unshift(newNotification);
                    unreadCount.value += 1;
                    
                    // Show browser notification if supported and permission granted
                    if ('Notification' in window && Notification.permission === 'granted') {
                        new Notification(newNotification.title, {
                            body: newNotification.message,
                            icon: '/favicon.ico',
                        });
                    }
                });
        }
    };

    const requestNotificationPermission = async () => {
        if ('Notification' in window && Notification.permission === 'default') {
            await Notification.requestPermission();
        }
    };

    onMounted(() => {
        startPolling();
        requestNotificationPermission();
    });

    onUnmounted(() => {
        stopPolling();
    });

    return {
        notifications,
        unreadCount,
        loading,
        fetchNotifications,
        markAsRead,
        markAllAsRead,
        deleteNotification,
        handleNotificationClick,
        startPolling,
        stopPolling,
        setupRealtimeNotifications,
    };
}
