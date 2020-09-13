import * as admin from 'firebase-admin'
import { GiftItem } from './user/model/item'
const colors = require('colors')

admin.initializeApp({
  projectId: 'wr-english-dev',
  credential: admin.credential.applicationDefault()
})

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

const updateShop = async () => {
  const firestore = admin.firestore()
  const shop = firestore.collection('shop')
  for (const item of items) {
    await shop.doc(item.id).set(item)
  }
}

updateShop()