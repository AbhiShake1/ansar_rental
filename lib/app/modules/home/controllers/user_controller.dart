import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final _dbClient = Get.find<AuthClient>();

  late final TextEditingController _searchController;

  @override
  void onInit() {
    _searchController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _searchController.dispose();
    super.onClose();
  }

  Stream<List<UserModel>> getAllUsers() => _dbClient.getAllUsers();
}
