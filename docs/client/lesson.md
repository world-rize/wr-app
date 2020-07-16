# Lesson Contents
## Overview
- ローカルに音声(mp3)とフレーズ(json)が保存されている.  
- 15のLessonがあり、各レッスンはPhraseのリストをもつ.  
- Sectionは1画面に表示するPhraseのリスト
- 各フレーズはに会話例やアドバイス, 音声へのパスが含まれる

## Lesson
### Model
タイトルはi18n対応のためMap.  
`title['ja']` に日本語のタイトルが入っている.

```dart
/// タイトル
Map<String, String> title;
/// フレーズ
List<Phrase> phrases;
/// assets
Assets assets;
```

### Json
## assets/lessons.json
```json
[
  {
    "id": "business",
    "title": {
      "en": "Business English",
      "ja": "Business English"
    },
    "assets": {
      "img": {
        "thumbnail": "assets/thumbnails/business.png"
      }
    }
  },
  ...
]
```

## Phrase
idは `{lesson_id}_{phrase_id}` のように.
各フレーズはキーフレーズ, 会話例(3つ)を持ちそれぞれに発音の差分があるので12つの音声が存在.
パスは `voice/{lesson_id}_{phrase_id}_{1-3|kp}_{locale}.mp3` となる

```
voice/business_1_kp_en-us.mp3
voice/business_1_kp_en-uk.mp3
voice/business_1_kp_en-au.mp3

voice/business_1_1_en-us.mp3
voice/business_1_1_en-uk.mp3
voice/business_1_1_en-au.mp3

voice/business_1_2_en-us.mp3
voice/business_1_2_en-uk.mp3
voice/business_1_2_en-au.mp3

voice/business_1_3_en-us.mp3
voice/business_1_3_en-uk.mp3
voice/business_1_3_en-au.mp3
```

### assets/phrases.json
```json
[
  {
    "id": "0001",
    "title": {
      "en": "I’ll check with the boss",
      "ja": "一回上司に確認してみますね"
    },
    "meta": {
      "lessonId": "business",
      "phraseId": "1"
    },
    "assets": {
      "voice": {
        "en-us": "voice/business_1_kp_en-us.mp3",
        "en-au": "voice/business_1_kp_en-au.mp3",
        "en-uk": "voice/business_1_kp_en-uk.mp3"
      }
    },
    "advice": {
      "ja": "“check with A”（Aは人）で「Aに確認してみる, 許可を取る」という意味になります。"
    },
    "example": {
      "value": [
        {
          "text": {
            "en": "Do you want me to stack the shelves?",
            "ja": "棚に品物を積んだ方がいいですか？"
          },
          "assets": {
            "voice": {
              "en-us": "voice/business_1_1_en-us.mp3",
              "en-au": "voice/business_1_1_en-au.mp3",
              "en-uk": "voice/business_1_1_en-uk.mp3"
            }
          }
        },
        {
          "text": {
            "en": "That would be good, but (I’ll check with the boss) to see if that’s okay.",
            "ja": "助けるけど、大丈夫か(一回上司に確認してみますね)"
          },
          "assets": {
            "voice": {
              "en-us": "voice/business_1_2_en-us.mp3",
              "en-au": "voice/business_1_2_en-au.mp3",
              "en-uk": "voice/business_1_2_en-uk.mp3"
            }
          }
        },
        {
          "text": {
            "en": "Thank you!",
            "ja": "ありがとうございます！"
          },
          "assets": {
            "voice": {
              "en-us": "voice/business_1_3_en-us.mp3",
              "en-au": "voice/business_1_3_en-au.mp3",
              "en-uk": "voice/business_1_3_en-uk.mp3"
            }
          }
        }
      ]
    }
  },
```