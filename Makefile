check:: check-schemata check-examples

check-schemata::
	jq . < DGC.schema.json
	jq . < DGC.Core.Types.schema.json
	jq . < DGC.Types.schema.json
	jq . < DGC.ValueSets.schema.json

check-examples::
	@echo "Examples not yet checked"

reformat::
	for file in *.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done
