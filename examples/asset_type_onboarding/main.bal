import ballerina/io;
import ballerinax/xero.assets;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string tenantId = ?;
configurable string assetTypeName = ?;
configurable string assetName = ?;
configurable decimal purchasePrice = ?;
configurable string purchaseDate = ?;
configurable int effectiveLifeYears = 5;
configurable boolean applyChanges = false;

public function main() returns error? {
    assets:Client xeroAssets = check new ({
        auth: {clientId, clientSecret, refreshToken, refreshUrl}
    });

    // Step 1: Look for an existing asset type with the requested name.
    assets:AssetType[] types = check xeroAssets->listAssetTypes({xeroTenantId: tenantId});
    string? typeId = ();
    foreach assets:AssetType t in types {
        if t.assetTypeName == assetTypeName {
            typeId = t.assetTypeId;
            break;
        }
    }

    // Step 2: Create the asset type when it does not exist yet.
    if typeId is () {
        if !applyChanges {
            io:println("Asset type '", assetTypeName, "' does not exist. Set applyChanges = true to create it.");
            return;
        }
        assets:AssetType created = check xeroAssets->createAssetType({xeroTenantId: tenantId}, {
            assetTypeName,
            bookDepreciationSetting: {
                depreciationMethod: "StraightLine",
                averagingMethod: "ActualDays",
                depreciationCalculationMethod: "Life",
                effectiveLifeYears
            }
        });
        typeId = created.assetTypeId;
        io:println("Created asset type: ", assetTypeName);
    } else {
        io:println("Using existing asset type: ", assetTypeName);
    }
    if typeId is () {
        return error("The asset type has no assetTypeId");
    }

    // Step 3: Record the new asset against that type.
    if !applyChanges {
        io:println("Set applyChanges = true to create the asset '", assetName, "'.");
        return;
    }
    assets:Asset asset = check xeroAssets->createAsset({xeroTenantId: tenantId}, {
        assetName,
        assetTypeId: typeId,
        purchaseDate,
        purchasePrice
    });
    io:println("Created asset ", asset.assetName, " with id ", asset.assetId ?: "unknown");

    // Step 4: Confirm the numbering convention that the organisation will apply.
    assets:Setting settings = check xeroAssets->getSettings({xeroTenantId: tenantId});
    io:println("Next asset number prefix: ", settings.assetNumberPrefix ?: "none");
}
