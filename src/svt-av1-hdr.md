# SVT-AV1-HDR

![SVT-AV1-HDR](pics/svt-av1-hdr.avif =300x150)

[SVT-AV1-HDR](https://github.com/juliobbv-p/svt-av1-hdr/) is the Scalable Video Technology for AV1 (SVT-AV1 Encoder) with perceptual enhancements for psychovisually optimal SDR and HDR AV1 encoding.

The goal is to create the best encoding implementation for perceptual quality with AV1, with additional optimizations for HDR encoding and content with film grain.

Currently, there are [HandBrake](https://github.com/Uranite/HandBrake-SVT-AV1-HDR/releases) and [ffmpeg](https://github.com/QuickFatHedgehog/FFmpeg-Builds-SVT-AV1-HDR/releases) **community builds** with SVT-AV1-HDR available for download.

## Features

SVT-AV1-HDR contains all of the features from SVT-AV1-PSY, plus a few more:

- **PQ-optimized Variance Boost curve**: A custom curve specifically designed for HDR video and images with a Perceptual Quantizer (PQ) transfer.
- **Tune 3 (Film Grain)**: An *opinionated* tune optimized for film grain retention and temporal consistency. The recommended CRF range to use tune 3 is 20 to 40.

## Comparison

The most dramatic improvement can be seen when encoding 4K HDR content with moderate to heavy film grain. Compare a tuned **SVT-AV1** encode against **SVT-AV1-HDR** using film grain tune. SVT-AV1-HDR is able to deliver a video with comparable quality at only **56.6% of the size** of SVT-AV1 (6 Mb/s vs 10.6 Mb/s)! It's worth mentioning that most of our testers preferred the SVT-AV1-HDR encode due to its overall better film grain retention.

<table>
  <tr>
    <th>SVT-AV1 (10.6 Mb/s)</th>
    <th>SVT-AV1-HDR (6 Mb/s)</th>
  </tr>
  <tr>
    <td>
      <video width="512" height="288" preload="metadata" controls>
      <source src="https://files.catbox.moe/auqhos.mp4#t=5" type="video/mp4">
      Your browser does not support the video tag.
      </video>
    </td>
    <td>
      <video width="512" height="288" preload="metadata" controls>
      <source src="https://files.catbox.moe/tapk23.mp4#t=5" type="video/mp4">
      Your browser does not support the video tag.
      </video>
    </td>
  </tr>
</table>



