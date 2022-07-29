import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
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
}
