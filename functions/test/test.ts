import * as firebase from 'firebase'
import * as Dto from '../src/user/model/userApiDto'
import { User } from '../src/user/model/user'
import { UserService } from '../src/user/userService'
const serviceAccount = require('../../.env/credential.json')

firebase.initializeApp(serviceAccount)
const functions = firebase.functions()
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

describe('api call', ()  => {
  test('test', async (done) => {
    const res = invoke<Dto.TestRequest, Dto.TestResponse>('test', {})
    await expect(res).resolves.toMatchObject({
      success: true
    })
    done()
  })

  test('readUser', async (done) => {
    await withAuthorized(async (user, ref) => {
      const res = invoke<Dto.ReadUserRequest, Dto.ReadUserResponse>('readUser', {})
      await expect(res).resolves.toMatchObject({
        user: expect.anything()
      })
    })
    done()
  }, 10000)

  test('createUser', async (done) => {
    await withTestAccount(async (user, ref) => {
      const res = invoke<
        Dto.CreateUserRequest, Dto.CreateUserResponse
      >('createUser', {
        name: 'hoge',
        email: 'c@d.com',
        age: '10'
      })
      await expect(res).resolves.toMatchObject({
        user: {
          uuid: user.uid,
          userId: user.uid,
          name: 'hoge',
        }
      })
    })
    done()
  }, 10000)

  test('favoritePhrase', async (done) => {
    await withAuthorized(async (_, ref) => {
      const res = invoke<
        Dto.FavoritePhraseRequest, Dto.FavoritePhraseResponse
      >('favoritePhrase', {
        listId: 'default',
        phraseId: 'debug',
        favorite: true,
      })
    
      await expect(res).resolves.toMatchObject({
        success: true
      })

      const user = await ref.get()
        .then(ss => ss.data() as User)

      expect(user.favorites['default'].favoritePhraseIds['debug']).toBeTruthy()
    })
    done()
  }, 10000)

  test('getPoint', async (done) => {
    await withAuthorized(async (fbUser, ref) => {
      const beforeUser = await ref.get()
        .then(ss => ss.data() as User)

      const res = invoke<
        Dto.GetPointRequest, Dto.GetPointResponse
      >('getPoint', {
        points: 3
      })
      await expect(res).resolves.toMatchObject({
        success: true
      })

      const afterUser = await ref.get()
        .then(ss => ss.data() as User)

      expect(afterUser.statistics.points).toBe(beforeUser.statistics.points + 3)
    })
    done()
  }, 10000)

  test('updateUser', async (done) => {
    await withAuthorized(async (fbUSer, ref) => {
      const beforeUser = await ref.get()
        .then(ss => ss.data() as User)

      const res = invoke<
        Dto.UpdateUserRequest, Dto.UpdateUserResponse
      >('updateUser', {
        user: {
          ...beforeUser,
          name: `${beforeUser.name}+`
        }
      })

      await expect(res).resolves.toMatchObject({
        user: expect.anything(),
      })

      const afterUser = await ref.get()
        .then(ss => ss.data() as User)

      expect(afterUser.name).toBe(`${beforeUser.name}+`)
    })
    done()
  }, 10000)

  test('deleteUser', async (done) => {
    await withTestAccount(async (fbUser, ref) => {
      await ref.set(UserService.generateInitialUser(fbUser.uid))

      const res = invoke<Dto.DeleteUserRequest, Dto.DeleteUserResponse>('deleteUser', {})
      await expect(res).resolves.toMatchObject({
        success: true
      })

      const existUser = await ref.get().then(ss => ss.exists)
      expect(existUser).toBe(false)
    })
    done()
  }, 10000)

  test('doTest(Success)', async (done) => {
    await withAuthorized(async (fbUser, ref, oldUser) => {
      const res = invoke<
        Dto.DoTestRequest, Dto.DoTestResponse
      >('doTest', {
        sectionId: 'debug'
      })
      await expect(res).resolves.toMatchObject({
        success: true
      })
  
      const afterUser = await ref.get()
        .then(ss => ss.data() as User)
  
      expect(afterUser.statistics.testLimitCount).toBe(oldUser.statistics.testLimitCount - 1)
    })
    done()
  }, 10000)

  test('doTest(Fail)', async (done) => {
    await withAuthorized(async (fbUser, ref) => {
      await ref.set({ statistics: { testLimitCount: 0 }} as Partial<User>, { merge: true })

      const res = invoke<
        Dto.DoTestRequest, Dto.DoTestResponse
      >('doTest', {
        sectionId: 'debug'
      })
      await expect(res).rejects.toBeTruthy()
    })
    done()
  }, 10000)
})
