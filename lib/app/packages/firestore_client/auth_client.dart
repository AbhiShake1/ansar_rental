import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthClient extends GetxService {
  final _userRef = FirebaseFirestore.instance
      .collection('user')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  User get currentUser => FirebaseAuth.instance.currentUser!;

  String get currentUID => currentUser.uid;

  Future<UserModel?> getUser(String uid) async =>
      _userRef.doc(uid).get().then((snapshot) => snapshot.data());

  Future<UserModel> getCurrentUser() async =>
      getUser(currentUID).then((u) => u!);

  Stream<List<UserModel>> getAllUsers() {
    final docs = _userRef.where('id', isNotEqualTo: currentUID);
    return docs
        .snapshots()
        .asyncMap((e) => e.docs.map((e) => e.data()).toList());
  }

  Future<UserModel> updateUser({required UserModel user}) async {
    await _userRef.doc(user.id).set(user, SetOptions(merge: true));
    final res = await getUser(user.id);
    return res!;
  }
}
