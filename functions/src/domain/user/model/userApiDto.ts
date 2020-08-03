import { User } from './user'

export interface TestRequest {}
export interface TestResponse {
  success: boolean
}
export interface ReadUserRequest {}
export interface ReadUserResponse {
  user: User
}
export interface CreateUserRequest {
  name: string
  email: string
  age: string
}

export interface CreateUserResponse {
  user: User
}

export interface UpdateUserRequest {
  user: User
}

export interface UpdateUserResponse {
  user: User
}

export interface FavoritePhraseRequest {
  phraseId: string
  value: boolean
}

export interface FavoritePhraseResponse {
  success: boolean
}

export interface GetPointRequest {
  uuid: string
  point: number
}

export interface GetPointResponse {
  success: boolean
}
export interface DoTestRequest {}
export interface DoTestResponse {
  success: boolean
}

export interface DeleteUserRequest {}
export interface DeleteUserResponse {
  success: boolean
}