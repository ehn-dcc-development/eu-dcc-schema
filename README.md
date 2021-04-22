# Digital Green Certificate Schema

This repository contains a schema for Digital Green Certificate:

## Files

The main schema file is:

- DGC.schema.json

With the defintions in:

- DGC.Core.Types.schema.json
- DGC.Types.schema.json
- DGC.ValueSets.schema.json

For easy testing - they are combined in:

- DGC-all-schemas-combined.json

But the above 4 files are always leading.

The files:

- example*.json

are examples created in vitro & very artificial.


## Implementation Notes

### CBOR Encoding

Concise Binary Object Representation (CBOR), specified in [RFC7049](https://tools.ietf.org/html/rfc7049), defined a number of major data types. The following types are RECOMMENDED to be used by parties creating electronic health certificates payloads:

- Integers are encoded as CBOR major type 0, an unsigned integer.
- Strings are encoded as CBOR major type 3. a text string.
- Arrays are encoded as CBOR major type 4, an array of data items.
- Objects are encoded as CBOR major type 5, a map of pairs of data items.

Parties validating payloads are strongly advised to follow the robustness principle and be liberal in what you accept from others.
