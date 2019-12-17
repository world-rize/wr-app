# wr_app

[タスクの作成](https://github.com/WorldRIZe/wr-app/issues/new?assignees=&labels=&template=---.md&title=)

# 開発の進め方
## 備考
[`Sourcetree`](https://www.sourcetreeapp.com/)使うと楽かも

## 1. タスクが振られる
![](https://i.imgur.com/LbpD3sn.png)
自分担当のタスクが振られていたら `feature/{任意の名前}` または `feature/2` (Issues番号) で master ブランチからチェックアウトする

```bash
git checkout -b feature/2
```

## 2. 実装する

## 3. プルリクエスト(PR)を送る
GitHubのリポジトリページから `Pull Requests` タブへ移動し `New pull request` ボタンをクリック

![](https://i.imgur.com/e96MbDc.png)

ここでマージが出来ない旨のメッセージが出た場合はソースコードのコンフリクトが起こっているので逆に `master` から自分のブランチにマージしてコンフリクトを解消して再コミットしましょう

## 4. レビューをまつ