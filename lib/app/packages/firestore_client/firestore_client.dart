import 'dart:io';

import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirestoreClient extends GetxService {
  final _dbClient = Get.find<AuthClient>();

  Reference getStorageRef(String imageName) => FirebaseStorage.instance
      .ref()
      .child('profile/${_dbClient.currentUID}/$imageName');

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
}
