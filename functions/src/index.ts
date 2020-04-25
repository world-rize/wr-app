import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase)
import { userService } from './user'
import { User } from './user/model'

// onCall() has varify firebase tokens unlike onRequest()

interface TestRequest {
  hoge: string
}

interface TestResponse {
  success: boolean
}

/**
 *  デバッグ用
 */
export const test = functions.https.onCall((data: TestRequest, context): TestResponse => {
  console.log(data.hoge)
  console.log(context.auth?.uid)
  
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
  const user = await userService.readUser(uid)

  if (!user) {
    console.error('user not found')
    throw new functions.https.HttpsError('not-found', 'user not found')
  }

  return { user }
})

interface CreateUserRequest {}
interface CreateUserResponse {
  success: boolean
}

/**
 *  ユーザーを作成します
 */
export const createUser = functions.https.onCall(async (data: CreateUserRequest, context): Promise<CreateUserResponse> => {
  if (!context.auth) {
    console.error('not authorized')
    throw new functions.https.HttpsError('permission-denied', 'not authorized')
  }

  const uid = context.auth.uid

  if (await userService.existUser(uid)) {
    console.error('user already exist')
    throw new functions.https.HttpsError('already-exists', 'user already exist')
  }

  await userService.createUser(uid)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to create user')
    })

  return { success: true }
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

  if (!phraseId || value === null) {
    console.error('phraseId or value is invalid')
    throw new functions.https.HttpsError('invalid-argument', 'phraseId or value is invalid')
  }

  const success = await userService.favoritePhrase(uid, phraseId, value)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to favorite phrase')
    })

  return {
    success
  }
})
