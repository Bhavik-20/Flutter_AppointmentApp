import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefHelper {

  static setStringPref(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static getStringPref(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static setIntPref(String key, int message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, message);
  }

  static getIntPref(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  static removePref(String key) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}