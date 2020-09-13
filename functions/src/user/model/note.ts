/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { Phrase } from './phrase'

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
   * 単語
   */
  word: string

  /**
   * 訳
   */
  translation: string

  /**
   * achieved
   */
  achieved: boolean
}

/**
 * 任意のフレーズのリスト
 */
export interface Note {
  schemaVersion: 'v1'
  /**
   * Id
   */
  id: string

  /**
   * グループ名
   */
  title: string

  /**
   * 並び替えタイプ
   */
  sortType: string

  /**
   * デフォルトか
   */
  isDefault: boolean

  /**
   * フレーズ
   */
  phrases: NotePhrase[]
}