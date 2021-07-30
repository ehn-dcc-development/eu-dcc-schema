BASE_URL=	"https://id.uvci.eu"

SCHEMATA=	DCC.schema.json \
		DCC.Core.Types.schema.json \
		DCC.Types.schema.json \
		DCC.ValueSets.schema.json

MERGED_SCHEMA=	DCC.combined-schema.json
MERGED_ID=	"$(BASE_URL)/$(MERGED_SCHEMA)"

JSON_FILES=	*.json \
		examples/vaccination/*.json \
		examples/test/*.json \
		examples/recovery/*.json \
		test/invalid/*.json \
		test/valid/*.json \
		valuesets/*.json

AJV=		./node_modules/.bin/ajv -c ajv-formats --spec=draft2020 --strict=false


test:: value_sets_current_latest compile validate-valuesets validate-examples check-formatting $(MERGED_SCHEMA)
	$(AJV) test -s $(MERGED_SCHEMA) -d "examples/vaccination/*.json" --valid
	$(AJV) test -s $(MERGED_SCHEMA) -d "examples/recovery/*.json" --valid
	$(AJV) test -s $(MERGED_SCHEMA) -d "examples/test/*.json" --valid
	$(AJV) test -s $(MERGED_SCHEMA) -d "test/invalid/*.json" --invalid

combined: $(MERGED_SCHEMA)

value_sets:
	@echo "Cloning valuesets..."
	[ -d valuesets ] || git clone https://github.com/ehn-dcc-development/ehn-dcc-valuesets.git valuesets

value_sets_current_latest: value_sets
	@echo "Ensuring valuesets are current latest..."
	cd valuesets && git fetch --all -p && git pull && cd -

compile::
	@echo "Compiling schemata..."
	$(AJV) compile -r "DCC.*.schema.json" -s "DCC.schema.json"

check-formatting::
	@echo "Checking JSON formatting..."
	@for file in $(JSON_FILES); do \
		jq . <$$file >$$file.tmp; \
		if ! cmp $$file $$file.tmp; then \
			echo "Please reformat $$file"; \
		fi; \
		rm $$file.tmp; \
	done

validate-examples: value_sets_current_latest
	$(AJV) validate -r "DCC.*.schema.json" -s "DCC.schema.json" -d "examples/vaccination/*.json"
	$(AJV) validate -r "DCC.*.schema.json" -s "DCC.schema.json" -d "examples/recovery/*.json"
	$(AJV) validate -r "DCC.*.schema.json" -s "DCC.schema.json" -d "examples/test/*.json"

validate-valid-tests: value_sets_current_latest
	$(AJV) validate -r "DCC.*.schema.json" -s "DCC.schema.json" -d "test/valid/*.json"
	
validate-invalid-tests: value_sets_current_latest
	$(AJV) test -r "DCC.*.schema.json" -s "DCC.schema.json" -d "test/invalid/*.json" --invalid

validate-valuesets: value_sets_current_latest
	@echo "DEPRECATED: target \"validate-valuesets\" is deprecated for ehn-dcc-schema; should be moved to ehn-dcc-valuesets"
	# $(AJV) validate -s "valueset.json" -d "valuesets/*.json"

$(MERGED_SCHEMA): $(SCHEMATA)
	python3 merge.py --id $(MERGED_ID) $(SCHEMATA) | jq . > $@
	$(AJV) compile -s $@

reformat::
	for file in $(JSON_FILES); do echo $$file; jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done

install-ajv:
	npm install ajv ajv-cli ajv-formats

clean:
	rm -f $(MERGED_SCHEMA) ; rm -rf valuesets
