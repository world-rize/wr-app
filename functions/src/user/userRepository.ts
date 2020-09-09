/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { firestore } from 'firebase-admin'
import { User } from './model/user'


export class UserRepository {
  users: firestore.CollectionReference

  constructor() {
    this.users = firestore().collection('users')
  }

  public async create(user: User): Promise<User> {
    await this.users.doc(user.uuid).set(user)
    return user
  }

  public async exists(uuid: string): Promise<boolean> {
    return (await this.users.doc(uuid).get()).exists
  }

  public async findById(uuid: string): Promise<User> {
    const data = (await this.users.doc(uuid).get()).data()
    if (!data) {
      throw 'user not found'
    }
    return data as User
  }

  public async findByUserId(userId: string): Promise<User> {
    const docs = await this.users
      .where('userId', '==', userId)
      .limit(1)
      .get()
    return docs[0]
  }

  public async update(user: User): Promise<User> {
    // deleted property will not be deleted bacause of merging
    await this.users.doc(user.uuid).set(user)
    // await this.users.doc(user.uuid).set(user, { merge: true })
    return user
  }

  public async remove(uuid: string): Promise<void> {
    await this.users.doc(uuid).delete()
  }
}
