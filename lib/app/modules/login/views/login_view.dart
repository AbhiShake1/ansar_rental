import 'package:ansar_rental/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

final _bioBox = GetStorage('BIOMETRIC_AUTH');

class LoginView extends GetWidget<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            .1.sh.heightBox,
            Image.asset('assets/logo_with_title.png'),
            'Email'.text.white.bold.make(),
            4.h.heightBox,
            PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: TextFormField(
                controller: controller.emailController,
                validator: controller.emailValidator,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(.3),
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                  hintText: 'Enter your email',
                ),
              ),
            ),
            10.h.heightBox,
            'Password'.text.white.bold.make(),
            4.h.heightBox,
            PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  validator: controller.passwordValidator,
                  keyboardType: TextInputType.visiblePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    fillColor: Colors.white.withOpacity(.3),
                    suffixIcon: Icon(
                      controller.isPasswordObscured.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ).onTap(
                      () => controller.isPasswordObscured.toggle(),
                    ),
                  ),
                  obscureText: controller.isPasswordObscured.value,
                ),
              ),
            ),
            10.h.heightBox,
            'Forgot password?'
                .text
                .white
                .bold
                .make()
                .onTap(controller.resetPassword)
                .objectCenterRight(),
            20.h.heightBox,
            PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ElevatedButton(
                onPressed: controller.signIn,
                child: 'LOGIN'.text.size(16.sp).extraBold.make(),
              ).w(double.infinity),
            ),
            if (_bioBox.read<String>('user_email_key') != null &&
                _bioBox.read<bool>('enabled_key') == true) ...[
              20.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.fingerprint,
                    color: Colors.white,
                  ).scale(scaleValue: 1.4).px8(),
                  'Tap to login with biometric'
                      .text
                      .white
                      .size(16.sp)
                      .makeCentered(),
                ],
              ).onTap(controller.loginWithBiometrics),
            ]
          ],
        ).px(16),
      ).px(30),
    );
  }
}
