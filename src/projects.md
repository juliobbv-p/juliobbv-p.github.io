# libaom

![libaom](pics/libaom.avif#dropshadowable =300x150)

[libaom](https://aomedia.googlesource.com/aom/) is an AV1 software video encoder and decoder that functions both as the reference implementation. libaom is used in production to encode [AVIF images](https://en.wikipedia.org/wiki/AVIF).

I ported the "still image" tune from SVT-AV1-PSY to libaom, resulting in improved visual quality and better scores on modern image quality metrics, including SSIMULACRA 2, DSSIM, FLIP, and Butteraugli. Users can generally expect a **10-20% reduction in file size for photographs**. You can find the commit history and details of my changes [here](https://aomedia-review.googlesource.com/q/owner:juliobbv@gmail.com).

# SVT-AV1-PSY

![SVT-AV1-PSY](pics/svt-av1-psy.avif =300x150)

[SVT-AV1-PSY](https://svt-av1-psy.com) is an AV1 software video encoder born from the SVT-AV1 project. Our encoder is designed for optimal perceptual fidelity; we have optimized heavily around pleasing the human visual system, and we aim to provide the best perceptual fidelity available in any AV1 video encoder across a wide quality spectrum.

As one of the main contributors of this project, I added features that improve quality of life, and encode quality and consistency. Most notably, I co-developed a new "still image" tune with [Gianni Rosato](https://giannirosato.com) that improves visual quality for AVIF images, as well as removing important resolution limitations. Visual comparisons can be found [here](https://svt-av1-psy.com/avif/comparisons/index.html).

# SVT-AV1

![AV1 logo](pics/av1.avif#dropshadowable =300x166)

[SVT-AV1](https://gitlab.com/AOMediaCodec/SVT-AV1) is an open-source software AV1 encoder that is architected to yield excellent quality-speed-latency tradeoffs on CPU platforms for a wide range of video coding applications.

I worked on upstreaming my Variance Boost feature to mainline SVT-AV1, including [research and design](https://gitlab.com/AOMediaCodec/SVT-AV1/-/issues/2105), [implementation](https://gitlab.com/AOMediaCodec/SVT-AV1/-/merge_requests/2195), writing [documentation](https://gitlab.com/AOMediaCodec/SVT-AV1/-/blob/master/Docs/Appendix-Variance-Boost.md), and [bug-fixing](https://gitlab.com/AOMediaCodec/SVT-AV1/-/merge_requests/2215).

One of my goals is to incrementally incorporate SVT-AV1-PSY features back into the SVT-AV1 project, so more people can enjoy the benefits of our improvements.

# Azure DevOps

![Azure DevOps](pics/azure-devops.avif =300x198)

At [Azure DevOps](https://azure.microsoft.com/en-us/products/devops), I worked with various teams and products. The most notable features I contributed were:
- A new Code Review Service, written from the ground up in ASP.NET and T-SQL, by leveraging the in-house framework to ensure scalability and reliability. This to enable our "Version 2" of the [Pull Request experience](https://azure.microsoft.com/en-us/products/devops/repos), which supports features like code updates, comment tracking, and rich [REST API integration](https://learn.microsoft.com/en-us/rest/api/azure/devops/git/pull-requests?view=azure-devops-rest-7.1).
- Automated test tooling for the initial [Git Server implementation](https://learn.microsoft.com/en-us/azure/devops/repos/git/gitworkflow?view=azure-devops), which include a command-line tool that massively uploaded popular open-source repositories of various sizes and complexities.
- Real-time monitoring and alerting of critical services, by using [Azure Data Explorer](https://dataexplorer.azure.com/) to gather telemetry, and an internal monitoring service that triggered alerts on any detected anomalies.

# GitHub

![GitHub](pics/github.avif =300x188)

At [GitHub](https://github.com), I worked for the GitHub Actions team on these things (among others):
- Helped refactor [Azure Pipelines Agent](https://github.com/microsoft/azure-pipelines-agent) codebase into the initial version of the [Actions Runner](https://github.com/actions/runner), which included renaming and cleaning up legacy components.
- Assessed the best Azure database solution for an upcoming "private cloud" product (never saw the light 🙁)
- Leveraged my knowledge from Azure DevOps to develop essential "Live Site Incident" infrastructure. I'm proud of a query that detected anomalies in stored procedure performance (total execution time and number of rows read/written) that managed to capture bad regressions just minutes after deploying database updates.