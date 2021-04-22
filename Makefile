check:: check-schemata check-formatting

check-schemata::
	@echo "Checking schemata JSON..."
	@jq . <DGC.schema.json >/dev/null
	@jq . <DGC.Core.Types.schema.json >/dev/null
	@jq . <DGC.Types.schema.json >/dev/null
	@jq . <DGC.ValueSets.schema.json >/dev/null

check-formatting::
	@echo "Checking formatting..."
	@for file in *.json; do \
		jq . <$$file >$$file.tmp; \
		if ! cmp $$file $$file.tmp; then \
			echo "Please reformat $$file"; \
		fi; \
		rm $$file.tmp; \
	done


reformat::
	for file in *.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done
