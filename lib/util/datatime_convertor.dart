// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

// <https://medium.com/@hasimyerlikaya/flutter-custom-datetime-serialization-with-jsonconverter-5f57f93d537>
class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String isoString) => DateTime.parse(isoString);

  @override
  String toJson(DateTime json) => json.toIso8601String();
}
