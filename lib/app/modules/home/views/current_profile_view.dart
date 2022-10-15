import 'package:ansar_rental/app/controllers/local_auth_controller.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/modules/home/controllers/home_controller.dart';
import 'package:ansar_rental/app/views/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class CurrentProfileView extends GetView<HomeController> {
  const CurrentProfileView({super.key});

  Widget _glassmorphic(Widget child) =>
      child.glassMorphic().pSymmetric(v: 5.h, h: 16.w);

  Widget _text(String text) =>
      text.text.bold.size(16.sp).white.make().pSymmetric(v: 5.h, h: 16.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'My Profile'.text.extraBold.extraBlack.make(),
        centerTitle: true,
      ),
      body: StreamBuilder<UserModel>(
        stream: controller.streamCurrentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          }
          final user = snapshot.data!;
          return ListView(
            children: [
              20.h.heightBox,
              _TopSection(user: user),
              10.h.heightBox,
              _text('Basic Information'),
              4.h.heightBox,
              _glassmorphic(_MyInformation(user: user)),
              _glassmorphic(const _Logout()),
              10.h.heightBox,
              _text('Security Settings'),
              _glassmorphic(const _ChangePassword()),
              _glassmorphic(const _Biometrics()),
            ],
          );
        },
      ),
    );
  }
}

class _Biometrics extends GetWidget<LocalAuthController> {
  const _Biometrics();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: 500.milliseconds,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              if (controller.bioAuthEnabled.value)
                Colors.green
              else
                Colors.red.withOpacity(.5),
              Colors.transparent,
              Colors.transparent,
              if (controller.bioAuthEnabled.value)
                Colors.green
              else
                Colors.red.withOpacity(.5),
            ],
            stops: const [0, .3, .6, 1],
          ),
        ),
        child: ListTile(
          title: 'Enable Biometrics'.text.white.bold.make(),
          subtitle: (controller.bioAuthEnabled.value ? 'Enabled' : 'Disabled')
              .text
              .white
              .make()
              .py4(),
          leading: const Icon(
            Iconsax.finger_scan,
            color: Colors.white,
          ),
          onTap: controller.toggleBioAuth,
        ),
      ),
    );
  }
}

class _ChangePassword extends GetWidget<HomeController> {
  const _ChangePassword();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: 'Change Password'.text.white.bold.make(),
      subtitle: 'Change your password'.text.white.make().py4(),
      leading: const Icon(
        Iconsax.lock,
        color: Colors.white,
      ),
      onTap: () => Get.defaultDialog<dynamic>(
        title: 'Send password reset email?',
        titleStyle: TextStyle(
          fontSize: 18.sp,
        ),
        middleText: '',
        onCancel: Get.back<dynamic>,
        buttonColor: Colors.grey.withOpacity(.4),
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.black,
        textCancel: 'No',
        textConfirm: 'Yes',
        onConfirm: controller.resetPassword,
      ),
    );
  }
}

class _Logout extends GetWidget<HomeController> {
  const _Logout();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: 'Logout'.text.white.bold.make(),
      subtitle: 'Logout of this app'.text.white.make().py4(),
      leading: const Icon(
        Iconsax.logout,
        color: Colors.white,
      ),
      onTap: () => Get.defaultDialog<dynamic>(
        title: 'Are you sure you want to logout?',
        titleStyle: TextStyle(
          fontSize: 18.sp,
        ),
        middleText: '',
        onCancel: Get.back<dynamic>,
        buttonColor: Colors.grey.withOpacity(.4),
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.black,
        textCancel: 'No',
        textConfirm: 'Yes',
        onConfirm: controller.logout,
      ),
    );
  }
}

class _MyInformation extends StatelessWidget {
  const _MyInformation({
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(
        CupertinoIcons.person_circle,
        color: Colors.white,
      ),
      subtitle: 'View your basic information'.text.white.make().py4(),
      title: 'My Information'.text.white.bold.make(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ['Name', 'Address', 'Email']
                  .map((e) => e.text.white.make().py(10.h))
                  .toList(),
            ).py(10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [user.name, user.address, user.email]
                  .map((e) => e.text.white.make().py(10.h))
                  .toList(),
            ).py(10.h),
          ],
        ).px(15.w),
      ],
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection({
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          user.photoUrl,
        ),
        maxRadius: 30.sp,
      ),
      title: Row(
        children: [
          user.name.text.white.bold.make(),
          4.w.widthBox,
          '(${user.isAdmin ? 'Admin' : 'Tenant'})'
              .text
              .color(const Color.fromRGBO(255, 255, 255, .6))
              .make()
              .py4(),
        ],
      ),
      subtitle: Row(
        children: [
          Icon(
            CupertinoIcons.device_phone_portrait,
            color: Colors.white,
            size: 18.sp,
          ),
          8.w.widthBox,
          user.contactNumber.text.white.make(),
        ],
      ),
    );
  }
}
