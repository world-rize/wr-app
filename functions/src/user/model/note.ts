/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { Phrase } from './phrase'

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
   * フレーズ(key: phraseId, value: phrase)
   */
  phrases: Record<string, Phrase>
}