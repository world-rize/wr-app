import { firestore } from 'firebase-admin'
import { User } from './model'

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

  public async findById(uuid: string): Promise<User | null> {
    return (await this.users.doc(uuid).get()).data() as User | null
  }

  public async update(user: User): Promise<User> {
    await this.users.doc(user.uuid).update(user)
    return user
  }

  public async remove(uuid: string): Promise<void> {
    await this.users.doc(uuid).delete()
  }
}

export const users = new UserRepository()
