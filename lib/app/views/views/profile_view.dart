import 'package:ansar_rental/app/config/colors.dart';
import 'package:ansar_rental/app/controllers/profile_controller.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/views/views/profile_setting_view.dart';
import 'package:ansar_rental/app/views/widgets/add_user_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: user.name.text.size(24.sp).extraBold.make(),
        actions: [
          const Icon(
            Iconsax.user_edit,
          ).onTap(
            () => Get.bottomSheet<dynamic>(
              //isScrollControlled: true,
              DecoratedBox(
                //height: .8.sh,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: AddUserWidget(
                  user: user,
                ),
              ),
            ),
          ),
          if (user.id != controller.currentUid)
            const Icon(
              Iconsax.profile_delete,
            )
                .onTap(
                  () => Get.dialog<dynamic>(
                    SizedBox(
                      width: 300.w,
                      height: 300.h,
                      child: AlertDialog(
                        title: 'Confirm unregister tenant?'
                            .text
                            .size(14.sp)
                            .bold
                            .center
                            .make(),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: Get.back<dynamic>,
                                child: 'No'.text.size(14.sp).make(),
                              ),
                              ElevatedButton(
                                onPressed: () => controller.kickUser(user.id),
                                child: 'Yes'.text.size(14.sp).make(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ).centered(),
                  ),
                )
                .px(20.w)
          else
            const Icon(
              Iconsax.setting,
            )
                .onTap(
                  () => Get.to<dynamic>(() => ProfileSettingView(user: user)),
                )
                .px(20.w),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            VxArc(
              height: 30,
              child: Container(
                height: 200.h,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [.1, .7],
                    colors: [
                      Colors.red,
                      Colors.yellow,
                    ].map((e) => e.withOpacity(.1)).toList(),
                  ),
                ),
                child: Column(
                  children: [
                    10.h.heightBox,
                    CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(user.photoUrl),
                      radius: 50.sp,
                    ).onTap(() async {
                      final cache = DefaultCacheManager();
                      final file = await cache.getSingleFile(user.photoUrl);
                      await OpenFile.open(file.path);
                    }),
                    user.name.text.size(24.sp).extraBold.white.make().py(8.h),
                    (user.isAdmin ? 'Admin' : 'Tenant')
                        .text
                        .gray400
                        .bold
                        .size(16.sp)
                        .make(),
                  ],
                ),
              ),
            ),
            30.h.heightBox,
            'Account Info'
                .text
                .size(32.sp)
                .white
                .extraBold
                .make()
                .hide(isVisible: !user.isAdmin),
            Flexible(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Iconsax.user,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Name'.text.bold.white.make(),
                    subtitle: user.name.text.white.make(),
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.home_hashtag,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Room Number'.text.bold.white.make(),
                    subtitle: user.roomNo.text.white.make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      Iconsax.profile_2user,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Number of Tenants'.text.bold.white.make(),
                    subtitle: user.noOfTenants.toString().text.white.make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.mail,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Email'.text.bold.white.make(),
                    subtitle: user.email.text.white.make(),
                    onTap: () => launchUrl(Uri.parse('mailto:${user.email}')),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Address'.text.bold.white.make(),
                    subtitle: user.address.text.white.make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.phone,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Contact Number'.text.bold.white.make(),
                    subtitle: user.contactNumber.text.white.make(),
                    onTap: () => launchUrl(
                      Uri.parse('tel:${user.contactNumber}'),
                    ),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.money_dollar,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Monthly Room Rent'.text.bold.white.make(),
                    subtitle: user.monthlyRent.text.white.make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      Iconsax.timer_start,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Starting date'.text.bold.white.make(),
                    subtitle: user.startingDate
                        .toIso8601String()
                        .split('T')
                        .first
                        .text
                        .white
                        .make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.money_dollar,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Monthly Water Rent'.text.bold.white.make(),
                    subtitle: user.waterRent.text.white.make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      Iconsax.user,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Guardian Name'.text.bold.white.make(),
                    subtitle: user.guardianName.text.white.make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.phone,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Guardian Contact'.text.bold.white.make(),
                    subtitle: user.guardianContactNumber.text.white.make(),
                    onTap: () => launchUrl(
                      Uri.parse('tel:${user.guardianContactNumber}'),
                    ),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.lightbulb,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Starting Electricity Unit'.text.bold.white.make(),
                    subtitle: user.startingElectricityUnits.text.white.make(),
                  ).hide(isVisible: !user.isAdmin),
                  ListTile(
                    leading: Icon(
                      Icons.edit_note,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                    title: 'Notes'.text.bold.white.make(),
                    subtitle: user.notes?.text.white.make(),
                  ).hide(isVisible: user.notes?.isNotBlank ?? false),
                  'Document'
                      .text
                      .bold
                      .white
                      .make()
                      .hide(isVisible: !user.isAdmin),
                  10.h.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 200.w,
                      height: 200.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: user.documentUrl,
                        ),
                      ),
                    ).onTap(() async {
                      final cache = DefaultCacheManager();
                      final file = await cache.getSingleFile(user.documentUrl);
                      await OpenFile.open(file.path);
                    }),
                  ).hide(isVisible: !user.isAdmin),
                  30.h.heightBox,
                ],
              ).px(20.w),
            ),
          ],
        ),
      ),
    );
  }
}
