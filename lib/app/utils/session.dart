// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:universal_html/html.dart' as html;

import '../data/models/usermodel.dart';

class SessionController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (html.window != null || kIsWeb) {
      // Check login status when the app starts
      checkLoginStatus();
    }
  }

  void checkLoginStatus() {
    final isLoggedInValue =
        html.window.localStorage.containsKey('isLoggedIn') &&
            html.window.localStorage['isLoggedIn'] == 'true';
    isLoggedIn.value = isLoggedInValue;
    if (isLoggedInValue) {
      userEmail.value = html.window.localStorage['userEmail'] ?? '';
    }
  }

  void login(String email) {
    html.window.localStorage['isLoggedIn'] = 'true';
    html.window.localStorage['userEmail'] = email;

    isLoggedIn.value = true;
    userEmail.value = email;
  }

  void logout() {
    html.window.localStorage.remove('isLoggedIn');
    html.window.localStorage.remove('userEmail');

    isLoggedIn.value = false;
    userEmail.value = '';
  }
}

class StorageService {
  static final _box = GetStorage();

  // static void saveUserData(UserModel user) {
  //   _box.write('userData', user.toJson());
  // }

  static void saveUserDataWithExpiration(
      UserModel user, DateTime expirationTime) {
    final data = {
      'user': user.toJson(),
      'expirationTime': expirationTime.toIso8601String(),
    };
    _box.write('userData', data);
  }

  // static UserModel? getUserData() {
  //   final data = _box.read('userData');
  //   if (data != null) {
  //     return UserModel.fromJson2(data);
  //   }
  //   return null;
  // }

  static UserData? getUserDataWithExpiration() {
    final data = _box.read('userData');
    if (data != null) {
      final expirationTime = DateTime.parse(data['expirationTime']);
      if (expirationTime.isAfter(DateTime.now())) {
        return UserData(
          user: UserModel.fromJson2(data['user']),
          expirationTime: expirationTime,
        );
      }
    }
    return null;
  }

  static void saveCurrentRoute(String route) {
    _box.write('currentRoute', route);
  }

  static String? getCurrentRoute() {
    return _box.read('currentRoute');
  }

  static Future<void> removeCurrentRoute() {
    return _box.remove('currentRoute');
  }
}
