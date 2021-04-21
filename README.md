# JSON Schema for the ehn DGC payload.

This repository contains the EU eHealthNetwork official JSON schema documents defining the data payload for the Digital Green Certificate.
This is a work-in-progress and the files are here for the primary purposes of:
1. ease of review, and
1. ease of reference for implementers

## Structure

Due to the somewhat complex nature of the payload referencing, the schema was split into four separate, more manageable files, split logically into:

1. ```DGC.schema.json```
   1. the overall, high-level DGC type which combines the lower level types into the overall DGC structure
1. ```DGC.Types.schema.json```
   1. higher-level composite types, incorporating ```DGC.Core.Types.schema.json``` and ```DGC.ValueSets.schema.json```
1. ```DGC.ValueSets.schema.json```
   1. the value sets from  the eHN doc: "Guidelines on Value Sets for Digital Green Certificates", Version 1.0, 2021-04-16
1. ```DGC.Core.Types.schema.json```
   1. generally re-usable types
