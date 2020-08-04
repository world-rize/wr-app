# Setup
## 🌴 Environments
### App
- [Android Studio 4.0](https://developer.android.com/studio/install?hl=ja)
- Xcode Version 11.5 (11E608c)
- [Flutter](https://flutter.dev/docs/get-started/install) (Channel dev, v1.16.1, on Mac OS X 10.15.3 19D76, locale ja-JP)

### Functions
- TypeScript 3.8.3
- node v10.20.1  
Firebaseにデプロイ

### Database
- Firebase Firestore

### Assets
- Google Drive
- [Woord API](https://www.getwoord.com/pages/text-to-speech-api)
- [Contentful](https://www.contentful.com/)

### Tools
- Python 3.8.1
- [rake](https://docs.ruby-lang.org/ja/latest/library/rake.html), version 12.3.2
- [n](https://github.com/tj/n) 2.1.12

### Services
- [codemagic](https://codemagic.io/start/)
  - アプリ用CI/CDサービス

## 👍 Get Started
### 1. `.env` をもらう
- **.env file** @ `./.env/.env`

### 2. Firebase credentials をダウンロード
<https://support.google.com/firebase/answer/7015592?hl=ja>

- **admin credentail** @ `./.env/credential.json`
- **web credential** @ `./.env/worldrize-9248e-d680634159a0.json`
- **android credential** `./android/app/google-services.json`
- **ios credential** `./ios/Runner/GoogleService-Info.plist`

### 3. Init Script
アセットとかがダウンロードされます

```bash
rake init # download & build assets
```

### 4. シミュレータ起動

### 5. 実行
```bash
rake dev # build & launch app
```

TODO: リリースのやり方書く