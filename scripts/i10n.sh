#!/usr/bin/env bash
# referenced https://github.com/mono0926/intl_sample/blob/master/update_l10n.sh

# arbファイル(文言リソースのJSONファイル)の作成
DIR=lib/i10n
# flutter -> arb
flutter packages pub run intl_translation:extract_to_arb \
    --locale=messages \
    --output-dir=$DIR \
    $DIR/messages.dart

# 生成された雛形のintl_messages.arbをコピーしてintl_ja.arbを作成
# 警告抑制のため、@@localeだけ指定
# 言語リソースが見つからなかったらIntl.messageに指定されている文言が使われるので
# デフォルト文言のarbは不要かも
cat $DIR/intl_messages.arb | \
    sed -e 's/"@@locale": "messages"/"@@locale": "ja"/g' > \
    $DIR/intl_ja.arb


# このタイミングで、必要に応じて、メインの言語以外のarbファイルを用意

# arbファイル群から多言語対応に必要なクラスを生成
flutter packages pub run intl_translation:generate_from_arb \
    --output-dir=$DIR \
    --no-use-deferred-loading \
    $DIR/messages.dart \
    $DIR/intl_*.arb