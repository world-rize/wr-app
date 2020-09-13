/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as firebase from 'firebase-admin'
import { validate } from 'class-validator'
import { UserService } from './userService'
import { NoteService } from './noteService'
import { UserRepository } from './userRepository'
import * as functions from 'firebase-functions'
import { User } from './model/user'
import * as UserDto from './model/userApiDto'
import * as NoteDto from './model/noteApiDto'
import { Note } from './model/note'
import { GiftItem } from './model/item'

// onCall() has varify firebase tokens unlike onRequest()

type Context = functions.https.CallableContext
const userRepo = new UserRepository()
const userService = new UserService(userRepo)
const noteService = new NoteService(userRepo)

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
export const createUser = async (req: UserDto.CreateUserRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)
  console.log(`[createUser] uid: ${uid}`)

  // object -> class instance
  req = Object.assign(new UserDto.CreateUserRequest(), req)
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

  console.log(`[createUser] userId: ${uid} user created`)

  return user
}

/**
 * フレーズをお気に入りに追加する
 */
export const favoritePhrase = async (req: UserDto.FavoritePhraseRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)

  // object -> class instance
  req = Object.assign(new UserDto.FavoritePhraseRequest(), req)
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
export const getPoint = async (req: UserDto.GetPointRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)
  req = Object.assign(new UserDto.GetPointRequest(), req)
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
export const doTest = async (req: UserDto.DoTestRequest, context: Context): Promise<User> => {
  const uid = await authorize(context)
  req = Object.assign(new UserDto.GetPointRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('req is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

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
  const userId = await authorize(context)

  console.log(`[deleteUser] userId: ${userId} user updated`)

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
  const userId = await authorize(context)

  await userService.delete(userId)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to delete user')
    })

  await firebase.auth().deleteUser(userId)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to delete account')
    })

  console.log(`[deleteUser] userId: ${userId} user deleted`)
}

/**
 * お気に入りグループを作成
 */
export const createFavoriteList = async (req: UserDto.CreateFavoriteListRequest, context: Context): Promise<User> => {
  const userId = await authorize(context)

  req = Object.assign(new UserDto.CreateFavoriteListRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('CreateFavoriteListRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  console.log(`[createFavoriteList] userId: ${userId} create favorite list ${req.name}`)

  return userService.createFavoriteList(userId, req.name)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to createFavoriteList')
    })
}

/**
 * お気に入りグループを削除
 */
export const deleteFavoriteList = async (req: UserDto.DeleteFavoriteListRequest, context: Context): Promise<User> => {
  const userId = await authorize(context)

  req = Object.assign(new UserDto.DeleteFavoriteListRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('DeleteFavoriteListRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  console.log(`[deleteFavoriteList] userId: ${userId} delete favorite list ${req.listId}`)

  return userService.deleteFavoriteList(userId, req.listId)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to deleteFavoriteList')
    })
}

/**
 *  30 days streakが続いているか
 */
export const checkTestStreaks = async (req: {}, context: Context): Promise<boolean> => {
  const userId = await authorize(context)
  return userService.checkTestStreaks(userId)
}

/**
 * テスト結果を送信
 */
export const sendTestResult  = async (req: UserDto.SendTestResultRequest, context: Context): Promise<User> => {
  const userId = await authorize(context)

  req = Object.assign(new UserDto.SendTestResultRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('SendTestResultRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  // TODO: phrase validate

  console.log(`[deletePhrase] userId: ${userId} send ${req.sectionId} test score :${req.score}`)

  return userService.sendTestResult(userId, req.sectionId, req.score)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to sendTestResult')
    })
  }

// ノートを作成
export const createNote = async (req: NoteDto.CreateNoteRequest, context: Context): Promise<Note> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.CreateNoteRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('CreateNoteRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })
  return noteService.createNote(userId, req.title)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to createNote')
  })
}

// ノートのタイトルを変更
export const updateNoteTitle = async (req: NoteDto.UpdateNoteTitleRequest, context: Context): Promise<Note> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.UpdateNoteTitleRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('UpdateNoteTitleRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })
  return noteService.updateNoteTitle(userId, req.noteId, req.title)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to updateNoteTitle')
    })
}

