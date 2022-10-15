import 'dart:io';

import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirestoreClient extends GetxService {
  final _authClient = Get.find<AuthClient>();

  final _userRef = FirebaseFirestore.instance
      .collection('user')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Reference getStorageRef(String imageName) => FirebaseStorage.instance
      .ref()
      .child('profile/${_authClient.currentUID}/$imageName');

  Future<String?> uploadUserImage(File image) async {
    try {
      final storageRef = getStorageRef(image.path.split('/').last);
      final res = await storageRef.putFile(image);
      final url = await res.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUser(String uid) =>
      _userRef.doc(uid).get().then((snapshot) => snapshot.data());

  Future<UserModel> getUserByRoomNo(String roomNo) async {
    final res = await _userRef
        .limit(1)
        .where('roomNo', isEqualTo: int.parse(roomNo))
        .get()
        .then(
          (snapshot) => snapshot.docs.first.data(),
        );
    return res;
  }

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

  Future<UserModel> updateUser({required UserModel user}) async {
    await _userRef.doc(user.id).set(user, SetOptions(merge: true));
    final res = await getUser(user.id);
    return res!;
  }

  String get currentUID => _authClient.currentUID;

  Future<void> kickUser(String uid) =>
      FirebaseFirestore.instance.doc('user/$uid').update({'hasLeft': true});
}
