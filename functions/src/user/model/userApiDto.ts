/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */
import { IsNotEmpty, MaxLength, IsEmail } from 'class-validator'
import { User } from './user'

export class TestRequest {}

export interface TestResponse {
  success: boolean
}


export class ReadUserRequest {}

export interface ReadUserResponse {
  user: User
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

export interface CreateUserResponse {
  user: User
}


export class UpdateUserRequest {
  user!: User
}

export interface UpdateUserResponse {
  user: User
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

export interface FavoritePhraseResponse {
  success: boolean
}

export class GetPointRequest {
  @IsNotEmpty()
  readonly uuid!: string

  @IsNotEmpty()
  readonly point!: number
}

export interface GetPointResponse {
  success: boolean
}

export class DoTestRequest {
  sectionId!: string
}
export interface DoTestResponse {
  success: boolean
}

export class DeleteUserRequest {}
export interface DeleteUserResponse {
  success: boolean
}