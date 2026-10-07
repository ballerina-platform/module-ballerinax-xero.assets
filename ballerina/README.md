## Overview

[Xero](https://www.xero.com/) is a cloud-based accounting platform for small and medium-sized businesses. The [Xero Assets API](https://developer.xero.com/documentation/api/assets/overview) exposes the fixed asset features of Xero Accounting, such as registering assets, managing asset types and reading depreciation details.

The Xero Assets connector lets Ballerina applications list, create and look up fixed assets, manage the asset types that define how assets depreciate, and read an organisation's fixed asset settings. It supports version 1.0 of the Xero Assets API.

### Key features

- Search fixed assets by status, with paging, ordering and text filtering
- Register new fixed assets and retrieve an asset with its depreciation details
- Create and list asset types with their depreciation settings
- Read the organisation's fixed asset settings, such as the asset number prefix and the last depreciation date

## Setup guide

To use the Xero Assets connector you need a Xero account and an app registered with the Xero developer portal.

### Step 1: Create a Xero app

1. Sign in to the [Xero developer portal](https://developer.xero.com/app/manage) and select **New app**.
2. Enter an app name and choose the **Web app** integration type.
3. Enter your company URL and add a redirect URI, for example `http://localhost:8080/callback`.
4. Accept the terms and select **Create app**.

### Step 2: Get the client credentials

Open the **Configuration** page of the app and generate a client secret. Note down the client ID and the client secret.

### Step 3: Get a refresh token

1. Direct the user to the authorization URL, replacing `YOUR_CLIENT_ID` and `YOUR_REDIRECT_URI`. Include the `offline_access` scope so that a refresh token is issued.

   ```
   https://login.xero.com/identity/connect/authorize?response_type=code&client_id=YOUR_CLIENT_ID&redirect_uri=YOUR_REDIRECT_URI&scope=openid profile email assets offline_access
   ```

2. Exchange the authorization code returned to your redirect URI for tokens.

   ```bash
   curl -X POST https://identity.xero.com/connect/token \
     -H "Authorization: Basic $(echo -n 'CLIENT_ID:CLIENT_SECRET' | base64)" \
     -d "grant_type=authorization_code&code=AUTHORIZATION_CODE&redirect_uri=YOUR_REDIRECT_URI"
   ```

   The response contains an `access_token` and a `refresh_token`. Use the `assets.read` scope instead of `assets` if the app only needs read access.

### Step 4: Find the tenant ID

Every request must carry the ID of the Xero organisation it acts on. List the organisations the user connected to your app:

```bash
curl -X GET https://api.xero.com/connections \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

Use the `tenantId` of the organisation you want to work with.

## Quickstart

To use the `xero.assets` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/xero.assets;
```

### Step 2: Instantiate a new connector

Create a `Config.toml` file with your credentials:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
tenantId = "<xero-tenant-id>"
```

Then create a client in your `.bal` file:

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string tenantId = ?;

assets:Client xeroAssets = check new ({
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
});
```

### Step 3: Invoke the connector operation

List the registered fixed assets of the organisation:

```ballerina
public function main() returns error? {
    assets:Assets _ = check xeroAssets->listAssets({xeroTenantId: tenantId}, {status: "REGISTERED"});
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Xero Assets` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-xero.assets/tree/main/examples/), covering the following use cases:

1. [Asset register review](https://github.com/ballerina-platform/module-ballerinax-xero.assets/tree/main/examples/asset_register_review) - Page through every registered fixed asset, total the purchase price and book value, and inspect the latest purchase.

2. [Asset type onboarding](https://github.com/ballerina-platform/module-ballerinax-xero.assets/tree/main/examples/asset_type_onboarding) - Create a fixed asset type if it is missing, record a new asset against it and confirm the numbering settings.
