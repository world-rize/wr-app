import * as functions from 'firebase-functions'
import { userService } from './user'

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

// onCall() has varify firebase tokens unlike onRequest()
export const test = functions.https.onCall((data, context) => {
  console.log(JSON.stringify(data))
  console.log(context.auth?.uid)
  
  return {
    success: true
  }
})

export const createUser = functions.https.onCall(async (data, context) => {
  try {
    if (!context.auth) {
      throw ''
    }
    const uid = context.auth.uid
    const success = await userService.createUser(uid)
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

export const favoritePhrase = functions.https.onCall(async (data, context) => {
  try {
    if (!context.auth) {
      throw ''
    }
    const uid = context.auth.uid
    const phraseId: string = data['phraseId']
    const value: boolean = data['value']
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
