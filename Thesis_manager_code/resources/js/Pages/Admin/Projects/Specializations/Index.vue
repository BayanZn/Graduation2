<script>
import MainLayout from '@/Layouts/MainLayout.vue';
export default {
    layout: MainLayout,
};
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
    specializations: {
        type: Object,
    },
    departments: {
        type: Array,
    },
    filters: {
        type: Object,
    },
});

let specialization = ref(null);

// Query parameters
let params = reactive({
    search: props.filters.search ?? '',
    per_page: props.filters.per_page ?? 10,
});

// Watch params object for changes and filter the table
watch(
    params,
    debounce(() => {
        router.get(route('specializations.index'), pickBy(params), {
            preserveScroll: true,
            preserveState: true,
        });
    }, 300),
    { deep: true },
);

// Clear table search
let clearSearch = () => {
    params.search = '';
};

// Export functionality
const exportSpecializations = () => {
    const queryParams = new URLSearchParams(pickBy(params));
    window.location.href = route('specializations.export') + '?' + queryParams.toString();
};

// Import functionality
const importModal = ref(null);
const importForm = useForm({
    file: null,
});

onMounted(() => {
    modalState.modal = new Modal('#specializationModal', {});
});

const openImportModal = () => {
    const modal = new Modal(importModal.value);
    modal.show();
};

const handleFileChange = (event) => {
    importForm.file = event.target.files[0];
};

const submitImport = () => {
    importForm.post(route('specializations.import'), {
        preserveScroll: true,
        onSuccess: () => {
            const modal = Modal.getInstance(importModal.value);
            modal.hide();
            importForm.reset();

            let { Toast } = useAlert();
            Toast.fire({
                icon: 'success',
                title: 'Specializations imported successfully!',
            });
        },
        onError: () => {
            let { Toast } = useAlert();
            Toast.fire({
                icon: 'error',
                title: 'Import failed!',
            });
        },
    });
};

// Modal control
const modalState = reactive({
    modal: null,
    editing: false,
});

onMounted(() => {
    modalState.modal = new Modal('#specializationModal', {});
});

const form = useForm({
    department_id: '',
    short_name: '',
    name: '',
    chapters: [
        'Introduction',
        'Literature Review',
        'Methodology',
        'Result & Analysis',
        'Conclusion',
        'Abstract',
        'Full Draft',
    ],
    chapter_template: null,
});

const templateFile = ref(null);

// Show modal in create mode
const createModal = () => {
    modalState.editing = false;
    form.reset();
    form.chapters = [
        'Introduction',
        'Literature Review',
        'Methodology',
        'Result & Analysis',
        'Conclusion',
        'Abstract',
        'Full Draft',
    ];
    modalState.modal.show();
};

// Get the specialization for editing in the modal
const editModal = (id) => {
    modalState.editing = true;

    fetch(route('specializations.edit', id), {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then((response) => response.json())
        .then((data) => {
            specialization.value = data;
            form.department_id = data.department_id;
            form.short_name = data.short_name;
            form.name = data.name;
            form.chapters = data.chapters && data.chapters.length > 0 
                ? data.chapters 
                : [
                    'Introduction',
                    'Literature Review',
                    'Methodology',
                    'Result & Analysis',
                    'Conclusion',
                    'Abstract',
                    'Full Draft',
                ];
            form.chapter_template = null;
        });

    modalState.modal.show();
};

// Store specialization
const store = () => {
    if (!modalState.editing) {
        form.post(route('specializations.store'), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'success',
                    title: 'Specialization Created!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    } else {
        form.put(route('specializations.update', specialization.value), {
            preserveScroll: true,
            onSuccess: () => {
                let { Toast } = useAlert();

                Toast.fire({
                    icon: 'info',
                    title: 'Specialization Updated!',
                });

                form.reset();
                modalState.modal.hide();
            },
        });
    }
};

// Delete specialization
const deleteSpecialization = (specialization) => {
    let { Toast, AlertWithButtons } = useAlert();

    AlertWithButtons.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route('specializations.destroy', specialization), {
                preserveScroll: true,
                onSuccess: () => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Specialization Deleted!',
                    });
                },
                onError: () => {
                    Toast.fire({
                        icon: 'danger',
                        title: 'Something Went Wrong!',
                    });
                },
            });
        }
    });
};

