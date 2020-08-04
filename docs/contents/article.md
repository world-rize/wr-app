# Article
## ArticlesDigest
ホームページ内の記事の概要を表示し、
クリックするとWebView内で記事を表示する

# Model
| field | type | description |
|:--:|:--:|:--:|
| title | String | 記事タイトル |
| thumbnail | Asset | サムネイル |
| summary | String | 本文要旨 |
| url | String | 記事へのURL |
| category | String | カテゴリ(カンマ区切り) |
| tags | String | タグ(カンマ区切り) |

### Contentful JSON Response
```json
{
  "sys": {
    "space": {
      "sys": {
        "type": "Link",
        "linkType": "Space",
        "id": "autgwrydv56l"
      }
    },
    "id": "3nMIBBnGoHWxH8xccdjjo9",
    "type": "Entry",
    "createdAt": "2020-07-12T15:18:30.926Z",
    "updatedAt": "2020-07-12T15:18:30.926Z",
    "environment": {
      "sys": {
        "id": "master",
        "type": "Link",
        "linkType": "Environment"
      }
    },
    "revision": 1,
    "contentType": {
      "sys": {
        "type": "Link",
        "linkType": "ContentType",
        "id": "articleDigest"
      }
    },
    "locale": "en-US"
  },
  "fields": {
    "title": "マレーシアでの学生生活で驚いたこと",
    "thumbnail": {
      "sys": {
        "type": "Link",
        "linkType": "Asset",
        "id": "348pqVt3h9v3u8QycibeTT"
      }
    },
    "summary": "みなさんこんにちは、WorldRIZe編集者のTomoyaです！\n僕は2019年の10月から2020年の3月まで学校のプログラムでマレーシアのマルチメディア大学に留学をしていました。\n\n突然ですがみなさまは海外の大学についてどのようなイメージを持っていますか？\n\nと聞かれても正直イメージ付きませんよね（笑）そこで今回は皆様にマレーシアの学校生活で驚いた点について3つほど紹介していきたいと思います！",
    "category": "article"
  }
},
```