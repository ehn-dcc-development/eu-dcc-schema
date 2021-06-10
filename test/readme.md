# Test cases

To help implementers we provide a set of test cases. That are found in subfolders of this directory. Under `invalid` you will find the invalid cases and under `valid` the valid cases.

The document contains an index of the test cases, which provide some form of documentation over the cases - what they're representing, and if applicable why.

The intent is to provide cases based on scenario's that we can realistically expect to see in the real world. Exhaustive combinatorial / fuzzy / bounds testing does not fall under the scope.


# Invalid cases

Filename			| Description
-----------------	| -----------------
empty				| Certificate array is empty
invalid_dob			| Data-of-birth is out of range (before)
invalid_dob			| Data-of-birth is out of range (after)
invalid_vac			| Vaccination with an invalid dose number
missing_dob			| Element 'dob' is missing
missing_fnt			| Element 'fnt' is missing


# Valid cases 

The valid cases contain the certificate type as the first letter (R, T, V). The test certificates are further split into both NAAT (PCR-test) and RAT (rapid antigen) variants.

Best efforts are made to keep these cases realistic. So you will see, for example, that the "is" contains a text matching a real world example.

Filename			| Description
-----------------	| -----------------
R-min-data			| Recovery certifitate with minimal allowable data, `ci` delimited by `:`
T-naat-min-data		| Test NAAT certifitate with minimal allowable data, `ci` delimited by `:`, `sc` format `YYYY-MM-DDThh:mm:ssZ`
T-rat-min-data		| Test RAT certifitate with minimal allowable data, `ci` delimited by `:`, `sc` format `YYYY-MM-DDThh:mm:ssZ`
V-min-data			| Vaccination certifitate with minimal allowable data, `ci` delimited by `:`
R-dates1			| Recovery, `dob` year, `ci` delimited by `/`, `co` is from UNHCR
R-dates2			| Recovery, `dob` year/month, `ci` delimited by `#`
T-rat-dates1		| Test, `dob` year, `ci` delimited by `/`, `co` is from UNHCR, `sc` format `YYYY-MM-DDThh:mm:ss[+-]hh`
T-rat-dates2		| Test, `dob` year/month, `ci` delimited by `#`, `sc` format `YYYY-MM-DDThh:mm:ss[+-]hhmm`
T-rat-dates3		| Test, `sc` format `YYYY-MM-DDThh:mm:ss[+-]hh:mm`, `tc` provided
V-dates1			| Vaccine, `dob` year, `ci` delimited by `/`, `co` is from UNHCR, 
V-dates2			| Vaccine, `dob` year/month, `ci` delimited by `#`

These following variations documented in the specifications are covered by the above test set:

* Date of birth (`dob`) is a year
* Date of birth (`dob`) is a month/year 
* Member state (`co`) is a UNHCR
* Certificate identifer (`ci`) uses delimiter `/` 
* Certificate identifer (`ci`) uses delimiter `#`
* Certificate identifer (`ci`) uses delimiter `:` (this is used as default in the examples)
* Test `sc` date formatted as `YYYY-MM-DDThh:mm:ssZ`
* Test `sc` date formatted as `YYYY-MM-DDThh:mm:ss[+-]hh`
* Test `sc` date formatted as `YYYY-MM-DDThh:mm:ss[+-]hhmm`
* Test `sc` date formatted as `YYYY-MM-DDThh:mm:ss[+-]hh:mm`
* Test value for the optional property `tc` provided for RAT test

The following cases need adding:

* VALID Checksum in the Certificate Identifier
* INVALID Checksum in the Certificate Identifier


