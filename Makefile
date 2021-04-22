check:
	for file in *.json; do echo "Parsing $$file" &&  jq . <$$file >/dev/null; done

reformat:
	for file in *.json; do jq . <$$file >$$file.tmp && mv $$file.tmp $$file; done
