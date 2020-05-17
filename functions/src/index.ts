/**
 * WorldRize API
 * 
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase)

import { UserService } from './user/service'
import { User } from './user/model'

// TODO: request object validation
// TODO: certification
// TODO: logging
// TODO: testing

// onCall() has varify firebase tokens unlike onRequest()

interface TestRequest {}

interface TestResponse {
  success: boolean
}

/**
 *  デバッグ用
 */
export const test = functions.https.onCall((data: TestRequest, context): TestResponse => {
  console.log(`[test] done`)

  return {
    success: true
  }
})

interface ReadUserRequest {}
interface ReadUserResponse {
  user: User
}

/**
 *  ユーザーを取得します
 */
export const readUser = functions.https.onCall(async (data: ReadUserRequest, context): Promise<ReadUserResponse> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }

  const uid = context.auth.uid
  const user = await UserService.readUser(uid)
    .catch(e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', e)
    })

  console.log(`[readUser] done`)

  if (!user) {
    console.error('user not found')
    throw new functions.https.HttpsError('not-found', 'user not found')
  }

  console.log(`[readUser] done`)

  return { user }
})

export interface CreateUserRequest {
  uuid: string
  name: string
  userId: string
  email: string
  age: string
}

interface CreateUserResponse {
  user: User
}

/**
 *  ユーザーを作成します
 */
export const createUser = functions.https.onCall(async (req: CreateUserRequest, context): Promise<CreateUserResponse> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }

  console.log(`[createUser] uid: ${req.uuid}`)

  if (await UserService.existUser(req.uuid)) {
    console.error('user already exist')
    throw new functions.https.HttpsError('already-exists', 'user already exist')
  }

  const user = await UserService.createUser(req)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to create user')
    })

  console.log(`[createUser] uid: ${req.uuid} user created`)

  return { user }
})

interface FavoritePhraseRequest {
  phraseId: string
  value: boolean
}

interface FavoritePhraseResponse {
  success: boolean
}

/**
 * 
 */
export const favoritePhrase = functions.https.onCall(async (data: FavoritePhraseRequest, context): Promise<FavoritePhraseResponse> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }
  const uid = context.auth.uid
  const phraseId: string = data.phraseId
  const value: boolean = data.value

  console.log(`[favoritePhrase] uid: ${uid}, phraseId: ${phraseId}, value: ${value}`)

  if (!phraseId || value === null) {
    console.error('phraseId or value is invalid')
    throw new functions.https.HttpsError('invalid-argument', 'phraseId or value is invalid')
  }

  const success = await UserService.favoritePhrase(uid, phraseId, value)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to favorite phrase')
    })

  console.log(`[favoritePhrase] favorited uid: ${uid}, phraseId: ${phraseId}, value: ${value}`)

  return {
    success
  }
})

interface GetPointRequest {
  uuid: string
  point: number
}

interface GetPointResponse {
  success: boolean
}

/**
 * ユーザーがポイントを獲得
 */
export const getPoint = functions.https.onCall(async (req: GetPointRequest, context): Promise<GetPointResponse> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }

  const uid = context.auth.uid
  const point = req.point

  console.log(`[getPoint] uid: ${uid}, point: ${point}`)

  if (!point || Number.isNaN(point)) {
    console.error('point is invalid')
    throw new functions.https.HttpsError('invalid-argument', 'point is invalid')
  }

  const success = await UserService.getPoint(uid, point)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to get point')
    })

  console.log(`[getPoint] getPoint uid: ${uid}, point: ${point}`)

  return {
    success
  }
})

/**
 *  テストを受ける(TODO)
 */
interface DoTestRequest {}

interface DoTestResponse {}
export const doTest = functions.https.onCall(async (req: DoTestRequest, context): Promise<DoTestResponse> => {
  return {}
})