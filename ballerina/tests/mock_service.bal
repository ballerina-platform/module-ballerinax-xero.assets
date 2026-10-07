// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

listener http:Listener ep0 = new (9090);

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {
    # searches fixed asset types
    #
    # + xeroTenantId - Xero identifier for Tenant
    # + return - returns can be any of following types
    # http:Ok (search results matching criteria)
    # http:BadRequest (bad input parameter)
    resource function get AssetTypes(@http:Header {name: "xero-tenant-id"} string xeroTenantId) returns AssetType[]|http:BadRequest {
        return [
            {
                assetTypeId: "3dd2b0f4-5d6a-4c7e-9a11-8f2f6c1d0a01",
                assetTypeName: "Computer Equipment",
                bookDepreciationSetting: {
                    depreciationMethod: "DiminishingValue200",
                    averagingMethod: "ActualDays",
                    depreciationRate: 0.5,
                    depreciationCalculationMethod: "Rate"
                },
                depreciationExpenseAccountId: "4a1e2b6c-0d3f-4e5a-8b7c-1c2d3e4f5a61",
                fixedAssetAccountId: "5b2f3c7d-1e4a-4f6b-9c8d-2d3e4f5a6b72",
                accumulatedDepreciationAccountId: "6c3a4d8e-2f5b-4a7c-8d9e-3e4f5a6b7c83",
                locks: 0
            },
            {
                assetTypeId: "7d4b5e9f-3a6c-4b8d-9eaf-4f5a6b7c8d94",
                assetTypeName: "Office Furniture",
                bookDepreciationSetting: {
                    depreciationMethod: "StraightLine",
                    averagingMethod: "FullMonth",
                    effectiveLifeYears: 10,
                    depreciationCalculationMethod: "Life"
                },
                locks: 1
            }
        ];
    }

    # searches fixed asset
    #
    # + xeroTenantId - Xero identifier for Tenant
    # + status - Required when retrieving a collection of assets. See Asset Status Codes
    # + page - Results are paged. This specifies which page of the results to return. The default page is 1
    # + pageSize - The number of records returned per page. By default the number of records returned is 10
    # + orderBy - Requests can be ordered by AssetType, AssetName, AssetNumber, PurchaseDate and PurchasePrice. If the asset status is DISPOSED it also allows DisposalDate and DisposalPrice
    # + sortDirection - ASC or DESC
    # + filterBy - A string that can be used to filter the list to only return assets containing the text. Checks it against the AssetName, AssetNumber, Description and AssetTypeName fields
    # + return - returns can be any of following types
    # http:Ok (search results matching criteria)
    # http:BadRequest (bad input parameter)
    resource function get Assets(@http:Header {name: "xero-tenant-id"} string xeroTenantId, AssetStatusQueryParam status, int? page, int? pageSize, "AssetType"|"AssetName"|"AssetNumber"|"PurchaseDate"|"PurchasePrice"|"DisposalDate"|"DisposalPrice"? orderBy, "asc"|"desc"? sortDirection, string? filterBy) returns Assets|http:BadRequest {
        return {
            pagination: {page: 1, pageSize: 10, pageCount: 1, itemCount: 2},
            items: [
                {
                    assetId: "a1b2c3d4-0001-4000-8000-000000000001",
                    assetName: "Company Car",
                    assetNumber: "FA-0001",
                    assetStatus: "Registered",
                    assetTypeId: "3dd2b0f4-5d6a-4c7e-9a11-8f2f6c1d0a01",
                    purchaseDate: "2025-01-15",
                    purchasePrice: 28500.00,
                    serialNumber: "VIN-8841-2231",
                    accountingBookValue: 25650.00,
                    canRollback: true,
                    isDeleteEnabledForDate: true
                },
                {
                    assetId: "a1b2c3d4-0002-4000-8000-000000000002",
                    assetName: "Laptop",
                    assetNumber: "FA-0002",
                    assetStatus: "Registered",
                    assetTypeId: "3dd2b0f4-5d6a-4c7e-9a11-8f2f6c1d0a01",
                    purchaseDate: "2025-03-01",
                    purchasePrice: 2400.00,
                    accountingBookValue: 2100.00,
                    canRollback: true,
                    isDeleteEnabledForDate: true
                }
            ]
        };
    }

    # Retrieves fixed asset by id
    #
    # + xeroTenantId - Xero identifier for Tenant
    # + id - fixed asset id for single object
    # + return - returns can be any of following types
    # http:Ok (search results matching criteria)
    # http:BadRequest (bad input parameter)
    resource function get Assets/[string id](@http:Header {name: "xero-tenant-id"} string xeroTenantId) returns Asset|http:BadRequest {
        return {
            assetId: id,
            assetName: "Company Car",
            assetNumber: "FA-0001",
            assetStatus: "Registered",
            assetTypeId: "3dd2b0f4-5d6a-4c7e-9a11-8f2f6c1d0a01",
            purchaseDate: "2025-01-15",
            purchasePrice: 28500.00,
            serialNumber: "VIN-8841-2231",
            warrantyExpiryDate: "2028-01-15",
            accountingBookValue: 25650.00,
            canRollback: true,
            isDeleteEnabledForDate: true,
            bookDepreciationSetting: {
                depreciationMethod: "StraightLine",
                averagingMethod: "ActualDays",
                effectiveLifeYears: 5,
                depreciationCalculationMethod: "Life"
            },
            bookDepreciationDetail: {
                depreciationStartDate: "2025-01-15",
                costLimit: 0.0,
                residualValue: 0.0,
                priorAccumDepreciationAmount: 0.0,
                currentAccumDepreciationAmount: 2850.00,
                currentGainLoss: 0.0
            }
        };
    }

    # searches fixed asset settings
    #
    # + xeroTenantId - Xero identifier for Tenant
    # + return - returns can be any of following types
    # http:Ok (search results matching criteria)
    # http:BadRequest (bad input parameter)
    resource function get Settings(@http:Header {name: "xero-tenant-id"} string xeroTenantId) returns Setting|http:BadRequest {
        return {
            assetNumberPrefix: "FA-",
            assetStartDate: "2024-04-01",
            assetNumberSequence: "0003",
            defaultGainOnDisposalAccountId: "8e5c6fa0-4b7d-4c9e-8fb0-5a6b7c8d9ea5",
            lastDepreciationDate: "2026-09-30",
            defaultCapitalGainOnDisposalAccountId: "9f6d7ab1-5c8e-4daf-9ac1-6b7c8d9eafb6",
            defaultLossOnDisposalAccountId: "a07e8bc2-6d9f-4eb0-8bd2-7c8d9eafb0c7",
            optInForTax: false
        };
    }

    # adds a fixed asset type
    #
    # + xeroTenantId - Xero identifier for Tenant
    # + idempotencyKey - This allows you to safely retry requests without the risk of duplicate processing. 128 character max
    # + payload - Asset type to add
    # + return - returns can be any of following types
    # http:Ok (results single object -  created fixed type)
    # http:BadRequest (invalid input, object invalid)
    # http:Conflict (a type already exists)
    resource function post AssetTypes(@http:Header {name: "xero-tenant-id"} string xeroTenantId, @http:Header {name: "Idempotency-Key"} string? idempotencyKey, @http:Payload AssetType payload) returns AssetTypeOk|JsonBadRequest|http:Conflict {
        AssetType created = payload.clone();
        created.assetTypeId = "b18f9cd3-7eaf-4fc1-9ce3-8d9eafb0c1d8";
        created.locks = 0;
        return <AssetTypeOk>{body: created};
    }

    # adds a fixed asset
    #
    # + xeroTenantId - Xero identifier for Tenant
    # + idempotencyKey - This allows you to safely retry requests without the risk of duplicate processing. 128 character max
    # + payload - Fixed asset you are creating
    # + return - returns can be any of following types
    # http:Ok (return single object - create new asset)
    # http:BadRequest (invalid input, object invalid)
    resource function post Assets(@http:Header {name: "xero-tenant-id"} string xeroTenantId, @http:Header {name: "Idempotency-Key"} string? idempotencyKey, @http:Payload Asset payload) returns AssetOk|JsonBadRequest {
        Asset created = payload.clone();
        created.assetId = "c29a0de4-8fb0-4ad2-8df4-9eafb0c1d2e9";
        created.assetStatus = "Draft";
        return <AssetOk>{body: created};
    }
}

// Service-mode response types. `bal openapi --mode client` collapses 4XX/5XX
// to `error` and never emits these, so they are defined here for the mock only.
public type AssetOk record {|
    *http:Ok;
    Asset body;
|};

public type AssetTypeOk record {|
    *http:Ok;
    AssetType body;
|};

public type JsonBadRequest record {|
    *http:BadRequest;
    json body;
|};
