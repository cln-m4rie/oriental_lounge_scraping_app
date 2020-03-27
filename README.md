# 相席ラウンジのスクレイピングやるぞ

[相席ラウンジ](https://oriental-lounge.com/)の現在の男女の人数を抽出して Slack に通知するものを作りました

## 使用したもの

- python3.7 (BeautifulSoup)
- GCP (Cloud Funtions, Pub/Sub, Cloud Scheduler, Cloud Storage)
- terraform

## どうやっているか

1. terraform を使ってコードを zip 化して Cloud Storage にアップロード
2. terraform から Cloud Scheduler → Pub/Sub → Cloud Functions と実行されるように設定してデプロイ

## やり方

terraform の設定をして `terraform/gcp/variables.tf` の値を変えて実行するだけ
