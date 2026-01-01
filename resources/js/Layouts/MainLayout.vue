<script setup>
import Header from "@/Layouts/Header.vue";
import Sidebar from "@/Layouts/Sidebar.vue";
import Footer from "@/Layouts/Footer.vue";
import {Link, Head} from "@inertiajs/vue3";
</script>

<template>
    <Head>
        <link rel="icon" type="image/png" sizes="32x32" :href="$page.props.settings?.favicon">
    </Head>

    <div style="background-color: #ebedef" class="position-fixed bg-pattern-1 w-100 fmxh-300 z--1"></div>

    <Sidebar/>

    <!-- Main Content Start -->
    <main class="content d-flex flex-column justify-content-between min-vh-100">
        <div class="upper-section">
            <Header/>

            <div class="px-3">
                <slot/>
            </div>
        </div>

        <div class="lower-section">
            <Footer/>
        </div>
    </main>
    <!-- Main Content End -->
</template>

<style>

</style>
