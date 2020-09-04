/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */

export type SortType = 'createdAt+' | 'createdAt-'

/**
 * フレーズの音声や画像のパス
 */
export interface Assets {
  /**
   * 音声(key: locale, value: path)
   */
  voice: Record<string, string>
}

/**
 * フレーズの会話例
 */
export interface PhraseExample {
  /**
   * 会話リスト
   */
  value: PhraseExampleMessage[]
}

/**
 * フレーズの会話
 */
export interface PhraseExampleMessage {
  /**
   * 会話
   */
  text: Record<string, string>

  /**
   * 音声
   */
  assets: Assets
}

/**
 * フレーズ
 */
export interface Phrase {
  /**
   * フレーズID
   */
  id: string

  /**
   * タイトル(key: locale, value: title)
   */
  title: Record<string, string>

  /**
   * メタ情報
   */
  meta: Record<string, unknown>

  /**
   * アセット
   */
  assets: Assets,

  /**
   * アドバイス(key: locale, value: content)
   */
  advice: Record<string, string>
  
  /**
   * 例
   */
  example: PhraseExampleMessage
}

export interface FavoritePhraseDigest {
  /**
   * フレーズID
   */
  id: string

  /**
   * お気に入りした日時
   */
  createdAt: string
}

/**
 * お気に入りしたフレーズのリスト
 */
export interface FavoritePhraseList {
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
  sortType: SortType

  /**
   * デフォルトか
   */
  isDefault: boolean

  /**
   * フレーズ(key: phraseId, value: FavoritePhraseDigest)
   */
  favoritePhraseIds: Record<string, FavoritePhraseDigest>
}