// Copyright © 2020 WorldRIZe. All rights reserved.

enum GiftItemId {
  accentIn,
  accentUk,
  accentUs,
  accentAu,
  amazon,
  iTunes,
  extraNote,
}

extension GiftItemIdEx on GiftItemId {
  // TODO: json codec時に変換
  static GiftItemId fromString(String id) {
    switch (id) {
      case 'accent_au':
        return GiftItemId.accentAu;
      case 'accent_uk':
        return GiftItemId.accentUk;
      case 'accent_us':
        return GiftItemId.accentUs;
      case 'accent_in':
        return GiftItemId.accentIn;
      case 'itunes':
        return GiftItemId.iTunes;
      case 'amazon':
        return GiftItemId.amazon;
      case 'extra_note':
        return GiftItemId.extraNote;
    }
    return null;
  }

  String get key {
    switch (this) {
      case GiftItemId.accentAu:
        return 'accent_au';
        break;
      case GiftItemId.accentUk:
        return 'accent_uk';
        break;
      case GiftItemId.accentUs:
        return 'accent_us';
        break;
      case GiftItemId.accentIn:
        return 'accent_in';
        break;
      case GiftItemId.iTunes:
        return 'itunes';
        break;
      case GiftItemId.amazon:
        return 'amazon';
        break;
      case GiftItemId.extraNote:
        return 'extra_note';
        break;
    }
  }
}
