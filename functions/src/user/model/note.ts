/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
*/
/**
 * ノートのフレーズのモデル
 */
export interface NotePhrase {
  schemaVersion: 'v1'

  /**
   * id
   */
  id: string

  /**
   * 英語
   */
  english: string

  /**
   * 日本語
   */
  japanese: string

  /**
   * 作成日時
   */
  createdAt: string
}

/**
 * 編集可能なフレーズのリスト
 */
export interface Note {
  schemaVersion: 'v1'
  /**
   * Id
   */
  id: string

  /**
   * ノート名
   */
  title: string

  /**
   * 並び替えタイプ
   */
  sortType: string

  /**
   * デフォルトか
   */
  isDefaultNote: boolean

  /**
   * Achieved Note か
   */
  isAchievedNote: boolean

  /**
   * フレーズ
   */
  phrases: NotePhrase[]
}