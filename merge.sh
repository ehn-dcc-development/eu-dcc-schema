#!/bin/sh
# You can use the Makefile to create the merged output but that requires an install of npm and jq
# This shell script is a much more lightweight version which does just the file merge via merge.py
python3 merge.py DCC.schema.json DCC.Core.Types.schema.json DCC.Types.schema.json DCC.ValueSets.schema.json --id=https://id.uvci.eu/DCC.combined-schema.json > DCC.combined-schema.json
