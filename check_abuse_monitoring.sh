#!/bin/bash

# 出力ファイル名
output_file="abuse_monitoring_enabled_subscriptions_and_resources.txt"

# 出力ファイルを初期化
> $output_file

# 全サブスクリプションを取得
subscriptions=$(az account list --query "[].id" -o tsv)

for subscription in $subscriptions; do
    # サブスクリプションを設定
    az account set --subscription $subscription

    echo "Checking subscription: $subscription"

    # OpenAIサービスリソースのリストを取得 (kindが"OpenAI"のリソースのみ)
    resources=$(az cognitiveservices account list --query "[?kind=='OpenAI'].{Name:name, ResourceGroup:resourceGroup}" -o tsv)

    if [ -z "$resources" ]; then
        echo "No OpenAI resources found in subscription: $subscription"
        continue
    fi

    any_logging_true=false
    resources_with_logging_enabled=""

    # 各リソースについて確認
    while read -r resourceName resourceGroup; do
        echo "Checking resource: $resourceName in resource group: $resourceGroup"

        # ContentLoggingの確認
        loggingStatus=$(az cognitiveservices account show -n "$resourceName" -g "$resourceGroup" --query "properties.capabilities[?name=='ContentLogging'].value" -o tsv)

        if [[ "$loggingStatus" != "false" ]]; then
            any_logging_true=true
            resources_with_logging_enabled+="$resourceName (Resource Group: $resourceGroup, ContentLogging: $loggingStatus)\n"
        fi
    done <<< "$resources"

    if [ "$any_logging_true" = true ]; then
        echo "Some or all resources in subscription $subscription have ContentLogging set to true or not configured."
        # サブスクリプションIDをファイルに追加
        echo "-------------------------------------" >> $output_file
        echo "Subscription: $subscription" >> $output_file
        echo "Resources with ContentLogging enabled or not configured:" >> $output_file
        # リソース情報を追加
        echo -e "$resources_with_logging_enabled" >> $output_file
        echo "-------------------------------------" >> $output_file
    else
        echo "All resources in subscription $subscription have ContentLogging set to false."
    fi
done

echo "Subscriptions with abuse monitoring enabled and their resources have been saved to $output_file"
