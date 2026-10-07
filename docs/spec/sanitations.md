_Author_:  Dimuthu Madushan \
_Created_: 2026/10/07 \
_Updated_: 2026/10/07 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Xero Assets. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/xero/assets/19.0.0/openapi.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Rename the operation IDs to a consistent `list*`/`get*`/`create*` convention, keeping each one under 37 characters:

   | Method and path | Original operationId | Updated operationId |
   |---|---|---|
   | `GET /Assets` | `getAssets` | `listAssets` |
   | `GET /Assets/{id}` | `getAssetById` | `getAsset` |
   | `GET /AssetTypes` | `getAssetTypes` | `listAssetTypes` |
   | `GET /Settings` | `getAssetSettings` | `getSettings` |

   `POST /Assets` (`createAsset`) and `POST /AssetTypes` (`createAssetType`) keep their IDs. The decisions are stored
   in `docs/spec/ai-mappings.json` so that a regeneration reproduces them.

2. Keep every schema name as published. The schema names were reviewed and recorded as identity mappings in
   `docs/spec/ai-mappings.json`.

3. Flatten and align the specification with `bal openapi flatten` and `bal openapi align`. The aligned specification
   is `docs/spec/aligned_ballerina_openapi.json`; it is the input to client generation. The flatten and align steps make
   no structural change to this specification (no server URL, path prefix, format, nullability or type changes).

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```

Note: The license year is hardcoded to 2026, change if necessary.
