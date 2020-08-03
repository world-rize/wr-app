# WorldRIZe English
[![Codemagic build status](https://api.codemagic.io/apps/5e78acb1064d84000c741bf5/5e78acb1064d84000c741bf4/status_badge.svg)]()

## 🌴 Environments
### App
- Android Studio 4.0
- Xcode Version 11.5 (11E608c)
- Flutter (Channel dev, v1.16.1, on Mac OS X 10.15.3 19D76, locale ja-JP)

### Functions
- TypeScript 3.8.3
- node v10.20.1

### Tools
- Python 3.8.1
- [rake](https://docs.ruby-lang.org/ja/latest/library/rake.html), version 12.3.2
- [n](https://github.com/tj/n) 2.1.12

## 👍 Get Started
### 1. get `.env`
- **.env file** @ `./.env/.env`

### 2. Firebase credentials
<https://support.google.com/firebase/answer/7015592?hl=ja>

- **admin credentail** @ `./.env/credential.json`
- **web credential** @ `./.env/worldrize-9248e-d680634159a0.json`
- **android credential** `./android/app/google-services.json`
- **ios credential** `./ios/Runner/GoogleService-Info.plist`

### 3. Init Script
```bash
rake init # download & build assets
# open iOS/Android simulator
rake dev # build & launch app
```

## 📚 Documents(WIP)
[WR英会話 仕様書](https://docs.google.com/presentation/d/1Ah7lpa6Ici46kYndBFYTSzLDet39uR1AO9_nW7u72iI/edit?usp=sharing)

### 📱 Client
### 🎨 UI
[Client views](view.md)

### 🔥 Functions
(WIP)

### ⚙ CI/CD
[CI/CD](cicd.md)

### 📚 Contents
[Contents](contents.md)