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

```

## ブランチモデル(WIP)
`git-flow` likeなはず.

![](https://image.itmedia.co.jp/ait/articles/1708/01/at-it-git-15-001.jpg)

```bash
# 環境ブランチ(CI/CD走る)
- release # 開発環境, チーム内のアプリ確認用
- master # 本番環境, リリース

# 開発ブランチ
- develop # 開発中
- feature/xxx # 機能
```

## 開発フロー
1. アサインされているIssueに対してカンバンを `[In Progress]` に移動
2. `features/<issue number>` でブランチを切りそこで開発
3. PRを送る(できればコードレビューとかしたい)
4. Merged