# Functions API
## User
- [test](#test)
- [readUser](#readUser)
- [createUser](#createUser)
- [favoritePhrase](#favoritePhrase)
- [getPoint](#getPoint)
- [doTest](#doTest)

### [WIP] test
```
```

### [WIP] readUser
```ts
interface ReadUserRequest {}
interface ReadUserResponse {
  user: User
}
```

### [WIP] createUser
```ts
export interface CreateUserRequest {
  uuid: string
  name: string
  userId: string
  email: string
  age: string
}

interface CreateUserResponse {
  user: User
}
```

### [WIP] favoritePhrase
```ts
interface FavoritePhraseRequest {
  phraseId: string
  value: boolean
}

interface FavoritePhraseResponse {
  success: boolean
}
```

### [WIP] getPoint
```ts
interface GetPointRequest {
  uuid: string
  point: number
}

interface GetPointResponse {
  success: boolean
}
```

### [WIP] doTest
```
interface DoTestRequest {}
interface DoTestResponse {}
```