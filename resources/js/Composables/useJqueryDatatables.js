import { usePage } from "@inertiajs/vue3";
import moment from "moment";

export function useJqueryDatatables(title, columns) {
    const options = {
        ordering: false,
        dom: "<'row'<'col-md-3'l><'col-md-5 d-flex align-items-center'B><'col-md-4 justify-content-end'f>>tr<'row'<'col-md-5'i><'col-md-7 mt-2'p>>",
        buttons: [
            {
                extend: 'excel',
                text: '<i class="bi bi-file-earmark-excel"></i> Excel',
                className: 'btn-tertiary',
                exportOptions: {
                    columns: columns,
                    footer: true,
                },
            },
            {
                extend: 'csv',
                text: '<i class="bi bi-file-earmark-excel"></i> CSV',
                className: 'btn-tertiary',
                exportOptions: {
                    columns: columns,
                    footer: true,
                },
            },
            {
                extend: 'pdf',
                text: '<i class="bi bi-file-pdf"></i> PDF',
                className: 'btn-tertiary',
                exportOptions: {
                    columns: columns,
                    footer: true,
                },
                customize: function (doc) {
                    doc.pageMargins = [10, 10, 10, 10];
                    doc.pageSize = 'A4';
                    doc.styles.tableHeader.fontSize = 10;
                    doc.styles.tableHeader.alignment = 'left';
                    doc.styles.tableFooter.fontSize = 10;
                    doc.defaultStyle.alignment = 'left';
                    doc.footer = {
                        columns: [
                            {
                                alignment: 'center',
                                text: [
                                    { text: 'Generated on:: ' + moment().format('MMM DD, YYYY hh:mm A') },
                                ]
                            },
                        ]
                    }
                    doc.content[1].table.widths = Array(doc.content[1].table.body[0].length + 1).join('*').split('');
                }
            },
            {
                extend: 'print',
                text: '<i class="bi bi-printer"></i> Print',
                className: 'btn-tertiary',
                title: title,
                exportOptions: {
                    columns: columns,
                    footer: true,
                },
                customize: function (win) {
                    const h1Element = win.document.querySelector('h1');
                    if (h1Element) {
                        h1Element.style.fontSize = '18px';
                        h1Element.style.textAlign = 'center';
                        h1Element.style.marginBottom = '20px';
                    }
                    const tableElement = win.document.querySelector('table');
                    if (tableElement) {
                        tableElement.style.width = '100%';
                        tableElement.style.borderCollapse = 'collapse';
                    }

                    win.document.body.style.margin = '10px 10px';
                    const customContent = document.createElement('div');
                    customContent.innerHTML = `
                    <div class="d-flex flex-column align-items-center justify-content-center mb-4">
                        <h4 class="ms-3 mb-0">${usePage().props.settings.company_name}</h4>
                        <div>
                            <small>${usePage().props.settings.company_email}</small>,
                            <small>${usePage().props.settings.company_mobile}</small>
                        </div>
                        <div>
                            <small>${usePage().props.settings.company_address}</small>
                        </div>
                    </div>
                `;
                    win.document.body.prepend(customContent);
                },
            },
        ],
    };

    return { options }
}
