<script setup>
import {onMounted} from "vue";

// Go back to previous page
onMounted(() => {
    const goBack = document.querySelector('.go-back');
    goBack.addEventListener('click', () => {
        window.history.back();
    })
})
</script>

<template>
    <div class="d-flex align-items-center mb-4 justify-content-between">
        <nav aria-label="breadcrumb" class="d-inline-block">
            <ol class="breadcrumb bg-white shadow breadcrumb-dark mb-0">
                <slot></slot>
            </ol>
        </nav>
        <button class="go-back btn btn-secondary fw-bold d-flex align-items-center">
            <i class="ri-arrow-go-back-fill"></i>
            <span class="ms-2">Go Back</span>
        </button>
    </div>
</template>
