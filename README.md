# nomura_scraper
- 野村證券の投資信託用ファンド詳細ページ (ex. [eMAXIS NYダウインデックス](https://advance.quote.nomura.co.jp/meigara/nomura2/qsearch.exe?F=users/nomura/detail2&KEY1=03311138)) をスクレイピングしてslack に通知します
- nomura_scraper は野村證券株式会社と一切関係がない、非公式なプロジェクトです

## Install
### for macOS
- `brew tap homebrew/cask && brew cask install phantomjs`
    - cf. https://github.com/teampoltergeist/poltergeist#mac
- `bundle install -j4 --path vendor/bundle`

## usage
### set env
```bash
$ export NOMURA_KEYS '01234567,01234568'
$ export SLACK_API_TOKEN 'xxxxxxxxxxxxxxxxxxx'
```

### execute
```bash
$ ruby nomura_scraper.rb
```

## 免責事項
- 当ツールのご利用は利用者の責任において行ってください
- 当ツールの開発者は、当プロジェクトの利用により生じた損害に対する責任を負いません
