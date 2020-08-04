# CI/CD
## 🌴 Branches
環境名のブランチにプッシュするとデプロイされるようにしたい

- develop  
Run `development` build on ~codemagic~
- staging
Run `staging` build on ~codemagic~
- master
Run `production` build on ~codemagic~

## TODOs
- 自動テスト
- codemagicからApp Storeにデプロイ

## 🔥 Firebase environments
- Staging

- Production(WIP)

## 🍦 Flavors
種類 | ビルドモード | Flavor | Configuration名
:--- | :--- | :--- | :---
開発 | Debug | Development | Debug-Development
テスト | Release | Staging | Release-Staging
リリース | Release | Production | Release-Production