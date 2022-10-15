import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthClient extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _adminAuth = FirebaseAuth.instanceFor(app: Firebase.app('ADMIN'));

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _adminAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<UserCredential> signInWithToken(String token) =>
      _auth.signInWithCustomToken(token);

  Future<String> getCurrentToken() => _auth.currentUser!.getIdToken(true);

  Future<void> logout() => _auth.signOut();

  User get currentUser => FirebaseAuth.instance.currentUser!;

  String get currentUID => currentUser.uid;
}
