check:: check-schemata check-examples check-format

check-schemata::
	jq . < DGC.schema.json
	jq . < DGC.Core.Types.schema.json
	jq . < DGC.Types.schema.json
	jq . < DGC.ValueSets.schema.json

check-format::
	for file in *.json; do \
		jq . <$$file >$$file.tmp; \
		if ! cmp $$file $$file.tmp; then \
			echo "Please reformat $$file"; \
		fi; \
		rm $$file.tmp; \
	done

check-examples::
	@echo "Examples not yet checked"

reformat::
	for file in *.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done
