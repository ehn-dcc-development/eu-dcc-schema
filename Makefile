AJV=	./node_modules/.bin/ajv -c ajv-formats


test:: check-formatting compile

compile::
	@echo "Compiling schemata..."
	-$(AJV) compile -r "DGC.*.schema.json" -s "DGC.schema.json"

check-formatting::
	@echo "Checking JSON formatting..."
	@for file in DGC.*.json example-*.json; do \
		jq . <$$file >$$file.tmp; \
		if ! cmp $$file $$file.tmp; then \
			echo "Please reformat $$file"; \
		fi; \
		rm $$file.tmp; \
	done

reformat::
	for file in *.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done

install-ajv:
	npm install ajv ajv-cli ajv-formats
