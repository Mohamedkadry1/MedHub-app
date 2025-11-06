// import 'package:flutter/material.dart';
// import 'package:grad_app/appLang/shared_preferences.dart';
//
// enum Languages { en, ar }
//
// class AppLanguage extends ChangeNotifier {
//   Languages _appLanguage = Languages.ar;
//
//   Languages get appLang => _appLanguage;
//
//   Future fetchLocale(BuildContext context) async {
//     if (SharedPref.getLanguage() == null) {
//       //   _appLanguage = Languages.values.firstWhereOrNull((lang) => View.of(context).platformDispatcher.locale.languageCode.contains(lang.name)) ?? _appLanguage;
//     } else {
//       _appLanguage = Languages.values
//           .firstWhere((lang) => lang.name == SharedPref.getLanguage());
//     }
//   }
//
//   Future changeLanguage({Languages? language}) async {
//     if (language == _appLanguage) return;
//     switch (language) {
//       case Languages.en:
//         _appLanguage = Languages.en;
//         break;
//       case Languages.ar:
//         _appLanguage = Languages.ar;
//         break;
//       case null:
//         _appLanguage =
//             _appLanguage == Languages.ar ? Languages.en : Languages.ar;
//         break;
//     }
//     await SharedPref.setLanguage(lang: _appLanguage.name);
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocale => _appLocale;

  Future<void> fetchLocale(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Localizations.localeOf(context);
      return;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
  }

  void changeLanguage(Locale type) async {
    final prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ar")) {
      _appLocale = const Locale("ar");
      await prefs.setString('language_code', 'ar');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
    }
    notifyListeners();
  }
}
