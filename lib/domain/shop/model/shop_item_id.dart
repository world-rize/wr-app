// Copyright © 2020 WorldRIZe. All rights reserved.

enum ShopItemId {
  accentIn,
  accentUk,
  accentUs,
  accentAu,
  amazon,
  iTunes,
  extraNote,
}

extension ShopItemIdEx on ShopItemId {
  // TODO: json codec時に変換
  static ShopItemId fromString(String id) {
    switch (id) {
      case 'accent_au':
        return ShopItemId.accentAu;
      case 'accent_uk':
        return ShopItemId.accentUk;
      case 'accent_us':
        return ShopItemId.accentUs;
      case 'accent_in':
        return ShopItemId.accentIn;
      case 'itunes':
        return ShopItemId.iTunes;
      case 'amazon':
        return ShopItemId.amazon;
      case 'extra_note':
        return ShopItemId.extraNote;
    }
    return null;
  }

  String get key {
    switch (this) {
      case ShopItemId.accentAu:
        return 'accent_au';
        break;
      case ShopItemId.accentUk:
        return 'accent_uk';
        break;
      case ShopItemId.accentUs:
        return 'accent_us';
        break;
      case ShopItemId.accentIn:
        return 'accent_in';
        break;
      case ShopItemId.iTunes:
        return 'itunes';
        break;
      case ShopItemId.amazon:
        return 'amazon';
        break;
      case ShopItemId.extraNote:
        return 'extra_note';
        break;
    }
  }
}
