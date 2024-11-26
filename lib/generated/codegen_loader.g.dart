// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "setting": "Settings",
  "theme": "Dark Theme",
  "language": "Language",
  "en": "English",
  "ru": "Russian",
  "uz": "Uzbek"
};
static const Map<String,dynamic> ru = {
  "setting": "Настройки",
  "theme": "Темный режим",
  "language": "Язык",
  "en": "Английский",
  "ru": "Русский",
  "uz": "Узбекский"
};
static const Map<String,dynamic> uz = {
  "setting": "Sozlamalar",
  "theme": "Qorong'u Rejim",
  "language": "Til",
  "en": "Ingliz",
  "ru": "Rus",
  "uz": "O'zbek"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru, "uz": uz};
}
