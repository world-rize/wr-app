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
mkdir secrets
echo "${DOTENV}" > secrets/.env


# read .env
export $(egrep -v '^#' secrets/.env | xargs)

# Download assets
curl gdrive.sh | bash -s ${ASSETS_GDRIVE_ID}
unzip -qq assets.zip
rm -rf ./assets.zip ./__MACOSX