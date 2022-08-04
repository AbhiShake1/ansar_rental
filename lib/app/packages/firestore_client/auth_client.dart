import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthClient extends GetxService {
  final _userRef = FirebaseFirestore.instance
      .collection('user')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

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

  User get currentUser => FirebaseAuth.instance.currentUser!;

  String get currentUID => currentUser.uid;

  Future<UserModel?> getUser(String uid) =>
      _userRef.doc(uid).get().then((snapshot) => snapshot.data());

  Future<UserModel> getCurrentUser() => getUser(currentUID).then((u) => u!);

  Stream<UserModel> streamCurrentUser() {
    final docs = _userRef.where('id', isEqualTo: currentUID);
    return docs.snapshots().asyncMap(
          (e) => e.docs.first.data(),
        );
  }

  Stream<List<UserModel>> getAllUsers() {
    final docs = _userRef.where('id', isNotEqualTo: currentUID);
    return docs.snapshots().asyncMap(
          (e) => e.docs
              .where((e) => !e.data().hasLeft)
              .map((e) => e.data())
              .toList(),
        );
  }

  Future<UserCredential> signInWithToken(String token) =>
      _auth.signInWithCustomToken(token);

  Future<UserModel> updateUser({required UserModel user}) async {
    await _userRef.doc(user.id).set(user, SetOptions(merge: true));
    final res = await getUser(user.id);
    return res!;
  }

  Future<void> logout() => _auth.signOut();

  Future<void> kickUser(String uid) =>
      FirebaseFirestore.instance.doc('user/$uid').update({'hasLeft': true});
}
