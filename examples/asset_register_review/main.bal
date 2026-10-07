import ballerina/io;
import ballerinax/xero.assets;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string tenantId = ?;
configurable int pageSize = 50;

public function main() returns error? {
    if pageSize <= 0 {
        return error(string `pageSize must be a positive integer, but was ${pageSize}`);
    }
    assets:Client xeroAssets = check new ({
        auth: {clientId, clientSecret, refreshToken, refreshUrl}
    });

    // Step 1: Read the asset settings to learn the numbering convention.
    assets:Setting settings = check xeroAssets->getSettings({xeroTenantId: tenantId});
    string prefix = settings.assetNumberPrefix ?: "";
    io:println("Asset number prefix: ", prefix);

    // Step 2: Page through every registered asset.
    assets:Asset[] registered = [];
    int page = 1;
    while true {
        assets:Assets result = check xeroAssets->listAssets({xeroTenantId: tenantId},
                {status: "REGISTERED", page, pageSize, orderBy: "PurchaseDate", sortDirection: "asc"});
        assets:Asset[] items = result.items ?: [];
        registered.push(...items);
        if items.length() < pageSize {
            break;
        }
        page += 1;
    }

    // Step 3: Total the purchase price and the book value of the register.
    decimal totalCost = 0d;
    decimal totalBookValue = 0d;
    foreach assets:Asset asset in registered {
        totalCost += asset.purchasePrice ?: 0d;
        totalBookValue += asset.accountingBookValue ?: 0d;
    }
    io:println("Registered assets: ", registered.length());
    io:println("Total purchase price: ", totalCost);
    io:println("Total book value: ", totalBookValue);

    // Step 4: Fetch the most recent purchase in full to show its depreciation set-up.
    if registered.length() == 0 {
        return error("No registered assets were found for this organisation");
    }
    string latestId = registered[registered.length() - 1].assetId ?: "";
    if latestId == "" {
        return error("The latest registered asset has no assetId");
    }
    assets:Asset latest = check xeroAssets->getAsset(latestId, {xeroTenantId: tenantId});
    io:println("Latest purchase: ", latest.assetName, " (", latest.assetNumber ?: "no number", ")");
    io:println("Depreciation method: ", latest.bookDepreciationSetting?.depreciationMethod ?: "not set");
}
