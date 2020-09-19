/**
 * WorldRize API
 *
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase)
import * as userApi from './user/api'

export const getAppInfo = functions.region('asia-northeast1').https.onCall(userApi.getAppInfo)
export const test = functions.region('asia-northeast1').https.onCall(userApi.test)
export const login = functions.region('asia-northeast1').https.onCall(userApi.login)
export const readUser = functions.region('asia-northeast1').https.onCall(userApi.readUser)
export const createUser = functions.region('asia-northeast1').https.onCall(userApi.createUser)
export const updateUser = functions.region('asia-northeast1').https.onCall(userApi.updateUser)
export const deleteUser = functions.region('asia-northeast1').https.onCall(userApi.deleteUser)
export const favoritePhrase = functions.region('asia-northeast1').https.onCall(userApi.favoritePhrase)
export const getPoint = functions.region('asia-northeast1').https.onCall(userApi.getPoint)
export const doTest = functions.region('asia-northeast1').https.onCall(userApi.doTest)
export const checkTestStreaks = functions.region('asia-northeast1').https.onCall(userApi.checkTestStreaks)
export const findUserByUserId = functions.region('asia-northeast1').https.onCall(userApi.findUserByUserId)

export const createFavoriteList = functions.region('asia-northeast1').https.onCall(userApi.createFavoriteList)
export const deleteFavoriteList = functions.region('asia-northeast1').https.onCall(userApi.deleteFavoriteList)

export const sendTestResult = functions.region('asia-northeast1').https.onCall(userApi.sendTestResult)

export const introduceFriend = functions.region('asia-northeast1').https.onCall(userApi.introduceFriend)
export const getShopItems = functions.region('asia-northeast1').https.onCall(userApi.getShopItems)

// note api
export const createNote = functions.region('asia-northeast1').https.onCall(userApi.createNote)
export const updateNote = functions.region('asia-northeast1').https.onCall(userApi.updateNote)
export const deleteNote = functions.region('asia-northeast1').https.onCall(userApi.deleteNote)
