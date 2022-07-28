import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';

class AuthRepo {
  final _authClient = AuthClient();

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _authClient.signInWithEmailAndPassword(email, password);

  Future<void> sendPasswordResetEmail(
    String email,
  ) =>
      _authClient.sendPasswordResetEmail(email);
}
