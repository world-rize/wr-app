# Phrases
## Overview
- ローカルに音声(mp3)とフレーズ(json)が保存されている.  
- 15のLessonがあり、各レッスンはPhraseのリストをもつ.  
- Sectionは1画面に表示するPhraseのリスト
- 各フレーズはに会話例やアドバイス, 音声へのパスが含まれる

## 元データ
- `#` 区切りでそれぞれのレッスンに複数のフレーズが入っている

```md
# Business English
1.
 Do you want me to stack the shelves?
棚に品物を積んだ方がいいですか？
That would be good, but (I’ll check with the boss) to see if that’s okay.
助けるけど、大丈夫か(一回上司に確認してみますね)
Thank you!
ありがとうございます！


“check with A”（Aは人）で「Aに確認してみる, 許可を取る」という意味になります。

# School
1.
Have you finished the English homework yet?
英語の宿題終わった？
No I haven’t. (When is the homework due?)
いや、終わってないよ。（いつ宿題提出するんだっけ？）
It’s due next Tuesday.
次の火曜日だよ


“due”は「支払い期限のきた~」や「 満期の~」といった意味を持ちます。よって、”When is ~ due?”で「~の期限はいつだっけ？」となり、”When is the homework due?”を意訳すると「いつ宿題提出するんだっけ？」となります。

```

### 変換
元データからjsonへの変換はCLIで

```bash
python scripts worldrize.py phrases
```

## Lesson
### Model
タイトルはi18n対応のためMap.  
`title['ja']` に日本語のタイトルが入っている.

#### assets/lessons.json
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

### Lesson model
```dart
@JsonSerializable()
class Lesson {
  /// タイトル
  Map<String, String> title;
  /// フレーズ
  List<Phrase> phrases;
  /// assets
  Assets assets;
}
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

#### assets/phrases.json
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

### Phrase model

```dart
@JsonSerializable()
class Phrase {
  String id;
  Map<String, String> title;
  Assets assets;
  Map<String, String> meta;
  Map<String, String> advice;
  Example example;
}
```

### Example model
フレーズの会話例

```dart
@JsonSerializable()
class Example {
  List<Message> value;
}
```

### Message model
```dart
@JsonSerializable()
class Message {
  Map<String, String> text;
  Assets assets;
}
```

### Assets model
```dart
@JsonSerializable()
class Assets {
  // 音声素材
  Map<String, String> voice;
  // 画像素材
  Map<String, String> img;
}

```

## Section
アプリ内でフレーズのまとまりはSectionで保持されている.
`List<Section> Section.fromLesson(Lesson lesson)` でレッスンからSectionを切り出せる.

```dart
class Section {
  final String title;
  final List<Phrase> phrases;
}
```

## 音声
Text to Speech APIでフレーズを予めmp3にしたものをローカルに配置しておく(TODO: リモートに置く?)
フレーズから音声の生成はCLIで(既に生成済みの場合は生成されない)
(TODO: フレーズが修正された時に検知できるようにhashしたい)

```bash
python scripts/worldrize.py voices
```
