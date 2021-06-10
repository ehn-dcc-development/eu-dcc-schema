#!/bin/sh
python3 merge.py DCC.schema.json DCC.Core.Types.schema.json DCC.Types.schema.json DCC.ValueSets.schema.json --id=https://id.uvci.eu/DCC.combined-schema.json > DCC.combined-schema.json
