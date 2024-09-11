
# Azure OpenAI Service Abuse Monitoring 状態チェッカー

[English version is here](README.md)

このスクリプトは、Azureテナント内のすべてのサブスクリプションにおいて、Azure OpenAI Serviceのリソースに対してabuse monitoring機能が無効になっているかを確認します。各リソースの `ContentLogging` 属性が `false` になっているかを確認し、abuse monitoringが無効化されているサブスクリプションの一覧をテキストファイルに出力します。

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

   スクリプト実行後、`abuse_monitoring_disabled_subscriptions.txt` にabuse monitoringが無効化されているサブスクリプションが出力されます。

   ```bash
   cat abuse_monitoring_disabled_subscriptions.txt
   ```

## 注意事項

- `ContentLogging` が `false` でない、または設定されていないサブスクリプションはリストに含まれません。
- Azure OpenAI Serviceリソースが存在しないサブスクリプションも自動的にabuse monitoringが無効化されていると見なされます。

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています。詳細は[LICENSE](LICENSE)ファイルをご覧ください。
