# Azure OpenAI Service Abuse Monitoring Status Checker

This script checks whether the `abuse monitoring` feature is disabled for Azure OpenAI Service resources across all subscriptions in your Azure tenant. It verifies if the `ContentLogging` attribute is set to `false` for each resource in the subscription, and outputs the list of subscriptions where abuse monitoring is disabled to a text file.

## Prerequisites

- **Azure CLI**: Make sure Azure CLI is installed. You can install it on macOS using Homebrew:
  
  ```bash
  brew update
  brew install azure-cli
  ```

- **Azure Account Access**: Ensure that you have sufficient permissions to list and access Azure OpenAI Service resources across all subscriptions in your Azure tenant.

## How It Works

- The script retrieves all subscriptions associated with the logged-in Azure account.
- For each subscription, it checks for the existence of Azure OpenAI Service resources.
- If no Azure OpenAI resources exist in a subscription, the script assumes that abuse monitoring is disabled for that subscription.
- If resources are found, it checks if the `ContentLogging` attribute is set to `false`. If all resources have this attribute set to `false`, the subscription is considered to have abuse monitoring disabled.
- The list of subscriptions with abuse monitoring disabled is written to a file named `abuse_monitoring_disabled_subscriptions.txt`.

## Script Details

The script performs the following steps:

1. **Set up the environment**: The script logs in to Azure using the logged-in user's credentials.
2. **Retrieve subscriptions**: It fetches a list of all subscriptions in the tenant.
3. **Check resources**: For each subscription, it checks for Azure OpenAI Service resources and verifies their `ContentLogging` status.
4. **Output results**: Subscriptions with abuse monitoring disabled are written to `abuse_monitoring_disabled_subscriptions.txt`.

## Usage

### 1. Clone the repository or download the script

```bash
git clone https://github.com/your-repo-name/azure-openai-abuse-monitoring-checker.git
cd azure-openai-abuse-monitoring-checker
```

Alternatively, download the `check_abuse_monitoring.sh` file directly and place it in a directory of your choice.

### 2. Grant execute permission to the script

Before running the script, ensure it has execute permissions:

```bash
chmod +x check_abuse_monitoring.sh
```

### 3. Run the script

Execute the script using the following command:

```bash
./check_abuse_monitoring.sh
```

The script will log in to Azure and check each subscription for abuse monitoring settings. Subscriptions where abuse monitoring is disabled will be saved to a file named `abuse_monitoring_disabled_subscriptions.txt` in the current directory.

### 4. View the results

After the script finishes running, you can check the file `abuse_monitoring_disabled_subscriptions.txt` for the list of subscriptions with abuse monitoring disabled:

```bash
cat abuse_monitoring_disabled_subscriptions.txt
```

## Example Output

Here is an example of what the output file might look like:

```
subscription-id-1
subscription-id-2
subscription-id-3
```

Each line in the file represents a subscription ID where all Azure OpenAI resources have `ContentLogging` set to `false`, or where no OpenAI resources exist, indicating abuse monitoring is disabled.

## Notes

- If any resources in a subscription have `ContentLogging` set to `true` or are not configured, that subscription will not be listed in the output file.
- The script assumes that if no Azure OpenAI Service resources are found in a subscription, abuse monitoring is effectively disabled for that subscription.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
