import 'package:ansar_rental/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginView extends GetWidget<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('LoginView'),
      //   centerTitle: true,
      // ),
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller.emailController,
              validator: controller.emailValidator,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: 'Enter email',
              ),
            ),
            Obx(
              () => TextFormField(
                controller: controller.passwordController,
                validator: controller.passwordValidator,
                keyboardType: TextInputType.visiblePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'Enter password',
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
            ).py(10.h),
            ElevatedButton(
              onPressed: controller.signIn,
              child: 'LOGIN'.text.size(16.sp).make(),
            ),
          ],
        ).px(16),
      ).px(30),
    );
  }
}
