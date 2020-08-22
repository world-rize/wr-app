/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as firebase from 'firebase-admin'
import { validate } from 'class-validator'
import { UserService } from './userService'
import { UserRepository } from './userRepository'
import * as functions from 'firebase-functions'
import { User } from './model/user'
import { CreateUserRequest, FavoritePhraseRequest, GetPointRequest, CreateFavoriteListRequest, DeleteFavoriteListRequest, CreatePhrasesListRequest, AddPhraseToPhraseListRequest, SendTestResultRequest, DeletePhraseRequest, DoTestRequest } from './model/userApiDto'

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
  // for debug
  // return 'xrV7lr6TXOUuWYgW0M3CP8qYIWp1'
}


/**
 *  デバッグ用
 */
export const test = async (req: {}, context: Context) => {
  console.log(`[test] done`)
}

/**
 *  ユーザーを取得します
 */
export const readUser = async (req: {}, context: Context): Promise<User> => {
  const uid = await authorize(context)
  const user = await userService.readUser(uid)

  if (!user) {
    console.error('user not found')
    throw new functions.https.HttpsError('not-found', 'user not found')
  }

  console.log(`[readUser] done`)

  return user
}

/**
 * ログイン
 */
export const login = async (req: {}, context: Context) => {
  const uid = await authorize(context)
  await userService.login(uid)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to login')
    })

  console.log(`[login] done`)
}

/**
 *  ユーザーを作成します
 */
export const createUser = async (req: CreateUserRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)
  console.log(`[createUser] uid: ${uid}`)

  // object -> class instance
  req = Object.assign(new CreateUserRequest(), req)
  await validate(req)
    .catch(e => {
      console.error(e)
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  if (await userService.existUser(uid)) {
    console.error('user already exist')
    throw new functions.https.HttpsError('already-exists', 'user already exist')
  }

  const user = await userService.createUser(uid, req.name, req.email, req.age)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to create user')
    })

  console.log(`[createUser] uuid: ${uid} user created`)

  return user
}

/**
 * フレーズをお気に入りに追加する
 */
export const favoritePhrase = async (req: FavoritePhraseRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)

  // object -> class instance
  req = Object.assign(new FavoritePhraseRequest(), req)
  await validate(req)
    .catch(e => {
      console.error(e)
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  return userService.favoritePhrase(uid, req.listId, req.phraseId, req.favorite)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to favorite phrase')
    })
}

/**
 * ユーザーがポイントを獲得
 */
export const getPoint = async (req: GetPointRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)
  req = Object.assign(new GetPointRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('point is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  console.log(`[getPoint] getPoint uid: ${uid}, point: ${req.points}`)

  return userService.getPoint(uid, req.points)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to get points')
    })
}

/**
 *  テストを受ける
 */
export const doTest = async (req: DoTestRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)

  console.log(`[doTest] ${uid} doTest ${req.sectionId}`)

  return userService.doTest(uid, req.sectionId)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to do test')
    })
}

/**
 * ユーザー更新
 */
export const updateUser = async (req: User, context: Context): Promise<User> => {
  const uuid = await authorize(context)

  console.log(`[deleteUser] uuid: ${uuid} user updated`)

  return await userService.updateUser(req)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to update user')
    })
}

/**
 * アカウントを削除する
 */
export const deleteUser = async (req: {}, context: Context) => {
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
}

/**
 * お気に入りグループを作成
 */
export const createFavoriteList = async (req: CreateFavoriteListRequest, context: Context): Promise<User> => {
  const uuid = await authorize(context)

  req = Object.assign(new CreateFavoriteListRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('CreateFavoriteListRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  console.log(`[createFavoriteList] uuid: ${uuid} create favorite list ${req.name}`)

  return userService.createFavoriteList(uuid, req.name)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to createFavoriteList')
    })
}

/**
 * お気に入りグループを削除
 */
export const deleteFavoriteList = async (req: DeleteFavoriteListRequest, context: Context): Promise<User> => {
  const uuid = await authorize(context)

  req = Object.assign(new DeleteFavoriteListRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('DeleteFavoriteListRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  console.log(`[deleteFavoriteList] uuid: ${uuid} delete favorite list ${req.listId}`)

  return userService.deleteFavoriteList(uuid, req.listId)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to deleteFavoriteList')
    })
}

/**
 * フレーズリストを作成
 */
export const createPhrasesList = async (req: CreatePhrasesListRequest, context: Context): Promise<User> => {
  const uuid = await authorize(context)

  req = Object.assign(new CreatePhrasesListRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('CreatePhrasesListRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  console.log(`[createPhrasesList] uuid: ${uuid} create phrases list ${req.title}`)

  return userService.createPhrasesList(uuid, req.title)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to deleteFavoriteList')
    })
}

/**
 * フレーズリストにフレーズを追加
 */
export const addPhraseToPhraseList = async (req: AddPhraseToPhraseListRequest, context: Context): Promise<User> => {
  const uuid = await authorize(context)

  req = Object.assign(new AddPhraseToPhraseListRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('AddPhraseToPhraseListRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  // TODO: phrase validate

  console.log(`[createPhrasesList] uuid: ${uuid} create phrase ${req.phrase.title} list ${req.listId}`)

  return userService.addPhraseToPhraseList(uuid, req.listId, req.phrase)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to addPhraseToPhraseList')
    })
}

/**
 * フレーズリストからフレーズを削除
 */
export const deletePhraseList = async (req: DeletePhraseRequest, context: Context): Promise<User> => {
  const uuid = await authorize(context)

  req = Object.assign(new DeletePhraseRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('DeletePhraseRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  // TODO: phrase validate

  console.log(`[deletePhrase] uuid: ${uuid} delete ${req.phraseId} from note ${req.listId}`)

  return userService.deletePhrase(uuid, req.listId, req.phraseId)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to deletePhraseList')
    })
}

/**
 * テスト結果を送信
 */
export const sendTestResult  = async (req: SendTestResultRequest, context: Context): Promise<User> => {
  const uuid = await authorize(context)

  req = Object.assign(new SendTestResultRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('SendTestResultRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  // TODO: phrase validate

  console.log(`[deletePhrase] uuid: ${uuid} send ${req.sectionId} test score :${req.score}`)

  return userService.SendTestResult(uuid, req.sectionId, req.score)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to sendTestResult')
    })
}