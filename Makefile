SCHEMATA=	DGC.schema.json \
		DGC.Core.Types.schema.json \
		DGC.Types.schema.json \
		DGC.ValueSets.schema.json
MERGED=		DGC-all-schemas-combined.json

AJV=		./node_modules/.bin/ajv -c ajv-formats --spec=draft2020


test:: compile validate-valuesets validate-examples check-formatting $(MERGED)
	$(AJV) test -s $(MERGED) -d "examples/*.json" --valid
	$(AJV) test -s $(MERGED) -d "test/invalid/*.json" --invalid

merge: $(MERGED)

compile::
	@echo "Compiling schemata..."
	-$(AJV) compile -r "DGC.*.schema.json" -s "DGC.schema.json"

check-formatting::
	@echo "Checking JSON formatting..."
	@for file in $(SCHEMATA) examples/*.json; do \
		jq . <$$file >$$file.tmp; \
		if ! cmp $$file $$file.tmp; then \
			echo "Please reformat $$file"; \
		fi; \
		rm $$file.tmp; \
	done

validate-examples::
	-$(AJV) validate -r "DGC.*.schema.json" -s "DGC.schema.json" -d "examples/*.json"

validate-valuesets::
	-$(AJV) validate -s "valueset.json" -d "valuesets/*.json"

$(MERGED): $(SCHEMATA)
	python3 merge.py $(SCHEMATA) | jq . > $@
	-$(AJV) compile -s $@
	-$(AJV) validate -s $@ -d "examples/*.json"

reformat::
	for file in *.json valuesets/*.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done

install-ajv:
	npm install ajv ajv-cli ajv-formats

clean:
	rm -f $(MERGED)
