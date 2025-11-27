import Swal from 'sweetalert2';

export function useAlert(timer = 2000) {
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: timer,
        timerProgressBar: true,
        showCloseButton: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
        },
    });

    const AlertWithButtons = Swal.mixin({
        customClass: {
            confirmButton: 'btn btn-primary ms-2',
            cancelButton: 'btn btn-danger',
        },
        buttonsStyling: false,
        showCancelButton: true,
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!',
        reverseButtons: true,
    });

    const Alert = Swal.mixin({
        customClass: {
            confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
        confirmButtonText: 'Thank You',
    });

    return { Toast, Alert, AlertWithButtons };
}
