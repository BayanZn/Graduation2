// Styles
import '../scss/style.scss';

// Third Party
import * as bootstrap from 'bootstrap';
import SimpleBar from 'simplebar';

window.onbeforeunload = function (e) {
    localStorage.removeItem('contracted');
};

// Options
const breakpoints = {
    sm: 540,
    md: 720,
    lg: 960,
    xl: 1140,
};

// Sidebar
const subMenuLinks = document.querySelectorAll('#subMenuLink');

subMenuLinks.forEach(function (subMenuLink) {
    let parentMultiLevel = subMenuLink.closest('.multi-level.collapse');
    let arrow = subMenuLink.parentNode.parentNode.parentElement.querySelector('#hasArrow');

    if (subMenuLink.classList.contains('active')) {
        let sidebarIcon = arrow.querySelector('.sidebar-icon');
        sidebarIcon.classList.add('text-secondary');

        parentMultiLevel.classList.add('show');

        if (arrow.classList.contains('collapsed')) {
            arrow.classList.remove('collapsed');
        }
    }
});

// Notification Icon
let iconNotifications = document.querySelector('.notification-bell');
if (iconNotifications) {
    iconNotifications.addEventListener('shown.bs.dropdown', function () {
        iconNotifications.classList.remove('unread');
    });
}

[].slice.call(document.querySelectorAll('[data-background]')).map(function (el) {
    el.style.background = 'url(' + el.getAttribute('data-background') + ')';
});

[].slice.call(document.querySelectorAll('[data-background-lg]')).map(function (el) {
    if (document.body.clientWidth > breakpoints.lg) {
        el.style.background = 'url(' + el.getAttribute('data-background-lg') + ')';
    }
});

[].slice.call(document.querySelectorAll('[data-background-color]')).map(function (el) {
    el.style.background = 'url(' + el.getAttribute('data-background-color') + ')';
});

[].slice.call(document.querySelectorAll('[data-color]')).map(function (el) {
    el.style.color = 'url(' + el.getAttribute('data-color') + ')';
});

// LoadOnClick
if (document.getElementById('loadOnClick')) {
    document.getElementById('loadOnClick').addEventListener('click', function () {
        let button = this;
        let loadContent = document.getElementById('extraContent');
        let allLoaded = document.getElementById('allLoadedText');

        button.classList.add('btn-loading');
        button.setAttribute('disabled', 'true');

        setTimeout(function () {
            loadContent.style.display = 'block';
            button.style.display = 'none';
            allLoaded.style.display = 'block';
        }, 1500);
    });
}