const handleTemplateChange = (event) => {
    form.chapter_template = event.target.files[0];
};

const addChapter = () => {
    form.chapters.push('');
};

const removeChapter = (index) => {
    if (form.chapters.length > 1) {
        form.chapters.splice(index, 1);
    }
};

// Modal Title
const modalTitle = computed(() => (modalState.editing ? 'Edit Specialization' : 'Create Specialization'));
</script>

<template>
    <Head title="Specializations" />

    <!-- Breadcrumb Start -->
    <Breadcrumb>
        <li class="breadcrumb-item fw-bold">
            <Link :href="route('dashboard')">
                <i class="ri-home-3-fill text-secondary"></i>
            </Link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Specializations</li>
    </Breadcrumb>
    <!-- Breadcrumb End -->

    <!-- Page Content Start -->
    <div class="row">
        <div class="col-12 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <button @click="createModal" class="btn btn-primary">
                                Add Specialization <i class="ri-add-line"></i>
                            </button>
                            <button @click="exportSpecializations" class="btn btn-success ms-2">
                                <i class="ri-file-excel-line"></i> Export
                            </button>
                            <button @click="openImportModal" class="btn btn-info ms-2">
                                <i class="ri-upload-line"></i> Import
                            </button>
                        </div>

                        <div class="col-md-4">
                            <div class="navbar-search form-inline" id="navbar-search-main">
                                <div class="input-group input-group-merge search-bar">
                                    <input
                                        v-model="params.search"
                                        type="text"
                                        class="form-control"
                                        id="searchTable"
                                        placeholder="Search ...."
                                        aria-label="searchTable"
                                        aria-describedby="searchTable"
                                    />
                                    <span v-if="!params.search" class="input-group-text" id="searchTable">
                                        <i class="ri-search-line text-secondary"></i>
                                    </span>
                                    <span
                                        @click="clearSearch"
                                        v-else
                                        class="input-group-text"
                                        style="cursor: pointer"
                                        id="removeParameter"
                                    >
                                        <i class="ri-close-line text-danger"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="table-responsive">
                        <table class="table table-centered table-nowrap mb-0 rounded">
                            <thead class="thead-light">
                                <tr>
                                    <th class="border-0 rounded-start text-center align-middle">No.</th>
                                    <th class="border-0 text-center align-middle">Department</th>
                                    <th class="border-0 text-center align-middle">Short Name</th>
                                    <th class="border-0 text-center align-middle">Name</th>
                                    <th class="border-0 rounded-end text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="!(specializations.data.length > 0)">
                                    <td class="text-center align-middle text-danger" colspan="5">
                                        There is no data available to show
                                    </td>
                                </tr>
                                <tr v-for="(specialization, index) in specializations.data" :key="specialization.id">
                                    <td class="text-center align-middle">{{ currentRow(index, specializations) }}</td>
                                    <td class="text-center align-middle">{{ specialization.department?.name }}</td>
                                    <td class="text-center align-middle">{{ specialization.short_name }}</td>
                                    <td class="text-center align-middle">{{ specialization.name }}</td>
                                    <td class="text-center align-middle">
                                        <button
                                            @click.prevent="editModal(specialization.id)"
                                            class="btn btn-info btn-sm me-2"
                                        >
                                            <i class="ri-pencil-fill"></i>
                                        </button>
                                        <a
                                            @click.prevent="deleteSpecialization(specialization)"
                                            href=""
                                            id="delete"
                                            class="btn btn-danger btn-sm"
                                        >
                                            <i class="ri-delete-bin-2-fill"></i>
                                        </a>
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
                                    <template v-for="(link, index) in specializations.links">
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
    <div
        ref="modalState.modalElement"
        class="modal fade"
        id="specializationModal"
        tabindex="-1"
        aria-labelledby="specializationModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="specializationModalLabel">{{ modalTitle }}</h5>
                </div>
                <form @submit.prevent="store">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>Department <span class="text-danger">*</span></label>
                                    <v-select
                                        v-model="form.department_id"
                                        :options="departments"
                                        :reduce="(department) => department.id"
                                        label="name"
                                        placeholder="Select Department"
                                        :class="{ 'border-2 border-danger': form.errors.department_id }"
                                    ></v-select>
                                    <span v-show="form.errors.department_id" class="text-danger">{{
                                        form.errors.department_id
                                    }}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label>Short Name <span class="text-danger">*</span></label>
                                    <input
                                        v-model="form.short_name"
                                        type="text"
                                        class="form-control"
                                        :class="{ 'border-2 border-danger': form.errors.short_name }"
                                        maxlength="20"
                                    />
                                    <span v-show="form.errors.short_name" class="text-danger">{{
                                        form.errors.short_name
                                    }}</span>
                                </div>
                            </div>
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

                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label class="mb-2">
                                        Chapter Options 
                                        <small class="text-muted">(Customize chapters for this specialization)</small>
                                    </label>
                                    
                                    <div v-for="(chapter, index) in form.chapters" :key="index" class="mb-2">
                                        <div class="input-group">
                                            <span class="input-group-text">{{ index + 1 }}</span>
                                            <input
                                                v-model="form.chapters[index]"
                                                type="text"
                                                class="form-control"
                                                placeholder="Enter chapter name"
                                                :class="{ 'border-2 border-danger': form.errors[`chapters.${index}`] }"
                                            />
                                            <button
                                                v-if="form.chapters.length > 1"
                                                @click="removeChapter(index)"
                                                type="button"
                                                class="btn btn-outline-danger"
                                            >
                                                <i class="ri-delete-bin-line"></i>
                                            </button>
                                        </div>
                                        <span v-if="form.errors[`chapters.${index}`]" class="text-danger small">
                                            {{ form.errors[`chapters.${index}`] }}
                                        </span>
                                    </div>
                                    
                                    <button
                                        @click="addChapter"
                                        type="button"
                                        class="btn btn-sm btn-outline-primary mt-2"
                                    >
                                        <i class="ri-add-line"></i> Add Chapter
                                    </button>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-4">
                                    <label>
                                        Chapter Template 
                                        <small class="text-muted">(Optional: Upload template file for students)</small>
                                    </label>
                                    <input
                                        ref="templateFile"
                                        type="file"
                                        class="form-control"
                                        accept=".pdf,.doc,.docx"
                                        @change="handleTemplateChange"
                                        :class="{ 'border-2 border-danger': form.errors.chapter_template }"
                                    />
                                    <small class="text-muted">Accepted formats: PDF, DOC, DOCX (Max 10MB)</small>
                                    <br />
                                    <span v-if="form.errors.chapter_template" class="text-danger">
                                        {{ form.errors.chapter_template }}
                                    </span>
                                    <div v-if="modalState.editing && specialization?.chapter_template_path" class="mt-2">
                                        <a
                                            :href="`/storage/${specialization.chapter_template_path}`"
                                            target="_blank"
                                            class="btn btn-sm btn-outline-info"
                                        >
                                            <i class="ri-file-download-line"></i> Download Current Template
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        <button :disabled="form.processing" type="submit" class="btn btn-primary">
                            <span v-if="!modalState.editing">Create Specialization</span>
                            <span v-else>Update Specialization</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Import Modal -->
    <div
        ref="importModal"
        class="modal fade"
        id="importSpecializationModal"
        tabindex="-1"
        aria-labelledby="importSpecializationModalLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="importSpecializationModalLabel">Import Specializations</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form @submit.prevent="submitImport">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="importFile" class="form-label">
                                Select Excel File <span class="text-danger">*</span>
                            </label>
                            <input
                                type="file"
                                class="form-control"
                                id="importFile"
                                accept=".xlsx,.xls,.csv"
                                @change="handleFileChange"
                                :class="{
                                    'border-2 border-danger': importForm.errors.file,
                                }"
                                required
                            />
                            <span v-if="importForm.errors.file" class="text-danger">
                                {{ importForm.errors.file }}
                            </span>
                            <small class="form-text text-muted"> Accepted formats: .xlsx, .xls, .csv </small>
                        </div>
                        <div class="alert alert-info">
                            <strong>Expected columns:</strong> department_id, short_name, name
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" :disabled="importForm.processing">
                            <span v-if="importForm.processing"> <i class="ri-loader-4-line"></i> Importing... </span>
                            <span v-else> <i class="ri-upload-line"></i> Import </span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
