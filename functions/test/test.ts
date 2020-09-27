import * as firebase from 'firebase'
import * as admin from 'firebase-admin'
import * as Dto from '../src/user/model/userApiDto'
import { User } from '../src/user/model/user'
import { UserService } from '../src/user/userService'
// admin
const serviceAccount = require(__dirname + '/../../secrets/wr-english-dev-firebase-adminsdk-bdsl4-93d40f5ec1.json')
// client
const credential = {
  apiKey: "AIzaSyBZ-YVIVPA5CGPuRyJxNF4dSi-h6XhYUU0",
  authDomain: "wr-english-dev.firebaseapp.com",
  databaseURL: "https://wr-english-dev.firebaseio.com",
  projectId: "wr-english-dev",
  storageBucket: "wr-english-dev.appspot.com",
  messagingSenderId: "369807490628",
  appId: "1:369807490628:web:f16b0f838cbe9db0090611",
  measurementId: "G-QFPXKZ2F7X"
}

firebase.initializeApp(credential)
const functions = firebase.functions()
const firestore = firebase.firestore()
firestore.settings({
  host: 'localhost:8080',
  ssl: false,
})

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// use local emulator
const isLocal = true
if (isLocal) {
  functions.useFunctionsEmulator('http://localhost:5000')
}

const invoke = async <Req, Res>(name: string, req: Req): Promise<Res> => {
  const callable = functions.httpsCallable(name)
  const res = await callable(req)
  return res.data as Res
}

const withTestAccount = async (callback: (fbUser: firebase.User, ref: firebase.firestore.DocumentReference) => Promise<void>) => {
  // create account
  const auth = await firebase.auth().createUserWithEmailAndPassword('c@d.com', '123456')
  const ref = firebase.firestore().collection('users').doc(auth.user.uid)
  try {
    await callback(auth.user, ref)
  } finally {
    await firebase.auth().signInWithEmailAndPassword('c@d.com', '123456')
      .then(auth => auth.user.delete())
    if ((await ref.get()).exists) {
      await ref.delete()
    }
  }
}

const withAuthorized = async (callback: (fbUser: firebase.User, ref: firebase.firestore.DocumentReference, oldUser: User | null) => Promise<void>) => {
  // authorize
  const auth = await firebase.auth().signInWithEmailAndPassword('a@b.com', '123456')
  const ref = firebase.firestore().collection('users').doc(auth.user.uid)
  const oldUser = (await ref.get()).data()
  try {
    await callback(auth.user, ref, oldUser as User | null)
  } finally {
    await firebase.auth().signOut()
    // restore
    if (!oldUser)
      await ref.set(oldUser)
  }
}

/**
 * Firebase ルールのテスト
 * $ jest -t rule_test
 * */
describe('rule_test', () => {
  beforeAll(async (done) => {


    console.log('beforeall')
    done()
  })
  afterAll(async (done) => {
    console.log('afterall')
    const batch = admin.firestore().batch()
    const users = await admin.firestore().collection('users').get();
    users.docs.forEach(doc => {
      batch.delete(doc.ref);
    })
    await batch.commit()
    done()
  })

  test('fail to create user', async (done) => {
    const res = Promise.all([...Array(10)].map(_ =>
      firestore.collection('users').add({
        name: 'Tokyo',
        country: 'Japan'
      })
    ))
    await expect(res).rejects.toBeTruthy()
    done()
  }, 100000)

  test('user cannot read other users data', async (done) => {
    const promise = firestore.collection('users').get()
    await expect(promise).rejects.toBeTruthy()
    done()
  })
})

