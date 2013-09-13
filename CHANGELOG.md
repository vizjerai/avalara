## Unreleased
- Updated default production url from https://reset.avalara.net to https://avatax.avalara.net
- Updated tests and gems
- Added missing specs for geographical_tax
- Added validate address
- Added cancel tax
- Added company_code to Avalara::Configuration to be used as a default for request invoice and request cancel_tax

## 0.0.2 - May 7, 2012 - Updated tests for test endpoint.

- Looks like the tests were initally run against the production database (whops). I re-ran them against test and they're still working.
- No code changes for this, other than documenting the test endpoint.

## 0.0.1 - February 3, 2012 - Initial Release with get_tax call

- Not much in the way of features so far, but the rough draft of the get_tax call is in, as well as error and warning message handling. Still need to update the docs with it once an API to the gem is finalized.
