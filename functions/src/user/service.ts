/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { User } from './model'
import { users } from './repo'
import { CreateUserRequest } from '../index'

export class UserService {
  static generateUser (req: CreateUserRequest): User {
    return {
      uuid: req.uuid,
      name: req.name,
      userId: req.userId,
      point: 0,
      favorites: {},
      email: req.email,
      age: req.age,
    }
  }

  static async existUser(uuid: string): Promise<boolean> {
    return users.exists(uuid)
  }

  static async createUser(req: CreateUserRequest) {
    const user = this.generateUser(req)
    return users.create(user)
  }

  static async readUser(uuid: string): Promise<User | null> {
    return users.findById(uuid)
  }

  static async favoritePhrase (uuid: string, phraseId: string, value: boolean): Promise<boolean> {
    const user = await users.findById(uuid)
    if (!user) {
      throw 'User not found'
    }
    user.favorites[phraseId] = value
    await users.update(user)
    return true
  }

  static async getPoint (uuid: string, point: number): Promise<boolean> {
    const user = await users.findById(uuid)
    if (!user) {
      throw 'User not found'
    }
    if (user.point + point < 0) {
      throw 'Not enough points'
    }
    user.point += point
    await users.update(user)
    return true
  }

  static async delete(uuid: string): Promise<void> {
    return await users.remove(uuid)
  }
}
