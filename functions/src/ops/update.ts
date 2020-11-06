/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as admin from 'firebase-admin'
import { WRAppInfo } from './model/appinfo'
import { GiftItem } from '../user/model/item'

/**
 * ショップのデータ
 */
const items: GiftItem[] = [
  {
    id: 'amazon',
    title: 'Amazonカード 500ポイント',
    description: 'Amazonで使えるギフトカード',
    price: 5000,
    expendable: true,
  },
  {
    id: 'itunes',
    title: 'iTunesカード 500ポイント',
    description: 'iTunesで使えるギフトカード',
    price: 5000,
    expendable: true,
  },
  {
    id: 'extra_note',
    title: 'ノート追加',
    description: 'ノートの追加',
    price: 2500,
    expendable: true,
  },
  {
    id: 'accent_us',
    title: 'フレーズアクセント(US)',
    description: 'USアクセント',
    price: 2500,
    expendable: false,
  },
  {
    id: 'accent_au',
    title: 'フレーズアクセント(AU)',
    description: 'AUアクセント',
    price: 2500,
    expendable: false,
  },
  {
    id: 'accent_uk',
    title: 'フレーズアクセント(UK)',
    description: 'UKアクセント',
    price: 2500,
    expendable: false,
  },
  {
    id: 'accent_in',
    title: 'フレーズアクセント(IN)',
    description: 'INアクセント',
    price: 2500,
    expendable: false, 
  },
]

