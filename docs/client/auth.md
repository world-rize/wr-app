# 認証・ユーザーデータ
## 参考issues
- [#445 データマイグレーション](https://github.com/worldrize/wr-app/issues/445)

## 用語
- `signIn`: Firebase Authenticationで認証すること
- `signUp`: Firebase Authenticationでユーザーアカウントを作成すること
- `signInWithXXX/signUpWithXXX`: `XXX` を用いたsignIn/signUp(`XXX` は認証方法(Apple, Google, EmailAndPassword))
- `login`: アプリを利用可能するための諸処理(ユーザーデータ取得等)のこと
- `fbUser`: Firebase Authenticationのユーザーアカウントのこと
- `User`: ユーザーデータのこと

## 認証フロー
### signUp
- オンボーディングページ(`presentation/on_boarding/sign_up_page.dart`)
1. Sign Upボタンが押されたら `AuthNotifier.signUpWithXXX` が呼ばれる.
2. `AuthNotifier.signUpWithXXX` は `AuthService.signUpXXX` を呼ぶ.
3. `AuthService.signUpXXX` は Firebase Authenticationのユーザーアカウントを作成(今はUserも内部で作ってしまっている)
4. `AuthNotifier.signUpXXX` はそのユーザーアカウントのuidを利用してUserを作成しNotifier内部のuserを更新.(本当はstoreにUserを持つなりしてそれを更新すべき([#452 ViewModelとしてのNotifierとストアとしてのNotifier](https://github.com/worldrize/wr-app/issues/452)))
5. チュートリアルページに移動, その後 RootViewへ

- ルートページ(`presentation/root_view.dart`)
1. 描画後(`WidgetsBinding.instance.addPostFrameCallback((_) => onPageLoaded())`), ユーザーチェック(`_checkUserStatus()`)とアプリチェック(`_checkAppStatus()`) を行う
2. signInしているなら(`AuthNotifier.isAlreadySignedIn()`) ログイン処理(`AuthNotifier.login()`)を行う.
3. `AuthNotifier.login()` ではユーザーデータのマイグレーション, ユーザーデータの取得, ログイン時処理(スタミナの回復, ログイン更新)を行う.

### signIn
- ルートページ(`presentation/root_view.dart`)
#### `AuthNotifier.isAlreadySignedIn()`
`AuthRepositoty.isAlreadySignedIn()` は FirebaseAuth.authStateChanges() を確認する.
Firebase Authenticationは一定時間(どのくらい?)認証情報がキャッシュされるので前回ログインしているなら
FirebaseAuth.currentUser にはユーザーアカウントの情報が入っているし, FirebaseAuth.authStateChanges() もそれがある.

1. 起動時 `AuthNotifier.isAlreadySignedIn()` が trueなのでログイン処理(`AuthNotifier.login()`)を行う.

## マイグレーション
- メジャーバージョンごとにスキーマが変わっても良い
- ひとつ前のバージョンから今のバージョンに変換するコードを書く
- 構造自体が変わる可能性もあるのでモデル毎でなくバージョン毎にマイグレーション
- ユーザーデータはユーザー自身が実行, マスターデータはCI or 手動で実行

```
class UserV0 {}

class UserV1 {}

class User {}

Future migrateUserDataFromV0(String uid) async {
  if (await existUser(v1)) {
    return users.get(v1);
  } else {
    final UserV0 userv0 = db.get();
    final List<NoteV0> notesv0 = db.get();
    ...

    // convert
    final userv1 = UserV1(name: userv0.name, ...);
    ...

    // update
    await db.set(userv1);
    await db.set(notesv1);
    ...
  }
}

Future<User> migrateUserDataFromV1(String uid) async {
  if (await existUser(v2)) {
    return db.get(v2);
  } else {
    await migrateUserDataFromV0(uid);

    final UserV1 userv1 = get();
    // convert
    return User(name: userv1.name, ...);
  }
}
...

Future migrationUserData(String uid) async {
  // pre latest version
  await migrateUserDataFromV1(uid);
}

Future migrationMasterData() async {
  // pre latest version
  await migrateMasterDataFromV1();
}
```