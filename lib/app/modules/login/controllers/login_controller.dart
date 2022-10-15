import 'package:ansar_rental/app/data/repo/local_auth_repo.dart';
import 'package:ansar_rental/app/modules/login/repo/auth_repo.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements GetxService {
  //states
  final isPasswordObscured = true.obs;

  late final TextEditingController emailController, passwordController;
  late final AnimationController lottieController;
  final formKey = GlobalKey<FormState>();

  final _authRepo = Get.find<AuthRepo>();
  final _localAuthRepo = Get.find<LocalAuthRepo>();
  final _bioAuth = GetStorage('BIOMETRIC_AUTH');

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      await lottieController.forward().whenComplete(lottieController.reset);
      return;
    }

    await callService(
      () => _authRepo.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ),
      onFailure: (e) {
        lottieController.forward().whenComplete(lottieController.reset);
        Get.snackbar(
          'Invalid credentials',
          'Please contact house owner',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
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

  late final _previousEmail = _bioAuth.read<String>('user_email_key');
  late final _previousPassword = _bioAuth.read<String>('user_password_key');

  Future<void> loginWithBiometrics() => callService(
        _localAuthRepo.authenticateWithBiometrics,
        showLoading: false,
        onSuccess: () => callService(
          () => _authRepo
              .signInWithEmailAndPassword(
                _previousEmail!,
                _previousPassword!,
              )
              .timeout(5.seconds),
          onFailure: (error) => Get.snackbar(
            'Something went wrong',
            error.toString(),
          ),
        ),
      );

  Future<void> resetPassword() => callService(
        () async {
          if (emailValidator(emailController.text) != null) {
            throw 'Invalid email';
          }
          await _authRepo.sendPasswordResetEmail(emailController.text);
        },
        onFailure: (error) => Get.snackbar(
          'Something went wrong',
          error.toString(),
          snackPosition: SnackPosition.BOTTOM,
        ),
        onSuccess: () => Get.snackbar(
          'Email sent',
          'Password reset link has been sent to your email: ${emailController.text}',
        ),
      );

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    lottieController = AnimationController(vsync: this);
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
    lottieController.dispose();
    super.onClose();
  }
}
