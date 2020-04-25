import { User, users } from './model'

export const userService = {
  existUser: async (uuid: string): Promise<boolean> => {
    return users.exists(uuid)
  },
  createUser: async (uuid: string) => {
    return users.create(uuid)
  },
  readUser: async (uuid: string): Promise<User | null> => {
    return users.findById(uuid)
  },
  favoritePhrase: async (uuid: string, phraseId: string, value: boolean): Promise<boolean> => {
    const user = await users.findById(uuid)
    if (!user) {
      throw 'User not found'
    }
    user.favorites[phraseId] = value
    await users.update(user)
    return false
  },
  delete: async (uuid: string): Promise<void> => {
    return await users.remove(uuid)
  }
}
