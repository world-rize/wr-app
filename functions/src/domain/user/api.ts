/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { UserService } from './userService'
import { UserRepository } from './userRepository'
import * as functions from 'firebase-functions'
import * as Dto from './model/userApiDto'

// onCall() has varify firebase tokens unlike onRequest()

type Context = functions.https.CallableContext
const userRepo = new UserRepository()
const userService = new UserService(userRepo)

/**
 *  デバッグ用
 */
export const test = async (req: Dto.TestRequest, context: Context): Promise<Dto.TestResponse> => {
  console.log(`[test] done`)

  return {
    success: true
  }
}

/**
 *  ユーザーを取得します
 */
export const readUser = async (req: Dto.ReadUserRequest, context: Context): Promise<Dto.ReadUserResponse> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }

  const uid = context.auth.uid
  const user = await userService.readUser(uid)
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
}

/**
 *  ユーザーを作成します
 *  TODO: functions側でユーザー作成?
 */
export const createUser = async (req: Dto.CreateUserRequest, context: Context): Promise<Dto.CreateUserResponse> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }

  console.log(`[createUser] uid: ${req.uuid}`)

  if (await userService.existUser(req.uuid)) {
    console.error('user already exist')
    throw new functions.https.HttpsError('already-exists', 'user already exist')
  }

  const user = await userService.createUser(req)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to create user')
    })

  console.log(`[createUser] uid: ${req.uuid} user created`)

  return { user }
}

/**
 * 
 */
export const favoritePhrase = async (data: Dto.FavoritePhraseRequest, context: Context): Promise<Dto.FavoritePhraseResponse> => {
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

  const success = await userService.favoritePhrase(uid, phraseId, value)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to favorite phrase')
    })

  console.log(`[favoritePhrase] favorited uid: ${uid}, phraseId: ${phraseId}, value: ${value}`)

  return {
    success
  }
}
/**
 * ユーザーがポイントを獲得
 */
export const getPoint = async (req: Dto.GetPointRequest, context: Context): Promise<Dto.GetPointResponse> => {
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

  const success = await userService.getPoint(uid, point)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to get point')
    })

  console.log(`[getPoint] getPoint uid: ${uid}, point: ${point}`)

  return {
    success
  }
}

/**
 *  テストを受ける(TODO)
 */
export const doTest = async (req: Dto.DoTestRequest, context: Context): Promise<Dto.DoTestResponse> => {
  return {}
}