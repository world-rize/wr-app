/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { User } from './model/user'
import moment from 'moment'
import _ from 'lodash'
import { v4 as uuidv4 } from 'uuid'
import { NoteService } from './noteService'
import { UserRepository } from './userRepository'
import { FavoritePhraseList } from './model/phrase'
import { firestore } from 'firebase-admin'
import shortid from 'shortid'
import * as functions from 'firebase-functions'
import { GiftItem } from './model/item'

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
    const defaultFavoriteList = UserService.generateFavoriteList(uuidv4(), 'お気に入り', true)
    const defaultNote = NoteService.generateNote(uuidv4(), 'ノート', true, false)
    const achievedNote = NoteService.generateNote(uuidv4(), 'Achieved Note', false, true)

    return {
      schemaVersion: 'v1',
      uuid: uuid,
      name: '',
      userId: shortid.generate(),
      favorites: {
        [defaultFavoriteList.id]: defaultFavoriteList,
      },
      notes: {
        [defaultNote.id]: defaultNote,
        [achievedNote.id]: achievedNote,
      },
      activities: [
        {
          schemaVersion: 'v1',
          content: 'ユーザーを作成しました',
          date: moment().toISOString(),
        }
      ],
      statistics:  {
        schemaVersion: 'v1',
        testResults: [],
        testLimitCount: 3,
        points: 0,
        lastLogin: moment().toISOString(),
        isIntroducedFriend: false,
      },
      attributes: {
        schemaVersion: 'v1',
        email: '',
        age: '',
        memberShip: 'normal',
      },
      items: {},
    }
  }

  static generateFavoriteList(listId: string, title: string, isDefault: boolean = false): FavoritePhraseList {
    return {
      schemaVersion: 'v1',
      id: listId,
      isDefault: true,
      title: title,
      sortType: 'createdAt-',
      phrases: [],
    }
  }

  async existUser(uuid: string): Promise<boolean> {
    return this.repo.exists(uuid)
  }

  async updateUser(user: User): Promise<User> {
    return this.repo.update(user)
  }

  async createUser(uuid: string, name: string, email: string, age: string): Promise<User> {
    const user = UserService.generateInitialUser(uuid)
    user.name = name
    user.attributes.email = email
    user.attributes.age = age
    return this.repo.create(user)
  }

  async readUser(uuid: string): Promise<User> {
    return this.repo.findById(uuid)
  }

  async login(uuid: string): Promise<User> {
    const user = await this.repo.findById(uuid)

    // テスト受講可能回数回復
    // TODO: これをseviceに
    if (user.statistics.lastLogin) {
      const lastLogin = moment(user.statistics.lastLogin)
      if (lastLogin.startOf('day') < moment()) {
        user.statistics.testLimitCount = 3
      }
    }

    // 昨日テスト3回してなかったらstreakリセット


    user.activities.push({
      schemaVersion: 'v1',
      content: 'ログインしました',
      date: moment().toISOString(),
    })
    user.statistics.lastLogin = moment().toISOString()
    return this.repo.update(user);
  }

  async favoritePhrase (uuid: string, listId: string, phraseId: string, favorite: boolean): Promise<User> {
    const user = await this.repo.findById(uuid)
    if (!user.favorites[listId]) {
      throw new functions.https.HttpsError('not-found', `favorite list ${listId} not found`)
    }

    const index = user.favorites[listId].phrases.findIndex(p => p.id == phraseId)
    if (favorite) {
      if (index === -1) {
        user.favorites[listId].phrases.push({
          id: phraseId,
          createdAt: moment().toISOString(),
        })
      } else {
        user.favorites[listId].phrases[index] = {
          id: phraseId,
          createdAt: moment().toISOString(),
        }
      }
    } else {
        user.favorites[listId].phrases.splice(index, 1)
    }
  
    return this.repo.update(user)
  }

  async createFavoriteList(uuid: string, title: string): Promise<User> {
    const user = await this.repo.findById(uuid)
    const listId = uuidv4()

    user.favorites[listId] = UserService.generateFavoriteList(listId, title)
    return this.repo.update(user)
  }

  async deleteFavoriteList(uuid: string, listId: string): Promise<User> {
    const user = await this.repo.findById(uuid)
    delete user.favorites[listId]
    return this.repo.update(user)
  }

  async getPoint (uuid: string, points: number): Promise<User> {
    const user = await this.repo.findById(uuid)

    if (user.statistics.points + points < 0) {
      throw new functions.https.HttpsError('resource-exhausted', 'not enough points')
    }

    user.statistics.points += points
    user.activities.push({
      schemaVersion: 'v1',
      content: `${points} ポイント獲得`,
      date: moment().toISOString(),
    })

    return this.repo.update(user)
  }

  async delete(uuid: string) {
    return await this.repo.remove(uuid)
  }

  async doTest(uuid: string, sectionId: string): Promise<User> {
    const user = await this.repo.findById(uuid)

    if (user.statistics.testLimitCount == 0) {
      throw new functions.https.HttpsError('unavailable', 'daily test limit exceeded')
    }

    user.statistics.testLimitCount -= 1
    user.activities.push({
      schemaVersion: 'v1',
      content: `${sectionId} のテストを受ける`,
      date: moment().toISOString(),
    })

    return this.repo.update(user)
  }

  async checkTestStreaks(uuid: string): Promise<boolean> {
    const user = await this.repo.findById(uuid)

    // 29日前の0時
    const begin = moment().startOf('day').subtract(29, 'days')

    // 過去30日間のstreakを調べる
    const streaked = _(user.statistics.testResults)
      .filter(result => moment(result.date).isAfter(begin))
      .groupBy(result => moment(result.date).startOf('day'))
      .values()
      // 1日ごとのグループ
      .every(d => d.length >= 3)
    return streaked
  }

  async sendTestResult(uuid: string, sectionId: string, score: number): Promise<User> {
    const user = await this.repo.findById(uuid)

    // 記録追加
    user.statistics.testResults.push({
      sectionId,
      score,
      date: moment().toISOString(),
    })

    user.activities.push({
      schemaVersion: 'v1',
      content: `${sectionId} のテストで ${score} 点を獲得`,
      date: moment().toISOString(),
    })

    return this.repo.update(user)
  }

  async findUserByUserId(userId: string): Promise<User> {
    const user = await this.repo.findByUserId(userId)
    if (!user) {
      throw new functions.https.HttpsError('not-found', 'user not found')
    }
    return user
  }

  async introduceUser(uuid: string, introducedUserId: string): Promise<void> {
    const introducer = await this.repo.findById(uuid)
    if (!introducer) {
      throw new functions.https.HttpsError('not-found', 'introducer not found')
    }
    const introducee = await this.repo.findByUserId(introducedUserId)
    if (!introducee) {
      throw new functions.https.HttpsError('not-found', 'introducee not found')
    }

    // pro plan ?
    if (introducee.attributes.memberShip != 'pro') {
      throw new functions.https.HttpsError('unavailable', 'introducee must be pro membership')
    }

    // already introduced ?
    if (introducee.statistics.isIntroducedFriend) {
      throw new functions.https.HttpsError('unavailable', 'introducee must be pro membership')
    }

    await firestore().runTransaction(async tx => {
      // introducee -> +10000
      // introducer -> +500
      introducee.statistics.points += 10000
      introducee.statistics.isIntroducedFriend = true
      introducer.statistics.points += 500

      tx.update(this.repo.users.doc(introducer.uuid), introducer)
      tx.update(this.repo.users.doc(introducee.uuid), introducee)
    })
  }

  // TODO: shop service
  async getShopItems (): Promise<GiftItem[]> {
    const shop = firestore().collection('shop')
    return (await shop.get()).docs.map(d => d.data() as GiftItem)
  }
}
