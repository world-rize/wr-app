#!/bin/bash
set -exuo pipefail

# sedでpubspec.yamlのversionを置き換えるスクリプト

echo "next version is $1"

sed -i 's/version: .*/version: '$1'/' pubspec.yaml
cat pubspec.yaml

# 1.2.3-beta.4を1.2.3-beta+4に置き換える
sed -i 's/\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)-\(.*\)\.\([0-9]*\)/\1.\2.\3-\4+\5/' pubspec.yaml
cat pubspec.yaml

