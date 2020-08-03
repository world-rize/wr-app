import * as firebase from 'firebase'
import { CreateUserRequest, TestRequest, ReadUserRequest, FavoritePhraseRequest, GetPointRequest, UpdateUserRequest, DeleteUserRequest, DoTestRequest } from '../src/domain/user/model/userApiDto'
import { User } from '../src/domain/user/model/user'
const serviceAccount = require('../../.env/credential.json')

firebase.initializeApp(serviceAccount)
const functions = firebase.functions()
// use local emulator
const isLocal = true
if (isLocal) {
  functions.useFunctionsEmulator('http://localhost:5000')
}

describe('api call', ()  => {
  test('test', async () => {
    const callable = functions.httpsCallable('test')
    const res = callable({} as TestRequest)
    await expect(res).resolves.toMatchObject({
      data: {
        success: true
      }
    })
  })

  test('readUser', async () => {
    // authorize
    await firebase.auth().signInWithEmailAndPassword('a@b.com', '123456')
    const callable = functions.httpsCallable('readUser')
    const res = callable({} as ReadUserRequest)
    await expect(res).resolves.toMatchObject({
      data: {
        user: expect.anything()
      }
    })
  })

  test('createUser', async () => {
    // create account
    const auth = await firebase.auth().createUserWithEmailAndPassword('c@d.com', '123456')

    const data: CreateUserRequest = {
      name: 'hoge',
      email: 'c@d.com',
      age: '10'
    }
    const callable = functions.httpsCallable('createUser')
    const res = callable(data)
    await expect(res).resolves.toMatchObject({
      data: {
        user: {
          uuid: auth.user?.uid,
          userId: auth.user?.uid,
          name: data.name,
          email: data.email,
          age: data.age,
        }
      }
    })

    await auth.user?.delete()
  }, 10000)

  test('favoritePhrase', async () => {
    // authorize
    const auth = await firebase.auth().signInWithEmailAndPassword('a@b.com', '123456')
    const userRef = firebase.firestore().collection('users').doc(auth.user?.uid)

    const callable = functions.httpsCallable('favoritePhrase')
    const data: FavoritePhraseRequest = {
      phraseId: '9999',
      value: true,
    }
    const res = callable(data)
    await expect(res).resolves.toMatchObject({
      data: {
        success: true
      }
    })

    const user = await userRef.get()
      .then(ss => ss.data() as User)

    expect(user.favorites['9999']).toBe(true)
  }, 10000)

  test('getPoint', async () => {
    // authorize
    const auth = await firebase.auth().signInWithEmailAndPassword('a@b.com', '123456')
    const userRef = firebase.firestore().collection('users').doc(auth.user?.uid)
    const beforeUser = await userRef.get()
      .then(ss => ss.data() as User)

    const callable = functions.httpsCallable('getPoint')
    const data: GetPointRequest = {
      uuid: beforeUser.uuid,
      point: 3
    }
    const res = callable(data)
    await expect(res).resolves.toMatchObject({
      data: {
        success: true
      }
    })

    const afterUser = await userRef.get()
      .then(ss => ss.data() as User)

    expect(afterUser.point).toBe(beforeUser.point + 3)
  })

  test('updateUser', async () => {
    // authorize
    const auth = await firebase.auth().signInWithEmailAndPassword('a@b.com', '123456')
    const userRef = firebase.firestore().collection('users').doc(auth.user?.uid)
    const beforeUser = await userRef.get()
      .then(ss => ss.data() as User)

    const callable = functions.httpsCallable('updateUser')
    const data: UpdateUserRequest = {
      user: {
        ...beforeUser,
        age: '20'
      }
    }
    const res = callable(data)
    await expect(res).resolves.toMatchObject({
      data: {
        user: expect.anything(),
      }
    })

    const afterUser = await userRef.get()
      .then(ss => ss.data() as User)

    expect(afterUser.age).toBe('20')
  })

  test('deleteUser', async () => {
    // authorize
    const auth = await firebase.auth().createUserWithEmailAndPassword('c@d.com', '123456')
    const userRef = firebase.firestore().collection('users').doc(auth.user?.uid)

    const callable = functions.httpsCallable('deleteUser')
    const data: DeleteUserRequest = {}
    const res = callable(data)
    await expect(res).resolves.toMatchObject({
      data: {
        success: true
      }
    })

    const existUser = await userRef.get().then(ss => ss.exists)
    expect(existUser).toBe(false)

    if (existUser) {
      await auth.user?.delete()
    }
  }, 10000)

  test('doTest(Success)', async () => {
    // authorize
    const auth = await firebase.auth().signInWithEmailAndPassword('a@b.com', '123456')
    const userRef = firebase.firestore().collection('users').doc(auth.user?.uid)
    await userRef.update({ testLimitCount: 3 } as Partial<User>)
    const beforeUser = await userRef.get()
      .then(ss => ss.data() as User)

    const callable = functions.httpsCallable('doTest')
    const data: DoTestRequest = {
      uuid: beforeUser.uuid,
    }
    const res = callable(data)
    await expect(res).resolves.toMatchObject({
      data: {
        success: true
      }
    })

    const afterUser = await userRef.get()
      .then(ss => ss.data() as User)

    expect(afterUser.testLimitCount).toBe(beforeUser.testLimitCount - 1)
  }, 100000)

  test('doTest(Fail)', async () => {
    // authorize
    const auth = await firebase.auth().signInWithEmailAndPassword('a@b.com', '123456')
    const userRef = firebase.firestore().collection('users').doc(auth.user?.uid)
    const beforeUser = await userRef.get()
      .then(ss => ss.data() as User)
    await userRef.update({ testLimitCount: 0 } as Partial<User>)

    const callable = functions.httpsCallable('doTest')
    const data: DoTestRequest = {
      uuid: beforeUser.uuid,
    }
    const res = callable(data)
    await expect(res).rejects.toBeTruthy()

    await userRef.update({ testLimitCount: 3 } as Partial<User>)
  })
})