// isDefaultを変更
export const updateDefaultNote = async (req: NoteDto.UpdateDefaultNoteRequest, context: Context): Promise<Note> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.UpdateDefaultNoteRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('UpdateDefaultNoteRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })
  return noteService.updateDefaultNote(userId, req.noteId)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to updateDefaultNote')
    })
}

// ノートを削除
export const deleteNote = async (req: NoteDto.DeleteNoteRequest, context: Context): Promise<void> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.DeleteNoteRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('DeleteNoteRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })
  return noteService.deleteNote(userId, req.noteId)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to deleteNote')
    })
}

// noteId: string, phrase: Phrase
// ノートにフレーズを追加
//
export const addPhraseInNote = async (req: NoteDto.AddPhraseInNoteRequest, context: Context): Promise<Note> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.AddPhraseInNoteRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('AddPhraseToPhraseListRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  // TODO: phrase validate

  console.log(`[createPhrasesList] userId: ${userId} create phrase ${req.phrase.word} note ${req.noteId}`)

  return noteService.addPhraseInNote(userId, req.noteId, req.phrase)
    .catch (e => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to addPhraseInNote')
    })
}
// noteId: string, phraseId: string, phrase: Phrase
// ノートのフレーズを更新
export const updatePhraseInNote = async (req: NoteDto.UpdatePhraseInNoteRequest, context: Context): Promise<Note> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.UpdatePhraseInNoteRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('UpdatePhraseInNoteRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })
  return noteService.updatePhraseInNote(userId, req.noteId, req.phraseId, req.phrase)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to updatePharaseInNote')
    })
}

// ## deletePhraseInNote(noteId: string, phraseId: string): void
// ノートのフレーズを削除
export const deletePhraseInNote = async (req: NoteDto.DeletePhraseInNote, context: Context): Promise<void> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.DeletePhraseInNote(), req)
  await validate(req)
    .catch(e => {
      console.error('DeletePhraseInNote is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })
  return noteService.deletePhraseInNote(userId, req.noteId, req.phraseId)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to deletePharaseInNote')
    })
}

export const achievePhraseInNote = async (req: NoteDto.AchievePhraseInNote, context: Context): Promise<void> => {
  const userId = await authorize(context)

  req = Object.assign(new NoteDto.AchievePhraseInNote(), req)
  await validate(req)
    .catch(e => {
      console.error('AchievePhraseInNote is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })
  return noteService.achievePhraseInNote(userId, req.noteId, req.phraseId, req.achieve)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', 'failed to achievePhraseInNote')
    })
}

/**
 * ユーザーを [userId] で検索します
 * - ユーザーがみつかった場合は [User] を返し
 * - 見つからなかった場合は not-found エラーを返します
 */
export const findUserByUserId = async(req: UserDto.FindUserByUserIdRequest, context: Context): Promise<User> => {
  const userId = await authorize(context)

  req = Object.assign(new UserDto.FindUserByUserIdRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('FindUserByUserId is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  return userService.findUserByUserId(userId, req.userId)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('not-found', `userId ${req.userId} not found`)
    })
}

/**
 * 友人を紹介します
 */
export const introduceFriend = async (req: UserDto.IntroduceFriendRequest, context: Context) => {
  const userId = await authorize(context)

  req = Object.assign(new UserDto.IntroduceFriendRequest(), req)
  await validate(req)
    .catch(e => {
      console.error('IntroduceFriendRequest is invalid')
      throw new functions.https.HttpsError('invalid-argument', e)
    })

  return userService.introduceUser(userId, req.introduceeUserId)
    .catch((e) => {
      console.error(e)
      throw new functions.https.HttpsError('internal', e)
    })
}

/**
 * アイテム
 */
export const getShopItems = async(req: {}, context: Context): Promise<GiftItem[]> => {
  await authorize(context)

  return userService.getShopItems()
}