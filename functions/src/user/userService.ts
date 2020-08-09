/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { User } from './model/user'
import { v4 as uuidv4 } from 'uuid'
import { UserRepository } from './userRepository'
import { FavoritePhraseList, PhraseList, Phrase } from './model/phrase'

export class UserService {
  private readonly repo: UserRepository

  constructor(repo: UserRepository) {
    this.repo = repo
  }

  /**
   * 初期ユーザーを作成
   * @param uuid 
   * @param req 
   */
  static generateInitialUser (uuid: string): User {
    return {
      schemaVersion: 'v1',
      uuid: uuid,
      name: '',
      userId: uuid,
      favorites: {
        'default': UserService.generateFavoriteList('default', 'お気に入り', true)
      },
      notes: {},
      activities: [
        {
          schemaVersion: 'v1',
          content: 'ユーザーを作成しました',
          date: new Date(),
        }
      ],
      statistics:  {
        schemaVersion: 'v1',
        testScores: {},
        testLimitCount: 3,
        points: 0,
        memberShip: 'normal',
      },
      attributes: {
        schemaVersion: 'v1',
        email: '',
        age: '',
      }
    }
  }

  static generateFavoriteList(listId: string, title: string, isDefault: boolean = false): FavoritePhraseList {
    return {
      schemaVersion: 'v1',
      id: listId,
      isDefault: true,
      title: title,
      sortType: 'createdAt-',
      favoritePhraseIds: {},
    }
  }

  static generatePhrasesList(listId: string, title: string, isDefault: boolean = false): PhraseList {
    return {
      schemaVersion: 'v1',
      id: listId,
      isDefault: true,
      title: title,
      sortType: 'createdAt-',
      phrases: {},
    }
  }

  async existUser(uuid: string) {
    return this.repo.exists(uuid)
  }

  async updateUser(user: User): Promise<User> {
    return this.repo.update(user)
  }

  async createUser(uuid: string, name: string, email: string, age: string) {
    const user = UserService.generateInitialUser(uuid)
    user.name = name
    user.attributes.email = email
    user.attributes.age = age
    return this.repo.create(user)
  }

  async readUser(uuid: string): Promise<User> {
    return this.repo.findById(uuid)
  }

  async favoritePhrase (uuid: string, listId: string, phraseId: string, favorite: boolean) {
    const user = await this.repo.findById(uuid)

    if (!user.favorites[listId]) {
      throw `FavoriteList ${listId} not found`
    }

    if (favorite) {
      user.favorites[listId].favoritePhraseIds[phraseId] = {
        id: phraseId,
        createdAt: new Date()
      }
    } else {
      delete user.favorites[listId].favoritePhraseIds[phraseId]
    }
  
    await this.repo.update(user)
  }

  async createFavoriteList(uuid: string, title: string) {
    const user = await this.repo.findById(uuid)
    const listId = uuidv4()

    user.favorites[listId] = UserService.generateFavoriteList(listId, title)
    await this.repo.update(user)
  }

  async deleteFavoriteList(uuid: string, listId: string) {
    const user = await this.repo.findById(uuid)
    delete user.favorites[listId]
    await this.repo.update(user)
  }

  // TODO: user -> notes 以下に移動
  async createPhrasesList(uuid: string, title: string) {
    const user = await this.repo.findById(uuid)
    const listId = uuidv4()

    user.notes[listId] = UserService.generatePhrasesList(listId, title)
    await this.repo.update(user)
  }

  async addPhraseToPhraseList(uuid: string, listId: string, phrase: Phrase) {
    const user = await this.repo.findById(uuid)

    if (!user.notes[listId]) {
      throw `Note ${listId} not found`
    }

    user.notes[listId].phrases[phrase.id] = phrase
    await this.repo.update(user)
  }

  async deletePhrase(uuid: string, listId: string, phraseId: string) {
    const user = await this.repo.findById(uuid)

    if (!user.notes[listId]) {
      throw `Note ${listId} not found`
    }

    user.notes[listId].phrases[phraseId]
    await this.repo.update(user)
  }

  async deletePhraseList(uuid: string, listId: string) {
    const user = await this.repo.findById(uuid)
    delete user.notes[listId]
    await this.repo.update(user)
  }

  async getPoint (uuid: string, points: number) {
    const user = await this.repo.findById(uuid)

    if (user.statistics.points + points < 0) {
      throw 'Not enough points'
    }

    user.statistics.points += points
    user.activities.push({
      schemaVersion: 'v1',
      content: `${points} ポイント獲得`,
      date: new Date()
    })

    await this.repo.update(user)
  }

  async delete(uuid: string) {
    return await this.repo.remove(uuid)
  }

  async doTest(uuid: string, sectionId: string) {
    const user = await this.repo.findById(uuid)

    if (user.statistics.testLimitCount == 0) {
      throw 'Daily test limit exceeded'
    }

    user.statistics.testLimitCount -= 1
    user.activities.push({
      schemaVersion: 'v1',
      content: `${sectionId} のテストを受ける`,
      date: new Date()
    })

    await this.repo.update(user)
  }

  async SendTestResult(uuid: string, sectionId: string, score: number) {
    const user = await this.repo.findById(uuid)

    if (parseInt(user.statistics.testScores[sectionId] ?? '0') < score) {
      user.statistics.testScores[sectionId] = `${score}`
    }

    user.activities.push({
      schemaVersion: 'v1',
      content: `${sectionId} のテストで ${score} 点を獲得`,
      date: new Date()
    })

    await this.repo.update(user)
  }
}
