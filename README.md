# Digital Covid Certificate Schema

This repository contains a JSON schema for the EU Digital Covid Certificate.

**Schema version:** 1.3.3

**Release date:** 2023-05-24 (tentative, dependent on eHN Coordinated Actions meeting)

## IMPORTANT NOTICE

As of July 1st 2023 the EU-DCC project has been handed over to the WHO. The project has therefore been frozen. This repository will be placed into archival mode and will remain available for the foreseeable future however it will no longer be actively maintained.

## Introduction

The Digital Covid Certificate (DCC) JSON schema is provided as a mechanism for supporting the serialization and  deserialization of the DCC payload, initially with focus on generation of a 2D barcode (QR Code).

The schema is intended to support different use cases that EU Member States require. The schema shall also support conformity to the [EU legislation](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52021PC0130) regarding  what shall present in a certificate to ensure freedom of movement within EU Member States and also to allow interoperability with countries outside of the EU zone.

The schema in conjunction with business rules (which may also be specific to a Member State) shall ensure conformity to the EU legislation, whereby the burden of conformity lies with the business rules and the DCC JSON schema plays a supporting role in allowing the data to be serialized and deserialized in a flexible, yet structured, manner.


## Schema files

The main schema file is:

- [DCC.schema.json](./DCC.schema.json)

With the definitions in:

- [DCC.Core.Types.schema.json](./DCC.Core.Types.schema.json)
- [DCC.Types.schema.json](./DCC.Types.schema.json)
- [DCC.ValueSets.schema.json](./DCC.ValueSets.schema.json)

For easy testing, they are combined in:

- [DCC.combined-schema.json](./DCC.combined-schema.json)

The rule labeled as `$(MERGED_SCHEMA)` in the [Makefile](./Makefile) makes this target by combining the 4 schema files (“schemata”) mentioned above into one schema file, and also reformatting and validating it.
The [`merge.sh` script](./merge.sh) does the same, but without reformatting and validating the resulting JSON.
This can be useful for development purposes, but make sure to run `make` prior to committing.

_Note:_ the first 4, non-combined schema files are always leading.


### Value sets

See https://github.com/ehn-dcc-development/ehn-dcc-valuesets


## Implementation Notes

A list of Frequently Asked Questions (FAQ) for implementors can be found [here](wiki/FAQ.md).


## Prerequisites

The Makefile assumes that the following tools are installed, and are available on the shell's path:

* [Python (version 3)](https://www.python.org/downloads/)
* A(ny) Make (such as [GNU Make](https://www.gnu.org/software/make/)) to execute the [Makefile](./Makefile).
* [Node.js](https://nodejs.org/en/download/): installing Node.js also installs the [NPM package manager](https://www.npmjs.com/) which is used to install a couple of dependencies.
* [jq](https://stedolan.github.io/jq/)


The Makefile also relies on the [`ajv` JSON Schema validator](https://ajv.js.org/), which is installed by the `install-ajv` rule in the Makefile:

    $ make install-ajv


## Examples and test cases

The examples and the test cases can be validated with `ajv` by using the following commands.

To validate all of the examples:

	make validate-examples
	
...and all of expected valid tests:

	make validate-valid-tests

...and all of the expected invalid tests:

	make validate-invalid-tests


## Committing: Git hooks

This project uses Git hooks to validate the JSON files and the above test cases.
To use the hooks, configure Git to use the hooks we provide, as follows:

```
git config core.hooksPath hooks
```
