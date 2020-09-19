/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
export interface WRAppInfo {
  /**
   * 現在のバージョン
   */
  currentVersion: string

  /**
   * 必要なバージョン
   */
  requireVersion: string

  /**
   * iOS メンテナンス中か
   */
  isIOsAppAvailable: boolean

  /**
   * Android メンテナンス中か
   */
  isAndroidAppAvailable: boolean
}