# AvifHash (Proof of Concept)

Leveraging the strengths of the AVIF image format to create **compact** and **efficient** image placeholders. Compare to [BlurHash](https://blurha.sh/) and [ThumbHash](https://evanw.github.io/thumbhash/).

## Examples
<table markdown=1><tr><td>
<div class="demo-container" id="food" data-hash="ACylFHfy1OcIKKzQ/y8zCeDPPmA">
    <img id="demo-placeholder" alt="Food Placeholder" width="301" height="193">
    <img id="demo" alt="Food" width="301" height="193" data-src="pics/eat.jpg">
    <div class="blur" width="301" height="193">
</div>

`ACylFHfy1OcIKKzQ/y8zCeDPPmA` (27 bytes)
</td><td>
<div class="demo-container" id="girl" data-hash="AyqNyZshUpVBs5k7EYXt5+Bu0eA">
    <img id="demo-placeholder" alt="Girl Placeholder" width="301" height="193">
    <img id="demo" alt="Girl" width="301" height="193" data-src="pics/girl.jpg">
    <div class="blur" width="301" height="193">
</div>

`AyqNyZshUpVBs5k7EYXt5+Bu0eA` (27 bytes)
</td></tr><tr><td>
<div class="demo-container" id="plate" data-hash="A9jIV1NLTmQk3+AExLJKIA">
    <img id="demo-placeholder" alt="Plate Placeholder" width="301" height="193">
    <img id="demo" alt="Plate" width="301" height="193" data-src="pics/plate.jpg">
    <div class="blur" width="301" height="193">
</div>

`A9jIV1NLTmQk3+AExLJKIA` (22 bytes)
</td><td>
<div class="demo-container" id="coffee" data-hash="BZtmM6x1oJ7QrXCDnJui3edc/pI">
    <img id="demo-placeholder" alt="Coffee Placeholder" width="301" height="193">
    <img id="demo" alt="Coffee" width="301" height="193" data-src="pics/coffee.jpg">
    <div class="blur" width="301" height="193">
</div>

`BZtmM6x1oJ7QrXCDnJui3edc/pI` (27 bytes)
</td></tr></table>
<p>&nbsp</p>
## Details
Currently, this PoC relies on manually encoding 8x8 images to AVIF with `avifenc`, then opening them with a hex editor and cropping just the data that makes the actual image, deleting the ISOBMFF and OBU parts. This data is then converted with base64, alongside a 1-byte header that contains essential metadata information required to 're-hydrate' the image back to an AVIF for browser consumption.

So far, results have been very promising. AvifHash retains more detail than other implementations at a given size, and because it's based on AVIF, the door is open to support features like HDR, CICP colorimetry, and an alpha channel.
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
const avifHeader = "AAAAIGZ0eXBhdmlmAAAAAGF2aWZtaWYxbWlhZk1BMUEAAADybWV0YQAAAAAAAAAoaGRscgAAAAAAAAAAcGljdAAAAAAAAAAAAAAAAGxpYmF2aWYAAAAADnBpdG0AAAAAAAEAAAAeaWxvYwAAAABEAAABAAEAAAABAAABGgAAACcAAAAoaWluZgAAAAAAAQAAABppbmZlAgAAAAABAABhdjAxQ29sb3IAAAAAamlwcnAAAABLaXBjbwAAABRpc3BlAAAAAAAAAAgAAAAIAAAAEHBpeGkAAAAAAwgICAAAAAxhdjFDgSAAAAAAABNjb2xybmNseAABAA0ABoAAAAAXaXBtYQAAAAAAAAABAAEEAQKDBAAAAC9tZGF0EgAKCDgIv+UBDQaQMhkcgAAAQAA=";

for (const demoContainer of demoContainers) {
    const avifHashImage = demoContainer.dataset.hash;
    const demoPlaceholder = demoContainer.querySelector('#demo-placeholder');
    const demo = demoContainer.querySelector('#demo');
    const blur = demoContainer.querySelector('.blur');
    const originalUrl = demo.dataset.src;

    const avifHeaderBinary = base64ToBinary(avifHeader);
    const hashImageBinary = base64ToBinary(avifHashImage);
    const avifHashHeader = hashImageBinary[0];

    // Adjust AVIF and OBU size fields
    avifHeaderBinary[127] = hashImageBinary.length + 19;
    avifHeaderBinary[277] = hashImageBinary.length + 27;
    avifHeaderBinary[295] = hashImageBinary.length + 5;

    console.log(hashImageBinary);
    console.log(avifHeaderBinary[295]);

    // Set qindex (lowest bit)
    const reducedQIndex = avifHashHeader & 3;

    switch (reducedQIndex) {
        case 0: avifHeaderBinary[296] = 28; break; // qindex 200
        case 1: avifHeaderBinary[296] = 27; break; // qindex 184   
        case 2: avifHeaderBinary[296] = 26; break; // qindex 168
        case 3: avifHeaderBinary[296] = 25; break; // qindex 152
    }

    // tx_mode_select
    if ((avifHashHeader & 4) !== 0) {
        avifHeaderBinary[301] = 64; // TX_MODE_SELECT
    } else {
        avifHeaderBinary[301] = 0; // TX_MODE_LARGEST
    }

    const fullImageBinary = appendBuffer(avifHeaderBinary, hashImageBinary.slice(1, hashImageBinary.length));
    const fullImageBase64 = binaryToBase64(new Uint8Array(fullImageBinary));
    const fullImageData64 = 'data:image/avif;base64,' + fullImageBase64;

    console.log(fullImageBinary);
    console.log(fullImageBase64);

    // Set the placeholder image
    demoPlaceholder.src = fullImageData64;

    // Load the full image
    // ToDo: find a cleaner way to transition from blurred demo placeholder to demo
    setTimeout(() => demo.src = originalUrl, 1000);
    demo.onload = function() {
        blur.style.opacity = '0';
        setTimeout(() => demoPlaceholder.style.opacity = '0', 1000);
        demo.style.opacity = '1';
    }
}
</script>