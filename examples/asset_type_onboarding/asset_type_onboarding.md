# Asset type onboarding

This example prepares a Xero organisation to track a new kind of fixed asset. It looks for an asset type by name, creates it with a straight-line depreciation set-up if it does not exist, records a new asset against that type, and reads the asset settings to confirm the numbering convention. Nothing is written unless `applyChanges` is set to `true`.

## Prerequisites

### 1. Set up a Xero app

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.assets/blob/main/ballerina/README.md#setup-guide) to obtain a client ID, client secret and refresh token. The app needs the `assets` scope and `offline_access`. You also need the ID of the Xero organisation (tenant) to update.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://identity.xero.com/connect/token"
tenantId = "<xero-tenant-id>"
assetTypeName = "<asset-type-name, e.g. Vehicles>"
assetName = "<asset-name, e.g. Delivery van>"
purchasePrice = 32000.00
purchaseDate = "<purchase-date (yyyy-MM-dd), e.g. 2026-09-01>"
effectiveLifeYears = 5
applyChanges = false
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
