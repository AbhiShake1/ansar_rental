import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/firestore_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final _dbClient = Get.find<FirestoreClient>();

  late final TextEditingController searchController;

  final searchText = ''.obs;

  @override
  void onInit() {
    searchController = TextEditingController();
    searchController.addListener(() {
      searchText.value = searchController.text;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Stream<List<UserModel>> getAllUsers() => _dbClient.getAllUsers();
}
