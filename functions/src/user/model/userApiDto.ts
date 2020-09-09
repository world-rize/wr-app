/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { IsNotEmpty, MaxLength, IsEmail } from 'class-validator'

export class DoTestRequest {
  @IsNotEmpty()
  readonly sectionId!: string
}

export class CreateUserRequest {
  @MaxLength(12)
  @IsNotEmpty()
  readonly name!: string

  @IsEmail()
  @IsNotEmpty()
  readonly email!: string

  @IsNotEmpty()
  readonly age!: string
}

export class FavoritePhraseRequest {
  /**
   * フレーズID
   */
  @IsNotEmpty()
  readonly phraseId!: string

  /**
   * リストID
   */
  @IsNotEmpty()
  readonly listId!: string

  /**
   * true: お気に入りに追加, false: お気に入りから削除
   */
  @IsNotEmpty()
  readonly favorite!: boolean
}

export class GetPointRequest {
  @IsNotEmpty()
  readonly points!: number
}

export class CreateFavoriteListRequest {
  @IsNotEmpty()
  readonly name!: string
}

export class DeleteFavoriteListRequest {
  @IsNotEmpty()
  readonly listId!: string
}

export class DeletePhraseRequest {
  @IsNotEmpty()
  readonly listId!: string

  @IsNotEmpty()
  readonly phraseId!: string
}

export class SendTestResultRequest {
  @IsNotEmpty()
  readonly sectionId!: string

  @IsNotEmpty()
  readonly score!: number
}

export class FindUserByUserIdRequest {
  @IsNotEmpty()
  readonly userId!: string
}