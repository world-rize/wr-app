# User API
## login
最終ログイン日時を更新

## test
デバッグ用


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

# Note API
無料ユーザーは3つまで

```
note: {
    isDefault: boolean
    title: string
    noteId: string
    phrases: Record<string, Phrase>
}
```

## createNote(userId: string, title: string): Note
ノートを作成
3つ以上あったら作れない

## updateNoteTitle(userId: string, noteId: string, title: string): Note
ノートのタイトルを変更

## updateDefaultNote(userId: string, noteId: string): Note
isDefaultを変更
元のdefaultノートのisDefaultをはずす

## deleteNote(userId: string, noteId: string): void
ノートを削除

## addPhraseInNote(noteId: string, phrase: Phrase): Note
ノートにフレーズを追加

## updatePhraseInNote(noteId: string, phraseId: string, phrase: Phrase): Note
ノートのフレーズを更新

## deletePhraseInNote(noteId: string, phraseId: string): void
ノートのフレーズを削除