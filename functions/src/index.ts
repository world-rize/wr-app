import * as functions from 'firebase-functions'

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
