# Ballerina Xero Assets connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-xero.assets/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-xero.assets/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-xero.assets.svg)](https://github.com/ballerina-platform/module-ballerinax-xero.assets/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/xero.assets.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fxero.assets)

## Overview

[Xero](https://www.xero.com/) is a cloud-based accounting platform for small and medium-sized businesses. The [Xero Assets API](https://developer.xero.com/documentation/api/assets/overview) exposes the fixed asset features of Xero Accounting, such as registering assets, managing asset types and reading depreciation details.

The Xero Assets connector lets Ballerina applications list, create and look up fixed assets, manage the asset types that define how assets depreciate, and read an organisation's fixed asset settings. It supports version 1.0 of the Xero Assets API.

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

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`xero.assets` package](https://central.ballerina.io/ballerinax/xero.assets/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
