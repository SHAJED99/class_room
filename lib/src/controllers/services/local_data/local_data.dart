import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class LocalData {
  SharedPreferences? _sharedPreferences;
  final String _isTeacher = "isTeacher";
  final String _isLoginString = "isLogin";

  Future<Tuple2<bool, bool>> initData() async {
    if (kDebugMode) print("LocalData: Loading local user data.");

    _sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin = _sharedPreferences?.getBool(_isLoginString) ?? false;
    if (kDebugMode) print("LocalData: isLogin = $isLogin");

    bool isTeacher = _sharedPreferences?.getBool(_isTeacher) ?? false;
    if (kDebugMode) print("LocalData: isTeacher = $isTeacher");

    return Tuple2(isLogin, isTeacher);
  }

  setIsLogin(bool login) {
    if (kDebugMode) print("LocalData: isLogin = $login");
    _sharedPreferences?.setBool(_isLoginString, login);
  }

  setTeacher(bool isTeacher) {
    if (kDebugMode) print("LocalData: isTeacher = $isTeacher");
    _sharedPreferences?.setBool(_isTeacher, isTeacher);
  }
}
