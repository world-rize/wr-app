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

## views hierarchy
### Root(共通?)
- RootView [/ui/app.dart]
    - ヘッダ
        - 検索バー
            - [PhraseSearchResultView](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469130) `/ui/lesson/phrase_search_result_page.dart`
        - 設定ボタン
    - ボディ
        1. レッスン [LessonView]
        2. コラム [ColumnView]
        3. 旅行 [TravelView]
        4. 留学先紹介 [AgencyView]
        5. マイページ [MyPageView]
    - フッタ
    
### レッスン
- [LessonView](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469131) `/ui/lesson/lesson_page.dart`
    - Lessonセクション
        - Lessonタブ&Testタブ [SectionSelectModal](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469132) `/ui/lesson/section_select_modal.dart`
            - Lessonタブ
                - [LessonPhraseListModal](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469133) `/ui/lesson/phrase_list_modal.dart`
                    - [PhraseDetailView](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134) `/ui/lesson/phrase_detail_page.dart`
            - Testタブ
                1. テスト [TestView](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469139) `/ui/lesson/phrase_test_page.dart`
                2. 結果 [TestResultView](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469140) `/ui/lesson/phrase_test_result_page.dart`
                    - ポップアップ(ピースゲット)
    - Favoriteセクション
        - PhraseItem(一つだけ表示?)
        - Favorite一覧(どうやって遷移?) [FavoritePhraseListModal](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469136) `/ui/lesson/favorite_phrase_list_modal.dart`
    - New coming phrasesセクション
        - PhraseItem(一つだけ表示?)
        - New coming phrases(どうやって遷移?) [NewPhraseListModal](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469129) `/ui/lesson/new_phrase_list_modal.dart`
    - Requestセクション
        - `フレーズをリクエストする` ボタン
            - [PhraseRequestView](https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469128) `/ui/lesson/phrase_request_page.dart`

### コラム
- [ColumnView]() `/ui/column/column_page.dart`

### 旅行
- [TravelView]() `/ui/travel/travel_page.dart`

### 留学先紹介
- [AgencyView]() `/ui/agency/agency_page.dart`

### マイページ
- [MyPageView]() `/ui/mypage/mypage_page.dart`

# 備考
- Firebase使えばアカウント管理&DB手軽にできる?
- ContentfulとかのHeadless CMS使えばコンテンツ管理できそう?それかFirebase Storage
- 音声配信は?()

# 参考文献
## アーキテクチャ参考
- [droidkaigi2018-flutter](https://github.com/konifar/droidkaigi2018-flutter)
## UI
- [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)
## ライブラリ
- [flutter-swiper](https://pub.dev/packages/flutter_swiper#pagination)
## その他
- [Flutterでオリジナルアイコンを使う方法](https://qiita.com/pepix/items/751e077ccace4bd43d2f)
