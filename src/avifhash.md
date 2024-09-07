# AvifHash (Proof of Concept)
<img id="demo" alt="Food" width="301" height="193">

AvifHash: `QAAspRR38tTnCCis0P8vMwngzz5g` (28 bytes)

<script type="module">
  //import * as AvifHash from '/scripts/avifhash.js';

  const binaryToBase64 = binary => btoa(String.fromCharCode(...binary));
  const base64ToBinary = base64 => new Uint8Array(atob(base64).split('').map(x => x.charCodeAt(0)));
  const appendBuffer = function(buffer1, buffer2) {
      var tmp = new Uint8Array(buffer1.byteLength + buffer2.byteLength);
      tmp.set(new Uint8Array(buffer1), 0);
      tmp.set(new Uint8Array(buffer2), buffer1.byteLength);
      return tmp.buffer;
    };
  const avifHashImage = "QAAspRR38tTnCCis0P8vMwngzz5g"
  const avifHashHeader = "AAAAIGZ0eXBhdmlmAAAAAGF2aWZtaWYxbWlhZk1BMUEAAADybWV0YQAAAAAAAAAoaGRscgAAAAAAAAAAcGljdAAAAAAAAAAAAAAAAGxpYmF2aWYAAAAADnBpdG0AAAAAAAEAAAAeaWxvYwAAAABEAAABAAEAAAABAAABGgAAACcAAAAoaWluZgAAAAAAAQAAABppbmZlAgAAAAABAABhdjAxQ29sb3IAAAAAamlwcnAAAABLaXBjbwAAABRpc3BlAAAAAAAAAAgAAAAIAAAAEHBpeGkAAAAAAwgICAAAAAxhdjFDgSAAAAAAABNjb2xybmNseAABAA0ABoAAAAAXaXBtYQAAAAAAAAABAAEEAQKDBAAAAC9tZGF0EgAKCDgIv+UBDQaQMhkcgAAA";
  const originalUrl = "pics/eat.jpg"

  const fullImageBinary = appendBuffer(base64ToBinary(avifHashHeader), base64ToBinary(avifHashImage));
  const fullImageBase64 = binaryToBase64(new Uint8Array(fullImageBinary));
  const fullImageData64 = 'data:image/avif;base64,' + fullImageBase64;

  // Simulate setting the placeholder first, then the full image loading later on
  const demo = document.getElementById('demo');
  demo.src = fullImageData64;
  setTimeout(() => demo.src = originalUrl, 1000);
</script>