import 'dart:convert';

import 'package:ansar_rental/app/config/constants.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:get_storage/get_storage.dart';

class SessionRepo {
  SessionRepo(this._storage);

  final GetStorage _storage;

  UserModel? getUser() {
    final res = _storage.read<String>(AppConst.cacheUser);
    if (res != null) {
      return UserModel.fromJson(jsonDecode(res) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> cacheUser(UserModel user) async {
    await _storage.write(AppConst.cacheUser, jsonEncode(user.toJson()));
  }

  Future<void> flush() async {
    return _storage.erase();
  }
}
