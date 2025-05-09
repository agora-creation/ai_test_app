import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future showBottomUpScreen(BuildContext context, Widget widget) async {
  await showMaterialModalBottomSheet(
    expand: true,
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (context) => widget,
  );
}

Future<String> getVersionInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var text = '${packageInfo.version}(${packageInfo.buildNumber})';
  return text;
}

Future<int?> getPrefsInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

Future setPrefsInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<String?> getPrefsString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future setPrefsString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<bool?> getPrefsBool(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

Future setPrefsBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<List<String>?> getPrefsList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key);
}

Future setPrefsList(String key, List<String> value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);
}

Future removePrefs(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future allRemovePrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future requestReview() async {
  final inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  }
}
