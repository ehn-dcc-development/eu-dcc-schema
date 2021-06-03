#!/bin/bash
curl --silent --show-error https://covid-19-diagnostics.jrc.ec.europa.eu/devices/hsc-common-recognition-rat |
jq '.extracted_on as $version | .deviceList | reduce .[] as $i
({};
.[$i.id_device] =
{ "display": ($i.manufacturer.name + ", " + $i.commercial_name),
    "lang":"en",
    "active": true,
    "system": "https://covid-19-diagnostics.jrc.ec.europa.eu/devices",
    "version": $i.last_updated
}) | {"valueSetId": "covid-19-lab-test-manufacturer-and-name", "valueSetDate":$version[0:10], "valueSetValues": .}'
