import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase)
import { userService } from './user'

// onCall() has varify firebase tokens unlike onRequest()

interface TestRequest {
  hoge: string
}

interface TestResponse {
  success: boolean
}

export const test = functions.https.onCall((data: TestRequest, context): TestResponse => {
  console.log(data.hoge)
  console.log(context.auth?.uid)
  
  return {
    success: true
  }
})

interface CreateUserRequest {}
interface CreateUserResponse {
  success: boolean
}

export const createUser = functions.https.onCall(async (data: CreateUserRequest, context): Promise<CreateUserResponse> => {
  try {
    if (!context.auth) {
      throw ''
    }
    // TODO: validation

    const uid = context.auth.uid
    await userService.createUser(uid)
    return { success: true }
  } catch (e) {
    console.log(e)
    return { success: false }
  }
})

interface FavoritePhraseRequest {
  phraseId: string
  value: boolean
}

interface FavoritePhraseResponse {
  success: boolean
}

export const favoritePhrase = functions.https.onCall(async (data: FavoritePhraseRequest, context): Promise<FavoritePhraseResponse> => {
  try {
    if (!context.auth) {
      throw ''
    }
    const uid = context.auth.uid
    const phraseId: string = data.phraseId
    const value: boolean = data.value

    if (!phraseId || value === null) {
      throw ''
    }

    const success = await userService.favoritePhrase(uid, phraseId, value)
    return {
      success
    }
  } catch (e) {
    console.log(e)
    return {
      success: false
    }
  }
})
