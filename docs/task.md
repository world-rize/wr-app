# ✔ 開発
## 💻 環境

- git/GitHub
    - [Sourcetree](https://www.sourcetreeapp.com/)使うと楽かも
- Android Studio v3+
- Xcode 11.0

## ✎ Tips
### コンポーネント
GetFlutterを使用しているのでコンポーネントに困ったら
[Getflutter | Docs](https://docs.getflutter.dev/) を見るといいかも

### ファイル/ディレクトリ構成
- 各ページはフォルダの直下に作る

### ファイル
- **Doc Commentを書こう**
  - `///` で始まるコメント
  - <https://dart.dev/guides/language/effective-dart/documentation>
- **構造の大きい順にクラスを宣言すると見やすい**
  - なるべくページの親子関係がわかるようにする
- 最初に表示されるページは `index.dart`
- それ以外は `xxx_page.dart` とする

### ウィジェット
- ウィジェットはフォルダの`widgets/`フォルダ以下に作る
  - 複数箇所で使う可能性のある `Widget` のため
  - `build()` 関数をなるべく短くするため
- `Placeholder()` はページの概形を作れて便利

### ストア(WIP)
- [Provider](https://pub.dev/packages/provider) を使用しています
- <https://qiita.com/kabochapo/items/a90d8438243c27e2f6d9>
- RootView に UserData をもたせています(TODO: 複数ストア)

### Firebaseセットアップ
1. `pubspec.yaml` を開き `Packages get` または `$ flutter pub get`
2. [worldwize - firebase](https://console.firebase.google.com/u/0/project/worldrize-9248e/settings/general/ios:com.worldrize.wrApp) の `マイアプリ` から `GoogleService-Info.plist` をダウンロード
3. `$ open ios/Runner.xcworkspace` で Xcodeを開き `Runner/Flutter/Runner` にplistファイルを移動
4. ビルドして匿名ログインが出来ているか確認

### タスクランナー
`json_annotation` などのコード生成をしたい時は

```bash
$ flutter pub run build_runner build
```

### i18n
`lib/i10n` 以下にi18n用のファイル等があります。コード生成は

```bash
$ sh update_i10n.sh
```

を実行

### アセット生成
フレーズJSON等の生成はGoogleドライブから `.txt でエクスポートしたものを `assets/phrases.txt` に置き、

```bash
$ python scripts/convertor.py
```

で `/assets` 以下に展開されます

### 音声データ
naturalreaders からダウンロードしてきた zip を適切な場所に置き、

```bash
$ python scripts/rename.py
```

を実行するとmp3ファイルが展開されます。


### スプラッシュ画像生成
```bash
$ flutter pub pub run flutter_native_splash:create
```

### アプリアイコン生成
`assets/icon/icon.jpg` がある状態で

```bash
$ flutter packages pub run flutter_launcher_icons:main
```

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
