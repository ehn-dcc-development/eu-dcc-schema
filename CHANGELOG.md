# Change log

## Release 1.3.3

* Update the sub schema `DCC.ValueSets.schema.json` for the new valueset `vaccine-encoding-instructions` corresponding to Annex A of (version 1.14 of) [guidelines document](https://ec.europa.eu/health/sites/default/files/ehealth/docs/digital-green-value-sets_en.pdf).


## Release 1.3.2

* ([PR #141](https://github.com/ehn-dcc-development/ehn-dcc-schema/issues/141)) achieves the following:
  * The elements `fnt` and `gnt` are now optional, with one of the two being required.
    This conforms to the latest [Implementing Decision 2022/483](https://eur-lex.europa.eu/legal-content/EN/TXT/HTML/?uri=CELEX:32022D0483).
    (The changes are in ANNEX II chapter 3.2.).
  * Examples and tests are updated for these new cases (and for several different sequences).
  * `merge.py` now outputs un-HTML-encoded text in modern Python.

