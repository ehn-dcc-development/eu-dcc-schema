# Digital Covid Certificate Schema

This repository contains a JSON schema for the EU Digital Covid Certificate.

**Schema version:** 1.3.0
**Release date:** 2020-06-09


## Introduction

The Digital Covid Certificate (DCC) JSON schema is provided as a mechanism for supporting the serialization and  deserialization of the DCC payload, initially with focus on generation of a 2D barcode (QR Code).

The schema is intended to support different use cases that EU Member States require. The schema shall also support conformity to the [EU legislation](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52021PC0130) regarding  what shall present in a certificate to ensure freedom of movement within EU Member States and also to allow interoperability with countries outside of the EU zone.

The schema in conjunction with business rules (which may also be specific to a Member State) shall ensure conformity to the EU legislation, whereby the burden of conformity lies with the business rules and the DCC JSON schema plays a supporting role in allowing the data to be serialized and deserialized in a flexible, yet structured, manner.


## Files

The main schema file is:

- DCC.schema.json

With the definitions in:

- DCC.Core.Types.schema.json
- DCC.Types.schema.json
- DCC.ValueSets.schema.json

For easy testing, they are combined in:

- DCC.combined-schema.json

But the above 4 files are always leading.

## Implementation Notes

A list of [Frequently Asked Questions](https://github.com/ehn-dcc-development/ehn-dcc-schema/wiki/FAQ) for implementors can be found in the [repository wiki](https://github.com/ehn-dcc-development/ehn-dcc-schema/wiki).
