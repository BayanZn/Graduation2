<script setup>
import QRCode from 'qrcode'; // npm package 'qrcode'
import { ref, watch } from 'vue';

const props = defineProps({
    value: { type: String, required: true },
    size: { type: Number, default: 300 },
    alt: { type: String, default: 'QR Code' },
    filename: { type: String, default: 'qr.png' },
    showPreview: { type: Boolean, default: true },
    level: { type: String, default: 'H' },
    showPrint: { type: Boolean, default: false },
    showDownload: { type: Boolean, default: true },
});

const dataUrl = ref('');
const canvas = ref(null);

const generate = async () => {
    if (!props.value) {
        dataUrl.value = '';
        return;
    }

    try {
        // prefer a PNG data url for download/print
        dataUrl.value = await QRCode.toDataURL(props.value, {
            width: props.size,
            margin: 1,
            errorCorrectionLevel: props.level,
        });
    } catch (err) {
        // fallback to Google Chart API (network) if library fails
        const encoded = encodeURIComponent(props.value);
        dataUrl.value = `https://chart.googleapis.com/chart?cht=qr&chs=${props.size}x${props.size}&chl=${encoded}&choe=UTF-8`;
    }
};

watch(() => props.value, generate, { immediate: true });

const download = async () => {
    if (!dataUrl.value) return;

    // If the dataUrl is already an external URL (google chart) fetch and convert to blob for download
    if (dataUrl.value.startsWith('http')) {
        try {
            const resp = await fetch(dataUrl.value);
            const blob = await resp.blob();
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = props.filename || 'qr.png';
            document.body.appendChild(a);
            a.click();
            a.remove();
            URL.revokeObjectURL(url);
            return;
        } catch (err) {
            // fallback: open in new tab
            const a = document.createElement('a');
            a.href = dataUrl.value;
            a.target = '_blank';
            a.click();
            return;
        }
    }

    const a = document.createElement('a');
    a.href = dataUrl.value;
    a.download = props.filename || 'qr.png';
    document.body.appendChild(a);
    a.click();
    a.remove();
};

const print = async () => {
    if (!dataUrl.value) return;

    // Open a minimal new window containing the QR for printing. Some browsers block popups
    // so if window.open returns null we inform the user.
    const w = window.open('', '_blank');
    if (!w) {
        alert('Unable to open print window. Please allow popups for this site and try again.');
        return;
    }

    const printHtml = `
    <!doctype html>
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>Print QR</title>
        <style>
          body { margin:0; display:flex; align-items:center; justify-content:center; height:100vh; background:#fff; }
          img { max-width:100%; height:auto; }
        </style>
      </head>
      <body>
        <img src="${dataUrl.value}" alt="${props.alt}" />
                <script>
                    window.onload = function() {
                        setTimeout(function() {
                            try { window.focus(); } catch (e) {}
                            window.print();
                        }, 500);
                    };
                <\/script>
      </body>
    </html>
  `;

    w.document.open();
    w.document.write(printHtml);
    w.document.close();
};
</script>

<template>
    <div class="qr-print-component">
        <div class="d-flex align-items-center gap-3">
            <div v-if="showPreview" class="qr-card">
                <img :src="dataUrl" :alt="alt" :width="size" :height="size" class="d-block shadow-sm bg-white p-2" />
            </div>

            <div class="controls d-flex gap-2">
                <button
                    v-if="showDownload"
                    type="button"
                    class="btn btn-primary"
                    @click="download"
                    :disabled="!dataUrl"
                >
                    <i class="ri-download-line me-1"></i> Download QR
                </button>

                <button
                    v-if="showPrint"
                    type="button"
                    class="btn btn-outline-tertiary fw-bold"
                    @click="print"
                    :disabled="!dataUrl"
                >
                    <i class="ri-printer-line me-1"></i> Print QR
                </button>
            </div>
        </div>

        <!-- hidden canvas used for fallback / conversions -->
        <canvas ref="canvas" style="display: none"></canvas>
    </div>
</template>

<style scoped>
.qr-print-component img {
    border-radius: 4px;
}
</style>
