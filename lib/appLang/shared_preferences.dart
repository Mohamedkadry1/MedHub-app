// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class SharedPref {
//   static SharedPreferences get prefs => GetIt.instance.get<SharedPreferences>();
//   static const String _language = "language_code";
//
//   static String? getLanguage() {
//     return prefs.getString(_language);
//   }
//
//   static Future<void> setLanguage({required String lang}) async {
//     await prefs.setString(_language, lang);
//   }
//
// }
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences get prefs => GetIt.instance<SharedPreferences>();

  static const String _language = "language_code";

  static String? getLanguage() {
    return prefs.getString(_language);
  }

  static Future<void> setLanguage({required String lang}) async {
    await prefs.setString(_language, lang);
  }
}
