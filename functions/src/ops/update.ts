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

const updateAppInfo = async () => {
  const firestore = admin.firestore()
  const appInfo: WRAppInfo = {
    currentVersion: '0.6.2',
    requireVersion: '0.6.2',
    isAndroidAppAvailable: false,
    isIOsAppAvailable: false,
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
  usePrd()
  // useStg()
  await updateShop()
  await updateAppInfo()
}

updateVersion()