import 'package:ansar_rental/app/controllers/profile_setting_controller.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileSettingView extends GetWidget {
  ProfileSettingView({super.key, required this.user}) {
    Get.put(ProfileSettingController(user: user), tag: user.id);
  }

  final UserModel user;

  ProfileSettingController get profileSettingController =>
      Get.find<ProfileSettingController>(tag: user.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileSettingView'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Password'.text.bold.size(16.sp).make(),
          2.h.heightBox,
          Obx(
            () => TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              controller: profileSettingController.passwordController,
              validator: profileSettingController.passwordValidator,
              obscureText: profileSettingController.isPasswordVisible.value,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: Icon(
                  profileSettingController.isPasswordVisible.value
                      ? Iconsax.eye
                      : Iconsax.eye_slash,
                ).onTap(
                    () => profileSettingController.isPasswordVisible.toggle()),
              ),
            ),
          ),
          ListTile(
            title: 'Logout'.text.size(24.sp).bold.white.make(),
            onTap: profileSettingController.signOut,
          ),
        ],
      ).px(30),
    );
  }
}
