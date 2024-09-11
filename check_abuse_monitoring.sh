#!/bin/bash

# 出力ファイル名
output_file="abuse_monitoring_disabled_subscriptions.txt"

# 出力ファイルを初期化
> $output_file

# 全サブスクリプションを取得
subscriptions=$(az account list --query "[].id" -o tsv)

for subscription in $subscriptions; do
    # サブスクリプションを設定
    az account set --subscription $subscription

    echo "Checking subscription: $subscription"

    # OpenAIサービスリソースのリストを取得
    resources=$(az cognitiveservices account list --query "[].{Name:name, ResourceGroup:resourceGroup}" -o tsv)

    if [ -z "$resources" ]; then
        echo "No OpenAI resources found in subscription: $subscription"
        continue
    fi

    all_logging_false=true

    # 各リソースについて確認
    while read -r resourceName resourceGroup; do
        echo "Checking resource: $resourceName in resource group: $resourceGroup"

        # ContentLoggingの確認
        loggingStatus=$(az cognitiveservices account show -n "$resourceName" -g "$resourceGroup" --query "properties.capabilities[?name=='ContentLogging'].value" -o tsv)

        if [[ "$loggingStatus" != "false" ]]; then
            all_logging_false=false
        fi
    done <<< "$resources"

    if [ "$all_logging_false" = true ]; then
        echo "All resources in subscription $subscription have ContentLogging set to false."
        # ファイルにサブスクリプションIDを追加
        echo "$subscription" >> $output_file
    else
        echo "Some or all resources in subscription $subscription have ContentLogging set to true or not configured."
    fi
done

echo "Subscriptions with abuse monitoring disabled have been saved to $output_file"
