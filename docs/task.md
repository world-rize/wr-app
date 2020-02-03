# ✔ 開発
## 💻 環境

- git/GitHub
    - [Sourcetree](https://www.sourcetreeapp.com/)使うと楽かも
- Android Studio v3+

## ✎ 方針
Flutterを書いて思った所感やTipsを雑に列挙します。

- ページは各フォルダの直下に作る
    - 最初に表示されるページは `index.dart`
    - それ以外は `xxx_page.dart` とする
    - なるべくページの親子関係がわかるようにする
- ウィジェットはフォルダの`widgets/`フォルダ以下に作る
    - 複数箇所で使う可能性のある `Widget` のため
    - `build()` 関数はなるべく短くするため
    - まずは標準ウィジェットの組み合わせで実現できないか考える
    - なるべく `StatelessWidget` を使うように
    - とりあえず `Placeholder()` で大体のワイヤーフレームを作る
    - なるべく `Widget` を返す関数を作ってコンポーネント化をすすめる

## 👓 タスク
作業をタスクに分けて割り振りをして開発を進めていきます。

### 1. タスクが振られる
![](https://i.imgur.com/LbpD3sn.png)
自分担当のタスクが振られていたら `feature/{任意の名前}` または `feature/2` (Issues番号) で master ブランチからチェックアウトする

```bash
git checkout -b feature/2
```

### 2. 実装する
Web上の記事(Qiita等)や公式ドキュメント, GitHubリポジトリが参考になります。  
行き詰まったりしたらLINEやSlackで質問を飛ばすのもありです。

### 3. プルリクエスト(PR)を送る
GitHubのリポジトリページから `Pull Requests` タブへ移動し `New pull request` ボタンをクリック

![](https://i.imgur.com/e96MbDc.png)

ここでマージが出来ない旨のメッセージが出た場合はソースコードのコンフリクトが起こっているので逆に `master` から自分のブランチにマージしてコンフリクトを解消して再コミットしましょう

### 4. レビュー
こうしたほうがいい等のアドバイスをします。それを元に修正してください。
