
# Azure OpenAI Service Abuse Monitoring Status Checker

[日本語はこちら](README_JP.md)

This script checks whether abuse monitoring is **enabled** for **Azure OpenAI Service** resources across all subscriptions in your Azure Entra ID tenant. It verifies if the `ContentLogging` property for each resource is not set to `false` or is not configured. If any resource in a subscription has `ContentLogging` not set to `false`, that subscription will be listed as one where abuse monitoring is enabled and not opted out. Additionally, the resources with `ContentLogging` not set to `false` are listed in detail.

If `ContentLogging` is `false`, it indicates that the resource has **abuse monitoring disabled** and is opted out.

This script specifically targets Azure OpenAI resources where `kind` is `"OpenAI"`.

## Prerequisites

- **Azure CLI**: Ensure Azure CLI is installed. For macOS, you can install it using the following command:
  
  ```bash
  brew update
  brew install azure-cli
  ```

- **Azure Account Access**: Ensure you have the proper access permissions to the Azure OpenAI Service resources.

## Usage

1. **Run the script**

   Run the following command to execute the script:

   ```bash
   ./check_abuse_monitoring.sh
   ```

2. **Check the results**

   After running the script, the file `abuse_monitoring_enabled_subscriptions_and_resources.txt` will contain the list of subscriptions where abuse monitoring is enabled (not opted out), along with the detailed information of resources.

   ```bash
   cat abuse_monitoring_enabled_subscriptions_and_resources.txt
   ```

   The output includes the subscription ID and the corresponding resource details (resource name, resource group, and `ContentLogging` status) for each resource where `ContentLogging` is not set to `false`.

## Notes

- **Azure OpenAI Resources Only**: This script only checks resources where `kind` is `"OpenAI"`. Other Cognitive Services resources are excluded.
- Subscriptions and resources where `ContentLogging` is not set to `false` or is not configured will be included in the list.
- Subscriptions without Azure OpenAI Service resources are not included in the check.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