const updateNewComingPhrase = async () => {
  const phrases = [
    {
      "id": "greeting_1",
      "title": {
        "en": "What have you been up to? ",
        "ja": "最近どうしてるの？"
      },
      "meta": {
        "lessonId": "greeting",
        "phraseId": "1"
      },
      "assets": {
        "voice": {
          "en-us": "voices/greeting_1_kp_en-us.mp3",
          "en-au": "voices/greeting_1_kp_en-au.mp3",
          "en-uk": "voices/greeting_1_kp_en-uk.mp3",
          "en-in": "voices/greeting_1_kp_en-in.mp3"
        }
      },
      "advice": {
        "ja": "最近の調子を聞く時にはよく”what have you been up to?”が使われます。「最近どうしてるの？」という日本語で理解できます。"
      },
      "example": {
        "value": [
          {
            "text": {
              "en": "It’s been ages since I last saw you!",
              "ja": "最後に会ってから随分経つね"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_1_1_en-us.mp3",
                "en-au": "voices/greeting_1_1_en-au.mp3",
                "en-uk": "voices/greeting_1_1_en-uk.mp3",
                "en-in": "voices/greeting_1_1_en-in.mp3"
              }
            }
          },
          {
            "text": {
              "en": "I know! （What have you been up to? ）",
              "ja": "そうだね！（最近どうしてるの？）"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_1_2_en-us.mp3",
                "en-au": "voices/greeting_1_2_en-au.mp3",
                "en-uk": "voices/greeting_1_2_en-uk.mp3",
                "en-in": "voices/greeting_1_2_en-in.mp3"
              }
            }
          },
          {
            "text": {
              "en": "Well, I got a new job and I bought a new car as well.",
              "ja": "新しい仕事を見つけて車も買ったよ！"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_1_3_en-us.mp3",
                "en-au": "voices/greeting_1_3_en-au.mp3",
                "en-uk": "voices/greeting_1_3_en-uk.mp3",
                "en-in": "voices/greeting_1_3_en-in.mp3"
              }
            }
          }
        ]
      }
    },
    {
      "id": "greeting_2",
      "title": {
        "en": "It’s good to see you!",
        "ja": "会えて嬉しいよ！"
      },
      "meta": {
        "lessonId": "greeting",
        "phraseId": "2"
      },
      "assets": {
        "voice": {
          "en-us": "voices/greeting_2_kp_en-us.mp3",
          "en-au": "voices/greeting_2_kp_en-au.mp3",
          "en-uk": "voices/greeting_2_kp_en-uk.mp3",
          "en-in": "voices/greeting_2_kp_en-in.mp3"
        }
      },
      "advice": {
        "ja": "“nice to meet you”だけが人に会ったときに使われるフレーズではありません。”it's good to see you”も「お会いできて嬉しいです」という意味で使われます。"
      },
      "example": {
        "value": [
          {
            "text": {
              "en": "Hey Emma! It’s been ages since I last saw you.",
              "ja": "エマ！最後に会ってから随分経つね。"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_2_1_en-us.mp3",
                "en-au": "voices/greeting_2_1_en-au.mp3",
                "en-uk": "voices/greeting_2_1_en-uk.mp3",
                "en-in": "voices/greeting_2_1_en-in.mp3"
              }
            }
          },
          {
            "text": {
              "en": "Hey Yuta! （It’s good to see you!）",
              "ja": "やぁゆうた！（会えて嬉しいよ！）"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_2_2_en-us.mp3",
                "en-au": "voices/greeting_2_2_en-au.mp3",
                "en-uk": "voices/greeting_2_2_en-uk.mp3",
                "en-in": "voices/greeting_2_2_en-in.mp3"
              }
            }
          },
          {
            "text": {
              "en": "You too!",
              "ja": "僕もだよ！"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_2_3_en-us.mp3",
                "en-au": "voices/greeting_2_3_en-au.mp3",
                "en-uk": "voices/greeting_2_3_en-uk.mp3",
                "en-in": "voices/greeting_2_3_en-in.mp3"
              }
            }
          }
        ]
      }
    },
    {
      "id": "greeting_3",
      "title": {
        "en": "You look good!",
        "ja": "元気そうだね！"
      },
      "meta": {
        "lessonId": "greeting",
        "phraseId": "3"
      },
      "assets": {
        "voice": {
          "en-us": "voices/greeting_3_kp_en-us.mp3",
          "en-au": "voices/greeting_3_kp_en-au.mp3",
          "en-uk": "voices/greeting_3_kp_en-uk.mp3",
          "en-in": "voices/greeting_3_kp_en-in.mp3"
        }
      },
      "advice": {
        "ja": "\"you look good\"にはいくつかの意味があります。１つはこの例で使われている「元気そうだね」という意味です。また、良い物を身につけていた時などに使われる「見栄えが良い」という意味です。また、「顔の美しさ」などを褒める時に使われます。"
      },
      "example": {
        "value": [
          {
            "text": {
              "en": "It’s been ages since I last saw you, how have you been?",
              "ja": "最後に会ってから随分経つね。元気にしてた？"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_3_1_en-us.mp3",
                "en-au": "voices/greeting_3_1_en-au.mp3",
                "en-uk": "voices/greeting_3_1_en-uk.mp3",
                "en-in": "voices/greeting_3_1_en-in.mp3"
              }
            }
          },
          {
            "text": {
              "en": "I’ve been great, thanks. What about you? (You look good!)",
              "ja": "元気だったよ。ゆうたはどう？（元気そうだね！）"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_3_2_en-us.mp3",
                "en-au": "voices/greeting_3_2_en-au.mp3",
                "en-uk": "voices/greeting_3_2_en-uk.mp3",
                "en-in": "voices/greeting_3_2_en-in.mp3"
              }
            }
          },
          {
            "text": {
              "en": "Thanks! I’ve been doing really well too.",
              "ja": "ありがとう！僕もすごく元気だよ"
            },
            "assets": {
              "voice": {
                "en-us": "voices/greeting_3_3_en-us.mp3",
                "en-au": "voices/greeting_3_3_en-au.mp3",
                "en-uk": "voices/greeting_3_3_en-uk.mp3",
                "en-in": "voices/greeting_3_3_en-in.mp3"
              }
            }
          }
        ]
      }
    },
  ]

  const firestore = admin.firestore()
  const shop = firestore.collection('newcoming')
  for (const phrase of phrases) {
    await shop.doc(phrase['id']).set(phrase)
  }
}

const updateShop = async () => {
  const firestore = admin.firestore()
  const shop = firestore.collection('shop')
  for (const item of items) {
    await shop.doc(item.id).set(item)
  }
}

const updateAppInfo = async () => {
  const firestore = admin.firestore()
  const appInfo: WRAppInfo = {
    currentVersion: '0.6.4',
    requireVersion: '0.6.4',
    isAndroidAppAvailable: true,
    isIOsAppAvailable: true,
  }
  await firestore.collection('etc').doc('appinfo').set(appInfo)
}

export const useStg = () => {
  admin.initializeApp({
    projectId: 'wr-english-dev',
    credential: admin.credential.applicationDefault()
  })
}

export const usePrd = () => {
  admin.initializeApp({
    projectId: 'wr-english-prd',
    credential: admin.credential.applicationDefault()
  })
}

const updateVersion = async () => {
  // dev environment
  // usePrd()
  useStg()
  await updateShop()
  await updateAppInfo()
  await updateNewComingPhrase()
}

updateVersion()