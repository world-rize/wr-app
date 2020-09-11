/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { Note } from './note'
import { FavoritePhraseList } from './phrase'

export interface UserActivity {
  schemaVersion: 'v1'
  content: string
  date: string
}

// テストの記録
export interface TestResult {
  sectionId: string
  score: number
  date: string
}

/**
 * 統計情報
 */
export interface UserStatistics {
  schemaVersion: 'v1'
  /**
   * テストの成績
   */
  testResults: TestResult[]

  /**
   * ポイント
   */
  points: number

  /**
   * テスト受講可能回数
   */
  testLimitCount: number

  /**
   * 最終ログイン日時
   */
  lastLogin: string
}

export interface UserAttributes {
  schemaVersion: 'v1'

  age: string

  email: string

  /**
   * メンバーシップ
   */
  memberShip: 'normal' | 'pro'
}

export interface User {
  schemaVersion: 'v1'

  /**
   * firebase UUID
   */
  uuid: string

  /**
   * ユーザー名, 変更可能
   */
  name: string

  /**
   * ユーザーID, 
   */
  userId: string

  /**
   * お気に入りフレーズ(key: listId, value: list)
   */
  favorites: Record<string, FavoritePhraseList>

  /**
   * オリジナルフレーズ(key: listId, value: list)
   */
  notes: Record<string, Note>

  /**
   * 統計
   */
  statistics: UserStatistics

  /**
   * 個人情報(年代等)
   */
  attributes: UserAttributes

  /**
   * ユーザーの活動履歴(ポイント獲得等)
   */
  activities: UserActivity[]

  /**
    所持アイテム
  */
 items: Record<string, number>
}
