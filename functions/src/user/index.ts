
export interface User {
  uuid: string
  favorites: Record<string, boolean>
}

export const userService = {
  createUser: async (uuid: string): Promise<boolean> => {
    return false
  },
  readUser: async (uuid: string): Promise<User> => {
    return {
      uuid,
      favorites: {},
    }
  },
  favoritePhrase: async (uuid: string, phraseId: string, value: boolean): Promise<boolean> => {
    return false
  }
}
