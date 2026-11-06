# Examples

The `ballerinax/xero.assets` connector provides practical examples illustrating usage in various scenarios.

1. **[Asset register review](https://github.com/ballerina-platform/module-ballerinax-xero.assets/tree/main/examples/asset_register_review)** - Page through every registered fixed asset, total the purchase price and book value, and inspect the latest purchase.

2. **[Asset type onboarding](https://github.com/ballerina-platform/module-ballerinax-xero.assets/tree/main/examples/asset_type_onboarding)** - Create a fixed asset type if it is missing, record a new asset against it and confirm the numbering settings.

## Prerequisites

1. Generate Xero credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/xero.assets/latest#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your Config.toml file should look:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://identity.xero.com/connect/token"
tenantId = "<xero-tenant-id>"
```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
