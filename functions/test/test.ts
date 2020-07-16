import * as firebase from 'firebase'
const serviceAccount = require('../../.env/credential.json')

firebase.initializeApp(serviceAccount)
const functions = firebase.functions()
functions.useFunctionsEmulator('http://localhost:5000')

describe('api health check', ()  => {
  test('test', async () => {
    const callable = functions.httpsCallable('test')
    const res = callable({})
    return expect(res).resolves.toMatchObject({
      data: {
        success: true
      }
    })
  })

  test('readUser', () => {

  })
})
