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
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              suffixIcon: Icon(Iconsax.search_normal),
              hintText: 'Search tenant...',
            ),
          ).px(10),
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
          return ListView(
            children: users
                .map(
                  (e) => Container(
                    height: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: e.name.text.bold.white.size(22.sp).make(),
                      subtitle: 'Room No. ${e.roomNo}'.text.white.make(),
                      trailing: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(e.photoUrl),
                      ),
                    ),
                  )
                      .onTap(
                        () => Get.to(() => ProfileView(user: e)),
                      )
                      .p12(),
                )
                .toList(),
          ).py(20);
        },
      ),
    ).pOnly(bottom: 50);
  }
}
