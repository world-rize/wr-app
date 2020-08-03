#!/usr/bin/env bash
# referenced https://github.com/mono0926/intl_sample/blob/master/update_l10n.sh

DIR=lib/i10n
flutter packages pub run intl_translation:extract_to_arb \
    --locale=messages \
    --output-dir=$DIR \
    $DIR/messages.dart

cat $DIR/intl_messages.arb | \
    sed -e 's/"@@locale": "messages"/"@@locale": "ja"/g' > \
    $DIR/intl_ja.arb

flutter packages pub run intl_translation:generate_from_arb \
    --output-dir=$DIR \
    --no-use-deferred-loading \
    $DIR/messages.dart \
    $DIR/intl_*.arb