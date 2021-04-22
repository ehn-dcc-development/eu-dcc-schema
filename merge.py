import json
import re
import sys

PATTERNS = [re.compile(r"^https://ec\.europa\.eu/dgc/DGC\..+\.schema\.json(.*)")]


def load_json(filename: str):
    with open(filename, "rt") as input_file:
        return json.load(input_file)


def rewrite_refs(data):
    res = {}
    if isinstance(data, dict):
        return {k: rewrite_refs(v) for k, v in data.items()}
    elif isinstance(data, list):
        return [rewrite_refs(i) for i in data]
    elif isinstance(data, str):
        for p in PATTERNS:
            m = p.match(data)
            if m:
                return m.group(1)
        return data
    else:
        return data


def main():
    """Main function"""

    main_fn = sys.argv[1]

    schema = load_json(main_fn)
    schema = rewrite_refs(schema)

    if "$defs" not in schema:
        schema["$defs"] = {}

    for fn in sys.argv[1:]:
        extra = rewrite_refs(load_json(fn))
        schema["$defs"].update(extra.get("$defs", {}))

    print(json.dumps(schema, indent=4))


if __name__ == "__main__":
    main()
