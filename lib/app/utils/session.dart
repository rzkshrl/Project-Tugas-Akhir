import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/usermodel.dart';

class SessionController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Check login status when the app starts
    checkLoginStatus();
  }

  void checkLoginStatus() {
    final isLoggedInValue = window.localStorage.containsKey('isLoggedIn') &&
        window.localStorage['isLoggedIn'] == 'true';
    isLoggedIn.value = isLoggedInValue;
    if (isLoggedInValue) {
      userEmail.value = window.localStorage['userEmail'] ?? '';
    }
  }

  void login(String email) {
    window.localStorage['isLoggedIn'] = 'true';
    window.localStorage['userEmail'] = email;

    isLoggedIn.value = true;
    userEmail.value = email;
  }

  void logout() {
    window.localStorage.remove('isLoggedIn');
    window.localStorage.remove('userEmail');

    isLoggedIn.value = false;
    userEmail.value = '';
  }
}

class StorageService {
  static final _box = GetStorage();

  static void saveUserData(UserModel user) {
    _box.write('userData', user.toJson());
  }

  static UserModel? getUserData() {
    final data = _box.read('userData');
    if (data != null) {
      return UserModel.fromJson2(data);
    }
    return null;
  }
}
