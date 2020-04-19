import { firestore } from 'firebase-admin'

export interface User {
  uuid: string
  favorites: Record<string, boolean>
}

class UserRepository {
  users: firestore.CollectionReference

  constructor() {
    this.users = firestore().collection('users')
  }

  public async create(uuid: string): Promise<void> {
    await this.users.doc(uuid).set({ uuid, favorites: {} })
  }

  public async findById(uuid: string): Promise<User | null> {
    return (await this.users.doc(uuid).get()).data() as User | null
  }

  public async update(user: User): Promise<void> {
    await this.users.doc(user.uuid).update(user)
  }

  public async remove(uuid: string): Promise<void> {
    await this.users.doc(uuid).delete()
  }
}

export const users = new UserRepository()