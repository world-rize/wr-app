/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as firebase from 'firebase-admin'
import { validate } from 'class-validator'
import { UserService } from './userService'
import { UserRepository } from './userRepository'
import * as functions from 'firebase-functions'
import * as Dto from './model/userApiDto'

// onCall() has varify firebase tokens unlike onRequest()

type Context = functions.https.CallableContext
const userRepo = new UserRepository()
const userService = new UserService(userRepo)

const authorize = async (context: Context): Promise<string> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }
  return context.auth.uid
}



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
  const uid = await authorize(context)
  const user = await userService.readUser(uid)

  if (!user) {
    console.error('user not found')
    throw new functions.https.HttpsError('not-found', 'user not found')
  }

  console.log(`[readUser] done`)

  return { user }
}

/**
 *  ユーザーを作成します
 */
export const createUser = async (req: Dto.CreateUserRequest, context: Context): Promise<Dto.CreateUserResponse> => {
  const uid = await authorize(context)
  console.log(`[createUser] uid: ${uid}`)

  // object -> class instance
  req = Object.assign(new Dto.CreateUserRequest(), req)
  await validate(req)
    .catch(e => {
      console.error(e)
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  if (await userService.existUser(uid)) {
    console.error('user already exist')
    throw new functions.https.HttpsError('already-exists', 'user already exist')
  }

  const user = await userService.createUser(uid, req)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to create user')
    })

  console.log(`[createUser] uuid: ${uid} user created`)

  return { user }
}

/**
 * フレーズをお気に入りに追加する
 */
export const favoritePhrase = async (req: Dto.FavoritePhraseRequest, context: Context): Promise<Dto.FavoritePhraseResponse> => {
  const uid = await authorize(context)

  // object -> class instance
  req = Object.assign(new Dto.FavoritePhraseRequest(), req)
  await validate(req)
    .catch(e => {
      console.error(e)
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  await userService.favoritePhrase(uid, req.listId, req.phraseId, req.favorite)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to favorite phrase')
    })

  return {
    success: true
  }
}

/**
 * ユーザーがポイントを獲得
 */
export const getPoint = async (req: Dto.GetPointRequest, context: Context): Promise<Dto.GetPointResponse> => {
  const uid = await authorize(context)
  req = Object.assign(new Dto.GetPointRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('point is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  await userService.getPoint(uid, req.point)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to get point')
    })

  console.log(`[getPoint] getPoint uid: ${uid}, point: ${req.point}`)

  return {
    success: true
  }
}

/**
 *  テストを受ける(TODO)
 */
export const doTest = async (req: Dto.DoTestRequest, context: Context): Promise<Dto.DoTestResponse> => {
  const uid = await authorize(context)
  await userService.doTest(uid, req.sectionId)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to do test')
    })

  console.log(`[doTest] doTest uid: ${uid}`)

  return {
    success: true
  }
}

/**
 * ユーザー更新
 */
export const updateUser = async (req: Dto.UpdateUserRequest, context: Context): Promise<Dto.UpdateUserResponse> => {
  await authorize(context)

  const updatedUser = await userService.updateUser(req)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to update user')
    })

  console.log(`[deleteUser] uuid: ${updatedUser.uuid} user updated`)

  return {
    user: updatedUser
  }
}

/**
 * アカウントを削除する
 */
export const deleteUser = async (req: Dto.DeleteUserRequest, context: Context): Promise<Dto.DeleteUserResponse> => {
  const uuid = await authorize(context)

  await userService.delete(uuid)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to delete user')
    })

  await firebase.auth().deleteUser(uuid)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to delete account')
    })

  console.log(`[deleteUser] uuid: ${uuid} user deleted`)

  return {
    success: true
  }
}