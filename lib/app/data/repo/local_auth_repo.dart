// ignore_for_file: only_throw_errors

import 'package:ansar_rental/app/packages/local_auth_client/local_auth_client.dart';
import 'package:flutter/services.dart';

class LocalAuthRepo {
  final _localAuthClient = LocalAuthClient();

  Future<void> authenticateWithBiometrics() async {
    try {
      final result = await _localAuthClient.authenticate();
      if (!result) throw 'Authentication error';
    } on PlatformException catch (e) {
      throw 'Authentication error. ${e.message}';
    }
  }
}
