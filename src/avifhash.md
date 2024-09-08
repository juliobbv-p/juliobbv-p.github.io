# AvifHash (Proof of Concept)

Leveraging the strengths of the AVIF image format to create **compact** and **efficient** image placeholders. Compare to [BlurHash](https://blurha.sh/) and [ThumbHash](https://evanw.github.io/thumbhash/).

## Examples

<div class="demo-container" id="food" data-hash="QAAspRR38tTnCCis0P8vMwngzz5g">
    <img id="demo-placeholder" alt="Food Placeholder" width="301" height="193">
    <img id="demo" alt="Food" width="301" height="193" data-src="pics/eat.jpg">
</div>

AvifHash: `QAAspRR38tTnCCis0P8vMwngzz5g` (28 bytes)

<div class="demo-container" id="girl" data-hash="QAAqjcmbIVKVQbOZOxGF7efgbtHg">
    <img id="demo-placeholder" alt="Girl Placeholder" width="301" height="193">
    <img id="demo" alt="Girl" width="301" height="193" data-src="pics/girl.jpg">
</div>

AvifHash: `QAAqjcmbIVKVQbOZOxGF7efgbtHg` (28 bytes)

<script type="module">
// ToDo: encapsulate logic into library for MVP
//import * as AvifHash from '/scripts/avifhash.js';

const binaryToBase64 = binary => btoa(String.fromCharCode(...binary));
const base64ToBinary = base64 => new Uint8Array(atob(base64).split('').map(x => x.charCodeAt(0)));
const appendBuffer = function(buffer1, buffer2) {
    var tmp = new Uint8Array(buffer1.byteLength + buffer2.byteLength);
    tmp.set(new Uint8Array(buffer1), 0);
    tmp.set(new Uint8Array(buffer2), buffer1.byteLength);
    return tmp.buffer;
};

const demoContainers = document.getElementsByClassName("demo-container");
const avifHashHeader = "AAAAIGZ0eXBhdmlmAAAAAGF2aWZtaWYxbWlhZk1BMUEAAADybWV0YQAAAAAAAAAoaGRscgAAAAAAAAAAcGljdAAAAAAAAAAAAAAAAGxpYmF2aWYAAAAADnBpdG0AAAAAAAEAAAAeaWxvYwAAAABEAAABAAEAAAABAAABGgAAACcAAAAoaWluZgAAAAAAAQAAABppbmZlAgAAAAABAABhdjAxQ29sb3IAAAAAamlwcnAAAABLaXBjbwAAABRpc3BlAAAAAAAAAAgAAAAIAAAAEHBpeGkAAAAAAwgICAAAAAxhdjFDgSAAAAAAABNjb2xybmNseAABAA0ABoAAAAAXaXBtYQAAAAAAAAABAAEEAQKDBAAAAC9tZGF0EgAKCDgIv+UBDQaQMhkcgAAA";

for (const demoContainer of demoContainers) {
    const avifHashImage = demoContainer.dataset.hash;
    const demoPlaceholder = demoContainer.querySelector('#demo-placeholder');
    const demo = demoContainer.querySelector('#demo');
    const originalUrl = demo.dataset.src;

    const hashHeaderBinary = base64ToBinary(avifHashHeader);

    // ToDo: store pic qindex in hash
    if (originalUrl.includes("girl")) {
        hashHeaderBinary[296] = 25;
    } else {
        hashHeaderBinary[296] = 28;  
    }

    const hashImageBinary = base64ToBinary(avifHashImage);
    const fullImageBinary = appendBuffer(hashHeaderBinary, hashImageBinary);

    const fullImageBase64 = binaryToBase64(new Uint8Array(fullImageBinary));
    const fullImageData64 = 'data:image/avif;base64,' + fullImageBase64;

    // Set the placeholder image
    demoPlaceholder.src = fullImageData64;

    // Load the full image
    setTimeout(() => demo.src = originalUrl, 1000);
    demo.onload = function() {
        demo.style.opacity = '1';
        demoPlaceholder.style.opacity = '0';
    }
}
</script>