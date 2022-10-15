// ignore_for_file: only_throw_errors

import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepo {
  final _authClient = AuthClient();

  final _bioAuth = GetStorage('BIOMETRIC_AUTH');

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await _authClient.signInWithEmailAndPassword(email, password);
    await _bioAuth.write('user_email_key', email);
    await _bioAuth.write('user_password_key', password);
  }

  Future<void> sendPasswordResetEmail(
    String email,
  ) =>
      _authClient.sendPasswordResetEmail(email);

  Future<void> loginWithToken(String token) =>
      _authClient.signInWithToken(token);
}
