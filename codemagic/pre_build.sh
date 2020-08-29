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
echo "${FIREBASE_ANDROID_CREDENTIAL}" > ./android/app/google-services.json
echo "${FIREBASE_IOS_CREDENTIAL}" > ./ios/Runner/GoogleService-Info.plist
mkdir ./.env
echo $DOTENV > ./.env/.env

# Download assets
curl gdrive.sh | bash -s 1V_VL81ddzQbr3dtbEBpGOx_RX0uz5CEG
unzip -qq assets.zip
rm -rf ./assets.zip ./__MACOSX