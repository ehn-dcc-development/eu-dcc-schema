check:
	jq . < DGC.schema.json
	jq . < DGC.Core.Types.schema.json
	jq . < DGC.Types.schema.json
	jq . < DGC.ValueSets.schema.json

reformat:
	for file in *.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done
