# User API
- [test](##test)
- [readUser](##readUser)
- [createUser](##createUser)
- [favoritePhrase](##favoritePhrase)
- [getPoint](##getPoint)
- [doTest](##doTest)

## test
```
```

## readUser
```ts
interface ReadUserRequest {}
interface ReadUserResponse {
  user: User
}
```

## createUser
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

## favoritePhrase
```ts
interface FavoritePhraseRequest {
  phraseId: string
  value: boolean
}

interface FavoritePhraseResponse {
  success: boolean
}
```

## getPoint
```ts
interface GetPointRequest {
  uuid: string
  point: number
}

interface GetPointResponse {
  success: boolean
}
```

## doTest
```
interface DoTestRequest {}
interface DoTestResponse {}
```