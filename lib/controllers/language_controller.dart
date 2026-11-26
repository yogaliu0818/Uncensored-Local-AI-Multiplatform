import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LanguageController extends GetxController {
  LanguageController({String? initialCode})
      : _locale = _parse(initialCode ?? 'zh_TW').obs;

  final Rx<Locale> _locale;
  Locale get locale => _locale.value;

  static Locale _parse(String code) {
    final parts = code.split('_');
    return Locale(parts.first, parts.length > 1 ? parts[1] : null);
  }

  Future<void> setLocale(Locale locale) async {
    _locale.value = locale;
    await Get.updateLocale(locale);
    final box = Hive.box('settings');
    await box.put('language_code',
        '${locale.languageCode}_${locale.countryCode ?? ''}'.replaceAll('_',
            locale.countryCode == null ? '' : '_'));
  }
}
