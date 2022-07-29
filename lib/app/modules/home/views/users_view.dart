import 'package:ansar_rental/app/config/colors.dart';
import 'package:ansar_rental/app/modules/home/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class UsersView extends GetView<UserController> {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        onPressed: () => Get.bottomSheet<dynamic>(
          isScrollControlled: true,
          Container(
            height: .8.sh,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const _AddUser(),
          ),
        ),
        child: Icon(
          Iconsax.user_add,
          color: Get.theme.scaffoldBackgroundColor,
        ),
      ),
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: TextFormField(
            decoration: const InputDecoration(
              suffixIcon: Icon(Iconsax.search_normal),
              hintText: 'Search tenant...',
            ),
          ).px(10),
        ),
      ),
      body: const SizedBox.shrink(),
    ).pOnly(bottom: 50);
  }
}

class _AddUser extends GetWidget<UserController> {
  const _AddUser();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
