import 'dart:io';

import 'package:ansar_rental/app/config/colors.dart';
import 'package:ansar_rental/app/controllers/add_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class ImagePickerView extends GetWidget<AddUserController> {
  const ImagePickerView({
    super.key,
    required this.imageController,
  });

  final Rx<String?> imageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(175, 175, 175, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          width: 160.h,
          height: 150.h,
          child: Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageController.value == null
                  ? const Icon(
                      Icons.add,
                      color: AppColors.primaryAccent,
                    )
                  : Image.file(
                      File(imageController.value!),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ).onTap(
          () async {
            late final ImageSource imageSource;

            await Get.bottomSheet<void>(
              isScrollControlled: true,
              Container(
                height: Get.height / 3,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: ImageSource.values
                      .map(
                        (e) => ListTile(
                          tileColor: Get.theme.scaffoldBackgroundColor,
                          title:
                              e.name.text.black.bold.size(16.sp).makeCentered(),
                          subtitle: 'Upload photo from ${e.name}'
                              .text
                              .size(14.sp)
                              .makeCentered(),
                          onTap: () {
                            imageSource = e;
                            Get.back<dynamic>();
                          },
                        ).py(20),
                      )
                      .toList(),
                ),
              ),
            );

            final image = await controller.getImage(imageSource);

            if (image == null) {
              Get.snackbar('Something went wrong', 'Image could not be loaded');
            }

            final croppedImage = await controller.cropImage(image);

            if (croppedImage == null) {
              Get.snackbar('Something went wrong', 'Image could not be loaded');
            }

            imageController.value = croppedImage!.path;
          },
        ),
      ],
    );
  }
}
