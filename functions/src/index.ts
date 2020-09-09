/**
 * WorldRize API
 *
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase)
import * as userApi from './user/api'

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

export const createFavoriteList = functions.region('asia-northeast1').https.onCall(userApi.createFavoriteList)
export const deleteFavoriteList = functions.region('asia-northeast1').https.onCall(userApi.deleteFavoriteList)

export const sendTestResult = functions.region('asia-northeast1').https.onCall(userApi.sendTestResult)

// note api
export const createNote = functions.region('asia-northeast1').https.onCall(userApi.createNote)
export const updateNoteTitle = functions.region('asia-northeast1').https.onCall(userApi.updateNoteTitle)
export const updateDefaultNote = functions.region('asia-northeast1').https.onCall(userApi.updateDefaultNote)
export const deleteNote = functions.region('asia-northeast1').https.onCall(userApi.deleteNote)
export const addPhraseInNote = functions.region('asia-northeast1').https.onCall(userApi.addPhraseInNote)
export const updatePhraseInNote = functions.region('asia-northeast1').https.onCall(userApi.updatePhraseInNote)
export const deletePhraseInNote = functions.region('asia-northeast1').https.onCall(userApi.deletePhraseInNote)
export const achievePhraseInNote = functions.region('asia-northeast1').https.onCall(userApi.achievePhraseInNote)
