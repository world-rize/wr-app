/**
 * Copyright © 2020 WorldRIZe. All rights reserved.
 */

export interface User {
  // firebase UUID
  uuid: string
  // user name
  name: string
  // user id
  userId: string
  // WR point
  point: number,
  // favorite phrase ids
  favorites: Record<string, boolean>
  // email
  email: string
  // age
  age: string
}
