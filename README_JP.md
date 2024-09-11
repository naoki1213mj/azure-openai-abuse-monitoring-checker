
# Azure OpenAI Service Abuse Monitoring 状態チェッカー

[English version is here](README.md)

このスクリプトは、Azure Entra IDテナント内のすべてのサブスクリプションにおいて、**Azure OpenAI Service** のリソースに対してabuse monitoring機能が**無効化されていない**かを確認します。各リソースの `ContentLogging` 属性が `false` でない、または設定されていない場合、そのサブスクリプションはabuse monitoringが無効化されておらず、オプトアウトされていない状態であることを示します。また、リソースレベルでも `ContentLogging` が `false` でないリソースをリストアップし、詳細を出力します。

`ContentLogging` が `false` である場合、そのリソースは**abuse monitoringが無効化され、オプトアウトされている**ことを意味します。

このスクリプトは `kind` が `"OpenAI"` であるAzure OpenAIリソースのみを対象としています。

## 前提条件

- **Azure CLI**: Azure CLIがインストールされている必要があります。macOSでのインストールは以下のコマンドを使用します。
  
  ```bash
  brew update
  brew install azure-cli
  ```

- **Azure アカウントアクセス**: Azure OpenAI Serviceのリソースにアクセスできる適切な権限が必要です。

## 使い方

1. **スクリプトの実行**

   以下のコマンドでスクリプトを実行します。

   ```bash
   ./check_abuse_monitoring.sh
   ```

2. **結果の確認**

   スクリプト実行後、`abuse_monitoring_enabled_subscriptions_and_resources.txt` にabuse monitoringが無効化されていない（オプトアウトされていない）サブスクリプションとリソースが出力されます。

   ```bash
   cat abuse_monitoring_enabled_subscriptions_and_resources.txt
   ```

   出力には、サブスクリプションIDと、それに紐づく `ContentLogging` が `false` でないリソースの情報（リソース名、リソースグループ、および `ContentLogging` のステータス）が含まれます。

## 注意事項

- **Azure OpenAIリソースに限定**: このスクリプトは `kind` が `"OpenAI"` であるリソースのみを対象としています。他のCognitive Servicesリソースは除外されます。
- `ContentLogging` が `false` でない、または設定されていないサブスクリプションとリソースはリストに含まれます。
- Azure OpenAI Serviceリソースが存在しないサブスクリプションは、確認対象外です。

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています。詳細は[LICENSE](LICENSE)ファイルをご覧ください。
