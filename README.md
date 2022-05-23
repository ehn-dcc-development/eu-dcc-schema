# Digital Covid Certificate Schema

This repository contains a JSON schema for the EU Digital Covid Certificate.

**Schema version:** 1.3.1
**Release date:** _to be determined_


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

A list of [Frequently Asked Questions](https://github.com/ehn-dcc-development/ehn-dcc-schema/wiki/FAQ) for implementors can be found in the [repository wiki](https://github.com/ehn-dcc-development/ehn-dcc-schema/wiki).


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

	$ make validate-examples
	
..and all of expected valid tests:

	$ make validate-valid-tests

..and all of the expected invalid tests:

	$ make validate-invalid-tests


## JSON formatting

The makefile provides several utility functions, useful for pre-commits.

To check the formatting of the JSON:

	$ make reformat
	
To automatically reformat all JSON files:

	$ make check-formatting


## Preparing a Pull Request

You're part of the team and are working on the schema and want to share that work with the world. Great! To ensure that your branch is in tip-top shape we have a set of commands in the makefile. These run tests and format the files correctly. Doing this before creating a PR will minimise time spent fixing small things for everyone involved.

The first and most important step: **make sure that you have committed your work to a local feature branch!** These steps modify files, so there is a small chance that some work could be lost. If it's committed then you can always restore it.

Now for the process:

1. Reformat the json (`$ make reformat`)
1. Compile the schema (`$ make compile`)
1. Validate the **valid** test cases (`$ make validate-valid-tests`)
1. Validate the **invalid** test cases (`$ make validate-invalid-tests`)
1. Validate the examples (`$ make validate-examples`)

Once everything is working as expected (no errors, all tests pass) you can commit any changes, rebase to clean up the commit log if you so wish, push your changes and finally open a PR..