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
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.xero.com/assets.xro/1.0" : "http://localhost:9090";
final string token = isLiveServer ? os:getEnv("XERO_ACCESS_TOKEN") : "test_token";
final string tenantId = isLiveServer ? os:getEnv("XERO_TENANT_ID") : "00000000-0000-0000-0000-000000000000";

final Client xeroAssets = check new ({
    auth: {token},
    httpVersion: isLiveServer ? http:HTTP_2_0 : http:HTTP_1_1
}, serviceUrl);

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListAssets() returns error? {
    Assets response = check xeroAssets->listAssets({xeroTenantId: tenantId}, {status: "REGISTERED"});
    test:assertTrue(response?.items !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetAsset() returns error? {
    Asset response = check xeroAssets->getAsset("a1b2c3d4-0001-4000-8000-000000000001", {xeroTenantId: tenantId});
    test:assertTrue(response?.assetId !is ());
}

@test:Config {groups: ["mock_tests"]}
isolated function testCreateAsset() returns error? {
    Asset response = check xeroAssets->createAsset({xeroTenantId: tenantId}, {assetName: "Standing Desk", purchasePrice: 650.00});
    test:assertEquals(response.assetName, "Standing Desk");
    test:assertTrue(response?.assetId !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListAssetTypes() returns error? {
    AssetType[] response = check xeroAssets->listAssetTypes({xeroTenantId: tenantId});
    test:assertTrue(response.length() > 0);
}

@test:Config {groups: ["mock_tests"]}
isolated function testCreateAssetType() returns error? {
    AssetType response = check xeroAssets->createAssetType({xeroTenantId: tenantId}, {
        assetTypeName: "Vehicles",
        bookDepreciationSetting: {depreciationMethod: "StraightLine", averagingMethod: "ActualDays", effectiveLifeYears: 8}
    });
    test:assertEquals(response.assetTypeName, "Vehicles");
    test:assertTrue(response?.assetTypeId !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetSettings() returns error? {
    Setting response = check xeroAssets->getSettings({xeroTenantId: tenantId});
    test:assertTrue(response?.assetNumberPrefix !is ());
}
