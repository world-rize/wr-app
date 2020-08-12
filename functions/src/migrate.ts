/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import * as admin from 'firebase-admin'
import { User } from './user/model/user'
import { UserService } from './user/userService'
import diffDefault from 'jest-diff'
import { UserRepository } from './user/userRepository'
const nqdm = require('nqdm')
const colors = require('colors')

admin.initializeApp({
  credential: admin.credential.applicationDefault()
})

interface OldUserSchema {
  age: string
  email: string
  favorites: Record<string, boolean>
  name: string
  point: number
  testLimitCount: number
  userId: string
  uuid: string
}

export interface MigrationPolicy {
  // migration name
  name: string
  // batch category
  category: string
  // description
  description: string
}

export class MigrationService {
  /**
   * 
   * Migrate All items by batch
   */
  async migrateAll<From, To = From>({
    policy, oldItemsGetter, transformer, batchWriter, batchExecutor, oneshot
  }: {
    policy: MigrationPolicy,
    oldItemsGetter: () => Promise<From[]>,
    transformer: (from: From) => To,
    batchWriter: (to: To) => void,
    batchExecutor: () => Promise<unknown>,
    oneshot?: boolean,
  }): Promise<void> {
    console.log(`[Batch] ${colors.bold(policy.category)} ${colors.green(policy.name)}`)
    console.log('Getting old items ...')

    const oldItems = await oldItemsGetter()

    console.log(`${colors.bold('Overview')} ${colors.yellow(oldItems.length)} Items`)

    if (oneshot) {
      const example = oldItems[0]
      const mapped = transformer(example)
      console.log(diffDefault(example, mapped))
      console.log(`[Batch(DryRun)] ${colors.green(policy.name)} completed!`)
      return
    }

    for (let oldItem of nqdm(oldItems)) {
      const mapped = transformer(oldItem)
      batchWriter(mapped)
    }

    await batchExecutor()

    console.log(`[Batch] ${colors.green(policy.name)} completed!`)
  }
}

/**
 * テストユーザーを作成
 */
export const createTestUser = async () => {
  const testUserUuid = 'ua4YJOOZKcMV0Y2GduUI9g2p0em1'
  const testUser = UserService.generateInitialUser(testUserUuid)
  testUser.name = 'テスト'
  testUser.statistics.points = 9999
  testUser.attributes.age = '10'
  testUser.attributes.email = 'a@b.com'
  const repo = new UserRepository()
  await repo.create(testUser)
}

/**
 * ユーザーのデータを無印からv1にマイグレーション
 */
export const migrateUsersToV1 = async () => {
  if (!process.env['MIGRATE']) {
    console.warn('execute with "MIGRATE" environment variables')
    return
  }

  const policy: MigrationPolicy = {
    category: 'user',
    name: 'migrateUserFromOldToV1',
    description: 'Migrate All Users Old To V1',
  }

  const migrator = new MigrationService()
  const firestore = admin.firestore()
  const batch = firestore.batch()
  const usersCollection = firestore.collection('users')

  await migrator.migrateAll<OldUserSchema, User>({
    policy,
    oldItemsGetter: async () => {
      return Object.values((await usersCollection.get())
        .docs.map(ss => ss.data() as OldUserSchema))
    },
    transformer: (from) => {
      const newUser = UserService.generateInitialUser(from.uuid)
      newUser.name = from.name
      newUser.attributes.age = from.age
      newUser.attributes.email = from.email
      return newUser
    },
    batchWriter: (to) => {
      batch.set(usersCollection.doc(to.uuid), to)
    },
    batchExecutor: () => {
      return batch.commit()
    },
    oneshot: false,
  })
}

createTestUser()

// migrateUsersToV1()