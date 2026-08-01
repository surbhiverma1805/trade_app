import 'dart:convert';

import 'package:trade_app/exports/exports.dart';

/// It will contain all the methods of SharedPreferences with keys used to access
/// data stored in SharedPreferences
class SharedPre {
  static const String storageKey = 'saved_watchlists';

  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<bool> getBoolValue(
    String key, {
    bool defaultValue = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<String> getStringValue(
    String key, {
    String defaultValue = "",
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<bool> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  /// call this method like this
  ///  LoginData data=LoginData.fromJson(loginresponse.data.tojson())
  /// sp.setObj("",data);
  static Future<bool> setObj(String key, var toJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(toJson);
    return await prefs.setString(key, user);
  }

  /// call this method like this
  ///var data= sp.getObj("key);
  ///Login loginData= Logindata.fromjson(data);
  static Future<Map<String, dynamic>> getObj(String key) async {
    Map<String, dynamic> json = {};
    if (key.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String str = prefs.getString(key) ?? "";
      if (str.isNotEmpty) {
        json = jsonDecode(str);
      }
      json;
    }
    return json;
  }
}

extension ShareString on String {
  Future<String> getStringValue({String defaultValue = ""}) {
    return SharedPre.getStringValue(this, defaultValue: defaultValue);
  }
}
