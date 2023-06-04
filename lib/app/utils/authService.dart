import 'package:get_storage/get_storage.dart';

import '../data/models/usermodel.dart';

class AuthService {
  final GetStorage _localStorage = GetStorage();
  final String _userKey = 'user';

  UserModel? get user => _localStorage.read(_userKey);

  void saveUser(UserModel user) {
    _localStorage.write(_userKey, user);
  }

  void removeUser() {
    _localStorage.remove(_userKey);
  }
}
