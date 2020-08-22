/**
 * WorldRize API
 * 
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase)
import * as userApi from './user/api'
export const test = functions.https.onCall(userApi.test)
export const login = functions.https.onCall(userApi.login)
export const readUser = functions.https.onCall(userApi.readUser)
export const createUser = functions.https.onCall(userApi.createUser)
export const updateUser = functions.https.onCall(userApi.updateUser)
export const deleteUser = functions.https.onCall(userApi.deleteUser)
export const favoritePhrase = functions.https.onCall(userApi.favoritePhrase)
export const getPoint = functions.https.onCall(userApi.getPoint)
export const doTest = functions.https.onCall(userApi.doTest)
export const createFavoriteList = functions.https.onCall(userApi.createFavoriteList)
export const deleteFavoriteList = functions.https.onCall(userApi.deleteFavoriteList)
export const createPhrasesList = functions.https.onCall(userApi.createPhrasesList)
export const addPhraseToPhraseList = functions.https.onCall(userApi.addPhraseToPhraseList)
export const sendTestResult = functions.https.onCall(userApi.sendTestResult)
