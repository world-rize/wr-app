/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { User } from './model/user'
import { CreateUserRequest, UpdateUserRequest } from './model/userApiDto'
import { UserRepository } from './userRepository'

export class UserService {
  private readonly repo: UserRepository

  constructor(repo: UserRepository) {
    this.repo = repo
  }

  generateUser (uuid: string, req: CreateUserRequest): User {
    return {
      uuid: uuid,
      name: req.name,
      userId: uuid,
      point: 0,
      testLimitCount: 3,
      favorites: {},
      email: req.email,
      age: req.age,
    }
  }

  async existUser(uuid: string): Promise<boolean> {
    return this.repo.exists(uuid)
  }

  async updateUser(req: UpdateUserRequest): Promise<User> {
    return this.repo.update(req.user)
  }

  async createUser(uuid: string, req: CreateUserRequest) {
    const user = this.generateUser(uuid, req)
    return this.repo.create(user)
  }

  async readUser(uuid: string): Promise<User | null> {
    return this.repo.findById(uuid)
  }

  async favoritePhrase (uuid: string, phraseId: string, value: boolean): Promise<boolean> {
    const user = await this.repo.findById(uuid)
    if (!user) {
      throw 'User not found'
    }
    user.favorites[phraseId] = value
    await this.repo.update(user)
    return true
  }

  async getPoint (uuid: string, point: number): Promise<boolean> {
    const user = await this.repo.findById(uuid)
    if (!user) {
      throw 'User not found'
    }
    if (user.point + point < 0) {
      throw 'Not enough points'
    }
    user.point += point
    await this.repo.update(user)
    return true
  }

  async delete(uuid: string): Promise<void> {
    return await this.repo.remove(uuid)
  }

  async doTest(uuid: string): Promise<boolean> {
    const user = await this.repo.findById(uuid)
    if (!user) {
      throw 'User not found'
    }
    if (user.testLimitCount == 0) {
      throw 'Daily test limit exceeded'
    }
    user.testLimitCount -= 1
    await this.repo.update(user)
    return true
  }
}
