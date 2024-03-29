#!/bin/sh

# see <https://qiita.com/sensuikan1973/items/ab55d6a56033011350fc>

# NOTE: codemagic の UI から以下の環境変数をセットすること
#       • FLAVOR: "development" / "staging" / "production"
#       • CONFIGURATION: "Debug" / "Release"

set -e # exit on first failed commandset
set -x # print all executed commands to the log

echo "----- Using Environment Variables -----"
echo "CONFIGURATION: ${CONFIGURATION}"
echo "FLAVOR: ${FLAVOR}"

# Provisioning Profile の解決をする際に合致しないIDを取ってきてしまう件の対策
# /usr/bin/plutil -replace CFBundleIdentifier -string "com.done.sensuikan1973.sample.${FLAVOR}" ios/Runner/Info.plist

# xcodebuid の際に決め打ちで -scheme Runner -config Release のオプションが与えられちゃってる件の対策
cp "ios/Flutter/${CONFIGURATION}-${FLAVOR}.xcconfig" ios/Flutter/Release-production.xcconfigs