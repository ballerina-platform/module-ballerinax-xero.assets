# Asset register review

This example reviews the fixed asset register of a Xero organisation. It reads the asset settings, pages through every registered asset, totals the purchase price and book value, and then fetches the most recent purchase in full to show its depreciation set-up.

## Prerequisites

### 1. Set up a Xero app

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.assets/blob/main/ballerina/README.md#setup-guide) to obtain a client ID, client secret and refresh token. The app needs the `assets.read` scope (or `assets`) and `offline_access`. You also need the ID of the Xero organisation (tenant) to query.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://identity.xero.com/connect/token"
tenantId = "<xero-tenant-id>"
pageSize = 50
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
