# CI/CD
## 🔒 Secrets
### `setup.sh`
- `secrets/.env` (dev), `secrets/.env.prod`(prod)
- `secrets/credential.json`(dev)
- `secrets/worldrize.json`(dev)
- `android/app/google-services.json`(dev)
- `ios/Runner/GoogleService-Info.plist`(dev)
を生成

## 🌴 Branches
環境名のブランチにプッシュするとデプロイされるようにしたい

- develop(TODO)
Run tests on ~codemagic~
- staging
Run `staging` build on ~codemagic~
- master
Run `production` build on ~codemagic~

## 🎵 Codemagic
### Staging
#### name
- `CI/CD Staging`

#### Build triggers
- `Include source: staging`

#### Environmrnt variables
- `FCI_FLUTTER_SCHEME`: `"Staging"`
- `FIREBASE_IOS_CREDENTIAL`: `<staging ios credential>`
- `FIREBASE_ANDROID_CREDENTIAL`: `<staging android credential>`

#### Build
- `Flutter version`: `channel Stable`
- `Xcode version`: `Latest(11.6)`
- `CocoaPods version`: `Default`
- `Android build format`: `Android app bundle`
- `Mode`: `Release`
- `Build arguments`
  - `Android`: `--flavor staging -t lib/main_staging.dart --build-number=$BUILD_NUMBER`
  - `iOS`: `--flavor staging -t lib/main_staging.dart --build-number=$BUILD_NUMBER`

#### Publish
- `Android code signing`: **disabled(TODO)**
- `iOS code signing`:
  - `Select code signing method`: `Automatic`
  - `App Store Connect API key`: `<wrenglish>`
  - `Provisioning profile type`: `App store`
  - `Bundle identifier`: `com.worldrize.app`
- `Slack`:
  - `Channel`: `#bot`
- `App Stone  Connect`: enabled
  - `App-specific password`: [from here](https://appleid.apple.com/#!&page=signin)

### Production
#### name
- `CI/CD Production`

#### Build triggers
- `Include source: master`

#### Environmrnt variables
- `FIREBASE_IOS_CREDENTIAL`: `<production ios credential>`
- `FIREBASE_ANDROID_CREDENTIAL`: `<production android credential>`

#### Build
- `Flutter version`: `channel Stable`
- `Xcode version`: `Latest(11.6)`
- `CocoaPods version`: `Default`
- `Android build format`: `Android app bundle`
- `Mode`: `Release`
- `Build arguments`
  - `Android`: (TODO) `--flavor production -t lib/main.dart --build-number=$BUILD_NUMBER`
  - `iOS`: `--flavor production -t lib/main.dart --build-number=$BUILD_NUMBER`

#### Publish
- `Android code signing`: **disabled(TODO)**
- `iOS code signing`:
  - `Select code signing method`: `Automatic`
  - `App Store Connect API key`: `<wrenglish>`
  - `Provisioning profile type`: `App store`
  - `Bundle identifier`: `com.worldrize.app`
- `Slack`:
  - `Channel`: `#bot`
- `App Stone  Connect`: enabled
  - `App-specific password`: [from here](https://appleid.apple.com/#!&page=signin)


## GCP Projects
- Staging
`wr-english-dev`

- Production
`wr-english-prd`

## 🍦 Xcode Flavors
種類 | ビルドモード | Flavor | Configuration名
:--- | :--- | :--- | :---
開発 | Debug | Development | Debug-Development
テスト | Release | Staging | Release-Staging
リリース | Release | Production | Release-Production