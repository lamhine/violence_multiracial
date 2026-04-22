# Violent victimization of older Multiracial adults in California, 2005-2022

Manuscript targeting JAGS Research Letter, Ethnogeriatrics and Special Populations section.

## Structure

```
violence_jags/
├── manuscript.qmd              # Main Quarto document
├── references.bib              # BibTeX file (managed by Better BibTeX)
├── american-medical-association.csl  # Citation style (download separately)
├── jags-reference.docx         # Word template for styling (optional)
├── 01_data/                    # Data (not in repo, paths in config.R)
├── 02_code/                    # Analysis scripts
└── 03_results/                 # Saved figure and table objects
```

## Word count target

JAGS Research Letter: 750 words, 10 references, 2 tables/figures, no abstract.
Text sections: Introduction, Methods, Results, Discussion.

## Bibliography setup (first time)

This manuscript uses Better BibTeX with Zotero to manage citations. One-time setup:

1. Install Zotero if you haven't already: https://www.zotero.org/download/
2. Install the Better BibTeX extension: https://retorque.re/zotero-better-bibtex/installation/
3. In Zotero, create a collection for this paper (e.g., "Violence Multiracial JAGS")
4. Add references to that collection by dragging PDFs in or using the browser connector
5. Right-click the collection → Export Collection
   - Format: Better BibTeX
   - Check "Keep updated"
   - Save as `references.bib` in this project folder, overwriting the placeholder
6. Now every time you add a new reference to the Zotero collection, the .bib file updates automatically

## Citing in Quarto

Each Zotero item has a citation key (shown in the Better BibTeX pane in Zotero, or visible in the .bib file after export). Cite in the .qmd file like this:

- Single citation: `[@smith2020]`
- Multiple: `[@smith2020; @jones2021]`
- Narrative: `@smith2020 reported...`

The references will be formatted in AMA style using the CSL file and rendered into the References section at the bottom.

## CSL file

Download the AMA citation style:
https://www.zotero.org/styles?q=american%20medical%20association

Save as `american-medical-association.csl` in the project root.

## JAGS reference .docx (optional)

For styling consistency with JAGS conventions, you can create a reference .docx:

1. Render once without `reference-doc` specified
2. Open the resulting .docx in Word
3. Modify styles (fonts, margins, heading styles) to match JAGS formatting
4. Save as `jags-reference.docx` in the project root
5. The YAML already points to this file

If you skip this step, remove the `reference-doc: jags-reference.docx` line from the YAML.

## Rendering

In RStudio: open `manuscript.qmd` and click Render, or in the R console:

```r
quarto::quarto_render("manuscript.qmd")
```

The output will be `manuscript.docx`.

## Placeholders to fill in

Search the .qmd file for `[CITE:` to find spots where citations are needed:

- ICD coding reference for violent victimization definition
- R citation
- IRB approval reference
- Misclassification of race/ethnicity in administrative records

## Figure and table

The .qmd expects saved ggplot and flextable (or gt) objects at:

- `03_results/fig_rates.rds`
- `03_results/tbl_rates.rds`

Save them from your analysis script with `saveRDS()`, then uncomment the `readRDS()` lines in the code chunks.
