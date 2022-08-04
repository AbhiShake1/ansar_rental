import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:ansar_rental/app/routes/app_pages.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingController extends GetxController {
  ProfileSettingController({this.user});

  final UserModel? user;

  late final TextEditingController passwordController;

  final _dbClient = Get.find<AuthClient>();

  final isPasswordVisible = false.obs;

  String? passwordValidator(String? text) {
    if (text?.isEmpty ?? true) {
      return 'Required';
    }

    if (text!.length < 8) {
      return 'Password must be at least 8 character long';
    }

    return null;
  }

  @override
  void onInit() {
    passwordController = TextEditingController(text: user?.password);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signOut() => callService(
        _dbClient.logout,
        onSuccess: () => Get.offAllNamed<dynamic>(Routes.LOGIN),
        onFailure: (error) => Get.snackbar(
          'Something went wrong',
          error.toString(),
        ),
      );
}
