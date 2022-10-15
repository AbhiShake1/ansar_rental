import 'package:ansar_rental/app/config/colors.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/modules/home/controllers/home_controller.dart';
import 'package:ansar_rental/app/modules/home/views/bill_view.dart';
import 'package:ansar_rental/app/modules/home/views/chat_view.dart';
import 'package:ansar_rental/app/modules/home/views/current_profile_view.dart';
import 'package:ansar_rental/app/modules/home/views/dashboard_view.dart';
import 'package:ansar_rental/app/modules/home/views/users_view.dart';
import 'package:ansar_rental/app/views/views/profile_view.dart';
import 'package:ansar_rental/app/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _items = [
    CurrentProfileView(),
    UsersView(),
    BillView(),
    ChatView(),
    DashboardView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: _items,
        ),
      ),
      floatingActionButton: DecoratedBox(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Tooltip(
          triggerMode: TooltipTriggerMode.longPress,
          message: 'Home',
          child: FloatingActionButton.small(
            heroTag: null,
            shape: const StadiumBorder(),
            backgroundColor: AppColors.white,
            onPressed: () => controller.selectedIndex.value = _items.length - 1,
            child: Obx(
              () => Icon(
                Iconsax.home,
                size: 26.sp,
                color: controller.selectedIndex.value < _items.length - 1
                    ? const Color.fromRGBO(0, 0, 0, .6)
                    : Get.theme.scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: const Color.fromRGBO(0, 0, 0, .6),
            selectedItemColor:
                controller.selectedIndex.value < _items.length - 1
                    ? Get.theme.scaffoldBackgroundColor
                    : const Color.fromRGBO(0, 0, 0, .6),
            onTap: (value) => controller.selectedIndex.value = value,
            currentIndex: controller.selectedIndex.value < _items.length - 1
                ? controller.selectedIndex.value
                : 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_tick),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_2user),
                label: 'Tenants',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.bill),
                label: 'Bill',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.message),
                label: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
