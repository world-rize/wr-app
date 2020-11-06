# 開発ガイドライン
## タスク管理
[Github Projects](https://github.com/WorldRIZe/wr-app/projects/2?add_cards_query=is%3Aopen) でカンバン管理することにしました.

## タスクの立て方
テンプレートに沿って書いてください.  
概要は箇条書きで `どこを`, `どうするのか` 記入. 画面名は [client/index](client/index.md) を参考にしてください. 局所的な小さいタスクなら複数画面まとめても大丈夫です.  
[ラベル](https://github.com/WorldRIZe/wr-app/labels) は適宜つけてください.

```md
# ❓ 概要
<!-- タスクの概要, 説明等 -->
- on_boarding > index > sign_in_page
  - パスワード確認フォームを追加
  - バリデーションを設定
- on_bording > index > accent_choice_page
  - サンプルの音声を用意
  - アクセント選択画面を作成

# 📚 参考
<!-- UIプロトタイプのURL, 実装例のURL等 -->
- [仕様書](https://worldrize.github.io/wr-app/spec.pdf)

## 開発ブランチ
### develop
betaリリースに相当する

test flightに出すが、AppStoreには提出できないブランチ

masterにマージするのが目標のブランチ

新しく次のバージョンを出したいときは必ずmasterからブランチを切り直す
- semantic releaseのtagを1つのブランチに統一する必要があるため

### master
AppStoreに提出できるブランチ
TestFlightで確認を取れたら、developブランチからマージできる


## 開発フロー
1. アサインされているIssueに対してカンバンを `[In Progress]` に移動
2. `develop`から`features/<issue number>` でブランチを切りそこで開発
3. `develop`にPRを送り、Mergeする
4. githubの`tag`を振りたければ、github actionのトリガーをUIから走らせる
5. AppStoreに提出できるようになったら、masterにマージ