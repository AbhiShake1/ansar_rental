import 'package:animations/animations.dart';
import 'package:ansar_rental/app/config/colors.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/modules/home/controllers/user_controller.dart';
import 'package:ansar_rental/app/views/views/profile_view.dart';
import 'package:ansar_rental/app/views/widgets/add_user_widget.dart';
import 'package:ansar_rental/app/views/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          //isScrollControlled: true,
          DecoratedBox(
            //height: .8.sh,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: AddUserWidget(),
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
            controller: controller.searchController,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              fillColor: Colors.transparent,
              suffixIcon: Icon(Iconsax.search_normal),
              hintText: 'Search tenant...',
            ),
          ).glassMorphic(shadowStrength: 100).px(10),
        ),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: controller.getAllUsers(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          }
          final users = snapshot.data!;

          return Obx(
            () {
              final requiredUsers = users.where(
                (u) {
                  if (controller.searchText.isEmpty) {
                    return true;
                  }

                  final isNumeric =
                      int.tryParse(controller.searchText.value) != null;

                  if (isNumeric) {
                    return u.roomNo == int.parse(controller.searchText.value);
                  }
                  return u.name
                      .toLowerCase()
                      .contains(controller.searchText.toLowerCase());
                },
              );

              return requiredUsers.isEmpty
                  ? 'No matching user found.'.text.xl2.white.bold.makeCentered()
                  : ListView(
                      children: requiredUsers
                          .map(
                            (e) => OpenContainer(
                              openColor: Colors.transparent,
                              closedColor: Colors.transparent,
                              middleColor: Colors.transparent,
                              closedBuilder: (context, action) => ListTile(
                                title:
                                    e.name.text.bold.white.size(22.sp).make(),
                                subtitle:
                                    'Room No. ${e.roomNo}'.text.white.make(),
                                trailing: CircleAvatar(
                                  backgroundImage:
                                      CachedNetworkImageProvider(e.photoUrl),
                                ),
                                dense: true,
                              ),
                              openBuilder: (context, action) =>
                                  ProfileView(user: e),
                              transitionDuration: 800.milliseconds,
                            ).pSymmetric(h: 20, v: 20.h).glassMorphic().p12(),
                          )
                          .toList(),
                    );
            },
          ).py(20);
        },
      ),
    ).pOnly(bottom: 50);
  }
}
