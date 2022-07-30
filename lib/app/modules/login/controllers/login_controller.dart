import 'package:ansar_rental/app/modules/login/repo/auth_repo.dart';
import 'package:ansar_rental/app/routes/app_pages.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:ansar_rental/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //states
  final isPasswordObscured = true.obs;

  late final TextEditingController emailController, passwordController;
  final formKey = GlobalKey<FormState>();

  final _authRepo = Get.find<AuthRepo>();

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) return;

    await callService(
      () => _authRepo.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ),
      onSuccess: () => Get.offAndToNamed<dynamic>(Routes.HOME),
      onFailure: (e) => Get.snackbar(
        'Invalid credentials',
        'Please contact house owner',
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }

  String? emailValidator(String? email) =>
      email?.isEmail ?? false ? null : 'Invalid email';

  String? passwordValidator(String? password) {
    if (password?.isBlank ?? true) {
      return 'Required';
    }
    if (password!.length < 8) {
      return 'Password must be at least 8 character long';
    }
    return null;
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
