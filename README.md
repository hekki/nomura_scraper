# nomura_scraper
- 野村證券の投資信託用ファンド詳細ページ (ex. [eMAXIS NYダウインデックス](https://advance.quote.nomura.co.jp/meigara/nomura2/qsearch.exe?F=users/nomura/detail2&KEY1=03311138)) をスクレイピングしてslack に通知します
- nomura_scraper は野村證券株式会社と一切関係がない、非公式なプロジェクトです

## Install
### for macOS
- `brew tap homebrew/cask && brew cask install phantomjs`
    - cf. https://github.com/teampoltergeist/poltergeist#mac
- `bundle install -j4 --path vendor/bundle`

## usage
- このプロジェクトは[AWS Lambda](https://aws.amazon.com/jp/lambda/)上で実行することを前提としています

### 1. docker image をビルドする
Lambda にデプロイする前に依存gem をインストールためのdocker image をビルドします

```sh
$ IMAGE_NAME="nomura_scraper"
$ IMAGE_TAG="1.0"

$ docker build -t $IMAGE_NAME:$IMAGE_TAG .
```

### 2. gem のインストールする

```sh
$ docker run -v $(pwd):/app -it $IMAGE_NAME:$IMAGE_TAG /app/build.sh
```

実行後に `nomura_scraper.zip` が生成されます

### 3. AWS Lambda へデプロイする
AWS マネジメントコンソールから、生成されたzip ファイルをデプロイします

### 4.環境変数を設定
以下2つの環境変数を設定してください

| 変数名 | 値 |
| -- | -- |
| NOMURA_KEYS | 野村證券ファンド詳細ページのURLクエリパラメータ `KEY1` の値をカンマ区切りで指定
| SLACK_API_TOKEN | slack のAPI トークン |

## 免責事項
- 当ツールのご利用は利用者の責任において行ってください
- 当ツールの開発者は、当プロジェクトの利用により生じた損害に対する責任を負いません
