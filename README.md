This repo contains some R scripts for analyzing metagenome datasets.

**Table of Contens:**

1. Centered Log-Ratio ([<u>CLR</u>](./Scripts/CLR.R)) Transformation[^1]
2. Ordination analysis
    - Visualise beta-diversity: [<u>NMDS</u>](./Scripts/NMDS_analysis.R), [<u>PCA</u>](./Scripts/PCA_analysis.R), `PCoA`
    - Compute statistical significance of beta-diversity: `ANOSIM`, `Adonis`
    - Model the effect of environmental factors on microbiome: `RDA`

---

**Example file:**

An example file folder can be found in [<u>here</u>](./Example_files/).

---

**Reference**

[^1] Gloor, G. B., Macklaim, J. M., Pawlowsky-Glahn, V. & Egozcue, J. J. Microbiome Datasets Are Compositional: And This Is Not Optional. Front Microbiol 8, 2224 (2017).