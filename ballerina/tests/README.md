# Running Tests

## Prerequisites

To run the tests against the live Xero Assets API you need a Xero app, an access token with the `assets` scope, and the ID of the Xero organisation (tenant) to use. Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.assets/blob/main/ballerina/README.md#setup-guide) to obtain them.

## Test environments

There are two test environments. The default is a mock server for the Xero Assets API. The other is the live Xero Assets API.

 Test Groups | Environment
-------------|------------------------------------
 mock_tests  | Mock server for Xero Assets API (default)
 live_tests  | Xero Assets API

## Running tests against the mock server

No configuration is needed. When `IS_LIVE_SERVER` is not set to `true`, the tests run against the mock server on port `9090`.

```bash
./gradlew clean test
```

## Running tests against the live API

Set the following environment variables:

```bash
export IS_LIVE_SERVER=true
export XERO_ACCESS_TOKEN="<access-token>"
export XERO_TENANT_ID="<xero-tenant-id>"
```

Then run only the live tests:

```bash
./gradlew clean test -Pgroups=live_tests
```

The tests that create assets and asset types run only against the mock server, so they leave no data in your organisation.

## Test coverage

The suite covers all six operations: `listAssets`, `createAsset`, `getAsset`, `listAssetTypes`, `createAssetType` and `getSettings`.
