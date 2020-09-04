#!/bin/sh

# see
# <https://qiita.com/sensuikan1973/items/ab55d6a56033011350fc>
# <https://medium.com/@riscait/building-and-delivering-a-flavor-enabled-flutter-app-using-codemagic-5225a6070224>

set -ex

# Workaround for issue #21335
/usr/bin/plutil -replace CFBundleIdentifier -string com.worldrize.app ios/Runner/Info.plist

# NOTE: codemagic の UI から以下の環境変数をセットすること
#   FIREBASE_ANDROID_CREDENTIAL: @ ./android/app/google-services.json
#   FIREBASE_IOS_CREDENTIAL: @ ./ios/Runner/GoogleService-Info.plist
<<<<<<< HEAD
<<<<<<< Updated upstream
echo $FIREBASE_ANDROID_CREDENTIAL > ./android/app/google-services.json
echo $FIREBASE_IOS_CREDENTIAL > ./ios/Runner/GoogleService-Info.plist
=======
echo "${FIREBASE_ANDROID_CREDENTIAL}" > ./android/app/google-services.json
echo "${FIREBASE_IOS_CREDENTIAL}" > ./ios/Runner/GoogleService-Info.plist
mkdir ./secrets
echo $DOTENV > ./secrets/.env
>>>>>>> Stashed changes
=======
echo "${FIREBASE_ANDROID_CREDENTIAL}" > ./android/app/google-services.json
echo "${FIREBASE_IOS_CREDENTIAL}" > ./ios/Runner/GoogleService-Info.plist
mkdir -p secrets
echo "${DOTENV}" > secrets/.env

# read .env
export $(egrep -v '^#' secrets/.env | xargs)
>>>>>>> 46cb3a4c33db2b9f5e65486e60eacf425544e47e

# Download assets
curl gdrive.sh | bash -s 1V_VL81ddzQbr3dtbEBpGOx_RX0uz5CEG
unzip -qq assets.zip
rm -rf ./assets.zip ./__MACOSX