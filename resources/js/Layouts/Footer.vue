<script setup>
let year = new Date().getFullYear();
</script>

<template>
    <!-- Footer Start -->
    <footer class="py-2 border-top border-gray-300 px-3">
        <div class="row">
            <div class="col-12 d-md-flex justify-content-between">
                <div>
                    <p class="mb-0" style="font-size: 14px">
                        <span>{{ year }}</span> © Developed by
                        <a href="" target="_blank" class="fw-bold">Bayan</a>
                    </p>
                </div>
                <div>
                    <p class="mb-0" style="font-size: 14px">
                        version: <span class="text-tertiary fw-bold" v-html="$page.props.app_version"></span>
                    </p>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer End -->
</template>
