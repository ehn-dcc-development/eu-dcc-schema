import argparse
import json
import re
import sys

PATTERNS = [re.compile(r"^https://id\.uvci\.eu/.+\.schema\.json(.+)")]


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

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--id",
        metavar="URL",
        help="Merged schema ID",
        required=True,
    )
    parser.add_argument(
        "sources",
        nargs="*",
        metavar="URL",
        help="Schema source",
    )
    args = parser.parse_args()

    main_fn = args.sources.pop(0)

    schema = load_json(main_fn)
    schema = rewrite_refs(schema)

    if "$defs" not in schema:
        schema["$defs"] = {}

    for fn in args.sources:
        extra = rewrite_refs(load_json(fn))
        schema["$defs"].update(extra.get("$defs", {}))

    schema["$id"] = args.id

    print(json.dumps(schema, indent=2))


if __name__ == "__main__":
    main()
