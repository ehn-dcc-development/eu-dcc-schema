BASE_URL=	"https://id.uvci.eu"

SCHEMATA=	DGC.schema.json \
		DGC.Core.Types.schema.json \
		DGC.Types.schema.json \
		DGC.ValueSets.schema.json

MERGED_SCHEMA=	DGC.combined-schema.json
MERGED_ID=	"$(BASE_URL)/$(MERGED_SCHEMA)"

JSON_FILES=	*.json examples/*.json valuesets/*.json

AJV_=		./node_modules/.bin/ajv -c ajv-formats --spec=draft2020 --strict=false
AJV=		./node_modules/.bin/ajv -c ajv-formats --spec=draft2020 --strict=false


test:: compile validate-valuesets validate-examples check-formatting $(MERGED_SCHEMA)
	$(AJV) test -s $(MERGED_SCHEMA) -d "examples/*.json" --valid
	$(AJV) test -s $(MERGED_SCHEMA) -d "test/invalid/*.json" --invalid

merge: $(MERGED_SCHEMA)

compile::
	@echo "Compiling schemata..."
	$(AJV) compile -r "DGC.*.schema.json" -s "DGC.schema.json"

check-formatting::
	@echo "Checking JSON formatting..."
	@for file in $(JSON_FILES); do \
		jq . <$$file >$$file.tmp; \
		if ! cmp $$file $$file.tmp; then \
			echo "Please reformat $$file"; \
		fi; \
		rm $$file.tmp; \
	done

validate-examples::
	$(AJV) validate -r "DGC.*.schema.json" -s "DGC.schema.json" -d "examples/*.json"

validate-valuesets::
	$(AJV) validate -s "valueset.json" -d "valuesets/*.json"

$(MERGED_SCHEMA): $(SCHEMATA)
	python3 merge.py --id $(MERGED_ID) $(SCHEMATA) | jq . > $@
	$(AJV) compile -s $@

reformat::
	for file in $(JSON_FILES); do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done

install-ajv:
	npm install ajv ajv-cli ajv-formats

clean:
	rm -f $(MERGED_SCHEMA)