// describe('api call', () => {
//   test('test', async (done) => {
//     const res = invoke<Dto.TestRequest, Dto.TestResponse>('test', {})
//     await expect(res).resolves.toMatchObject({
//       success: true
//     })
//     done()
//   })
//
//   test('readUser', async (done) => {
//     await withAuthorized(async (user, ref) => {
//       const res = invoke<Dto.ReadUserRequest, Dto.ReadUserResponse>('readUser', {})
//       await expect(res).resolves.toMatchObject({
//         user: expect.anything()
//       })
//     })
//     done()
//   }, 10000)
//
//   test('createUser', async (done) => {
//     await withTestAccount(async (user, ref) => {
//       const res = invoke<
//         Dto.CreateUserRequest, Dto.CreateUserResponse
//       >('createUser', {
//         name: 'hoge',
//         email: 'c@d.com',
//         age: '10'
//       })
//       await expect(res).resolves.toMatchObject({
//         user: {
//           uuid: user.uid,
//           userId: user.uid,
//           name: 'hoge',
//         }
//       })
//     })
//     done()
//   }, 10000)
//
//   test('favoritePhrase', async (done) => {
//     await withAuthorized(async (_, ref) => {
//       const res = invoke<
//         Dto.FavoritePhraseRequest, Dto.FavoritePhraseResponse
//       >('favoritePhrase', {
//         listId: 'default',
//         phraseId: 'debug',
//         favorite: true,
//       })
//
//       await expect(res).resolves.toMatchObject({
//         success: true
//       })
//
//       const user = await ref.get()
//         .then(ss => ss.data() as User)
//
//       expect(user.favorites['default'].favoritePhraseIds['debug']).toBeTruthy()
//     })
//     done()
//   }, 10000)
//
//   test('getPoint', async (done) => {
//     await withAuthorized(async (fbUser, ref) => {
//       const beforeUser = await ref.get()
//         .then(ss => ss.data() as User)
//
//       const res = invoke<
//         Dto.GetPointRequest, Dto.GetPointResponse
//       >('getPoint', {
//         points: 3
//       })
//       await expect(res).resolves.toMatchObject({
//         success: true
//       })
//
//       const afterUser = await ref.get()
//         .then(ss => ss.data() as User)
//
//       expect(afterUser.statistics.points).toBe(beforeUser.statistics.points + 3)
//     })
//     done()
//   }, 10000)
//
//   test('updateUser', async (done) => {
//     await withAuthorized(async (fbUSer, ref) => {
//       const beforeUser = await ref.get()
//         .then(ss => ss.data() as User)
//
//       const res = invoke<
//         Dto.UpdateUserRequest, Dto.UpdateUserResponse
//       >('updateUser', {
//         user: {
//           ...beforeUser,
//           name: `${beforeUser.name}+`
//         }
//       })
//
//       await expect(res).resolves.toMatchObject({
//         user: expect.anything(),
//       })
//
//       const afterUser = await ref.get()
//         .then(ss => ss.data() as User)
//
//       expect(afterUser.name).toBe(`${beforeUser.name}+`)
//     })
//     done()
//   }, 10000)
//
//   test('deleteUser', async (done) => {
//     await withTestAccount(async (fbUser, ref) => {
//       await ref.set(UserService.generateInitialUser(fbUser.uid))
//
//       const res = invoke<Dto.DeleteUserRequest, Dto.DeleteUserResponse>('deleteUser', {})
//       await expect(res).resolves.toMatchObject({
//         success: true
//       })
//
//       const existUser = await ref.get().then(ss => ss.exists)
//       expect(existUser).toBe(false)
//     })
//     done()
//   }, 10000)
//
//   test('doTest(Success)', async (done) => {
//     await withAuthorized(async (fbUser, ref, oldUser) => {
//       const res = invoke<
//         Dto.DoTestRequest, Dto.DoTestResponse
//       >('doTest', {
//         sectionId: 'debug'
//       })
//       await expect(res).resolves.toMatchObject({
//         success: true
//       })
//
//       const afterUser = await ref.get()
//         .then(ss => ss.data() as User)
//
//       expect(afterUser.statistics.testLimitCount).toBe(oldUser.statistics.testLimitCount - 1)
//     })
//     done()
//   }, 10000)
//
//   test('doTest(Fail)', async (done) => {
//     await withAuthorized(async (fbUser, ref) => {
//       await ref.set({ statistics: { testLimitCount: 0 }} as Partial<User>, { merge: true })
//
//       const res = invoke<
//         Dto.DoTestRequest, Dto.DoTestResponse
//       >('doTest', {
//         sectionId: 'debug'
//       })
//       await expect(res).rejects.toBeTruthy()
//     })
//     done()
//   }, 10000)
// })
