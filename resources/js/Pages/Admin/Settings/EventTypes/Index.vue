<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default { layout: MainLayout };
</script>

<script setup>
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { useAlert } from '@/Composables/useAlert.js';
import { useHelpers } from '@/Composables/useHelpers.js';
import { Head, Link, router, useForm } from '@inertiajs/vue3';
import { Modal } from 'bootstrap';
import { debounce, pickBy } from 'lodash';
import { computed, onMounted, reactive, ref, watch } from 'vue';

const { currentRow } = useHelpers();

const props = defineProps({
    event_types: { type: Object },
    filters: { type: Object },
});

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
});

watch(
    params,
    debounce(() => {
        router.get(route('event-types.index'), pickBy(params), {
            preserveScroll: true,
            preserveState: true,
        });
    }, 300),
    { deep: true },
);

let clearSearch = () => {
    params.search = '';
};

// Modal control
const modalState = reactive({ modal: null, editing: false });
let eventType = ref(null);

onMounted(() => {
    modalState.modal = new Modal('#eventTypeModal', {});
});

const form = useForm({ name: '', short_name: '' });

const createModal = () => {
    modalState.editing = false;
    form.reset();
    modalState.modal.show();
};

const editModal = (id) => {
    modalState.editing = true;

    fetch(route('event-types.edit', id), { method: 'GET' })
        .then((r) => r.json())
        .then((data) => {
            eventType.value = data;
            Object.assign(form, data);
        });

    modalState.modal.show();
};

const store = () => {
    if (!modalState.editing) {
        form.post(route('event-types.store'), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();
                Toast.fire({ icon: 'success', title: 'Event Type Created!' });
                form.reset();
                modalState.modal.hide();
            },
        });
    } else {
        form.put(route('event-types.update', eventType.value), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();
                Toast.fire({ icon: 'info', title: 'Event Type Updated!' });
                form.reset();
                modalState.modal.hide();
            },
        });
    }
};

const deleteEventType = (et) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({ title: 'Are you sure?', text: "You won't be able to revert this!", icon: 'warning' }).then(
        (result) => {
            if (result.isConfirmed) {
                router.delete(route('event-types.destroy', et), {
                    preserveScroll: true,
                    onSuccess: () => {
                        Toast.fire({ icon: 'warning', title: 'Event Type Deleted!' });
                    },
                    onError: () => {
                        Toast.fire({ icon: 'danger', title: 'Something Went Wrong!' });
                    },
                });
            }
        },
    );
};

const modalTitle = computed(() => (modalState.editing ? 'Edit Event Type' : 'Create Event Type'));
</script>

<template>
    <Head title="Event Types" />

    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')"><i class="ri-home-3-fill text-secondary"></i></Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Event Types</li>
    </Breadcrumb>

    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <button @click="createModal" class="btn btn-primary">
                                Add Event Type <i class="ri-add-line"></i>
                            </button>
                        </div>
                        <div class="col-md-4">
                            <div class="navbar-search form-inline" id="navbar-search-main">
                                <div class="input-group input-group-merge search-bar">
                                    <input
                                        v-model="params.search"
                                        type="text"
                                        class="form-control"
                                        placeholder="Search ...."
                                    />
                                    <span v-if="!params.search" class="input-group-text"
                                        ><i class="ri-search-line text-secondary"></i
                                    ></span>
                                    <span v-else @click="clearSearch" class="input-group-text" style="cursor: pointer"
                                        ><i class="ri-close-line text-danger"></i
                                    ></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="table-responsive">
                        <table class="table table-centered table-nowrap mb-0 rounded">
                            <thead class="thead-light">
                                <tr>
                                    <th class="border-0 rounded-start text-center">No.</th>
                                    <th class="border-0 text-center">Name</th>
                                    <th class="border-0 text-center">Short Name</th>
                                    <th class="border-0 rounded-end text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(event_types.data.length > 0)">
                                    <td class="text-center text-danger" colspan="4">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(et, index) in event_types.data" :key="et.id">
                                    <td class="text-center">{{ currentRow(index, event_types) }}</td>
                                    <td class="text-center">{{ et.name }}</td>
                                    <td class="text-center">{{ et.short_name }}</td>
                                    <td class="text-center">
                                        <button @click.prevent="editModal(et.id)" class="btn btn-info btn-sm me-2">
                                            <i class="ri-pencil-fill"></i>
                                        </button>
                                        <a @click.prevent="deleteEventType(et)" href="" class="btn btn-danger btn-sm"
                                            ><i class="ri-delete-bin-2-fill"></i
                                        ></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4 row">
                        <div class="col-md-2 mb-3 mb-md-0">
                            <div class="d-flex align-items-center showing">
                                <div class="me-2 show-text">Showing</div>
                                <select
                                    v-model="params.per_page"
                                    class="show-select form-select px-3 py-1"
                                    id="perPage"
                                >
                                    <option value="10">10</option>
                                    <option value="30">30</option>
                                    <option value="50">50</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-6 offset-md-4 d-flex justify-content-md-end">
                            <nav>
                                <ul class="pagination pagination-sm">
                                    <template v-for="(link, index) in event_types.links">
                                        <li v-if="link.url === null" class="page-item">
                                            <button
                                                class="page-link text-muted"
                                                tabindex="-1"
                                                v-html="link.label"
                                                disabled
                                            ></button>
                                        </li>
                                        <li v-else class="page-item">
                                            <Link
                                                preserve-scroll
                                                class="page-link"
                                                :href="link.url"
                                                v-html="link.label"
                                                :class="{ active: link.active }"
                                            ></Link>
                                        </li>
                                    </template>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="eventTypeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{{ modalTitle }}</h5>
                </div>
                <form @submit.prevent="store">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Name <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.name"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.name }"
                                    />
                                    <span v-show="form.errors.name" class="text-danger">{{ form.errors.name }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Short Name</label>
                                    <input v-model="form.short_name" type="text" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
