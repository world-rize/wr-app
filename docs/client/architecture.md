# アーキテクチャ
`レイヤードアーキテクチャ` もどきです.  
ページ, ロジック, モデルを明確に分けています.  
画面は `notifier`, `pages`, `widgets` に分けています.   
```bash
├── notifier # notifier
├── pages # ページ
└── widgets # 固有のウィジェット
```
余裕があったら `Atomic Design` ぽくしたい.

## フォルダ構成
```bash
$ tree -d
.
├── domain # ドメイン層
│   ├── article
│   │   └── model
│   ├── auth
│   ├── lesson
│   │   └── model
│   ├── system
│   │   └── model
│   └── user
│       └── model
├── i10n
├── infrastructure # インフラストラクチャ層
│   ├── article
│   ├── auth
│   ├── lesson
│   ├── system
│   └── user
├── presentation # プレゼンテーション層
│   ├── agency
│   ├── article
│   │   ├── notifier # notifier
│   │   ├── pages # ページ
│   │   └── widgets # 固有のウィジェット
│   ├── lesson
│   │   ├── notifier
│   │   ├── pages
│   │   └── widgets
│   ├── mypage
│   │   ├── pages
│   │   └── widgets
│   ├── on_boarding
│   │   ├── notifier
│   │   ├── pages
│   │   └── widgets
│   ├── settings
│   │   ├── pages
│   │   │   └── account_settings
│   │   └── widgets
│   └── travel
├── ui # 再利用可能なUIコンポーネント
│   └── widgets
├── usecase # ユースケース
└── util # ユーティリティ
    └── extensions
```

### 参考
- 今すぐ「レイヤードアーキテクチャ+DDD」を理解しよう。（golang） <https://qiita.com/tono-maron/items/345c433b86f74d314c8d>
- Dart/Flutterでドメイン駆動設計（DDD）してみた - 導入編 <https://kabochapo.hateblo.jp/entry/2019/11/01/195130>