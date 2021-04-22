AJV=	./node_modules/.bin/ajv


test:: check-formatting compile-schemata

compile-schemata::
	@echo "Compiling schemata..."
	$(AJV) compile -s DGC.schema.json
	$(AJV) compile -s DGC.Core.Types.schema.json
	$(AJV) compile -s DGC.Types.schema.json
	$(AJV) compile -s DGC.ValueSets.schema.json

check-formatting::
	@echo "Checking JSON formatting..."
	@for file in *.json; do \
		jq . <$$file >$$file.tmp; \
		if ! cmp $$file $$file.tmp; then \
			echo "Please reformat $$file"; \
		fi; \
		rm $$file.tmp; \
	done

reformat::
	for file in *.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done

install-ajv:
	npm install ajv ajv-cli
