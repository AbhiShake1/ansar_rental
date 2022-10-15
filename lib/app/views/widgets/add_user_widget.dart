import 'package:ansar_rental/app/controllers/add_user_controller.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/views/views/image_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class AddUserWidget extends GetWidget {
  AddUserWidget({super.key, this.user}) {
    Get.put(AddUserController(user: user), tag: user?.id);
  }

  final UserModel? user;

  AddUserController get addUserController =>
      Get.find<AddUserController>(tag: user?.id);

  @override
  Widget build(BuildContext context) {
    final users = <Widget Function()>[
      () =>
          '${user?.isAdmin ?? false ? 'Admin' : 'Tenant'} ${user == null ? 'Registration' : 'Update'}'
              .text
              .size(34.sp)
              .color(Get.theme.scaffoldBackgroundColor)
              .extraBold
              .makeCentered(),
      () => 20.h.heightBox,
      () => 'Name'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => TextFormField(
            controller: addUserController.nameController,
            validator: addUserController.notEmptyValidator,
            textInputAction: TextInputAction.next,
            focusNode: addUserController.nameNode,
            onFieldSubmitted: (_) => addUserController.emailNode.requestFocus(),
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: 'Full name',
            ),
          ),
      () => 10.h.heightBox,
      () => 'Email'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => TextFormField(
            validator: addUserController.emailValidator,
            onFieldSubmitted: (_) =>
                addUserController.passwordNode.requestFocus(),
            textInputAction: TextInputAction.next,
            focusNode: addUserController.emailNode,
            keyboardType: TextInputType.emailAddress,
            controller: addUserController.emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
      () => 10.h.heightBox,
      if (user == null) ...[
        () => 'Password'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => Obx(
              () => TextFormField(
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    addUserController.addressNode.requestFocus(),
                focusNode: addUserController.passwordNode,
                controller: addUserController.passwordController,
                validator: addUserController.passwordValidator,
                obscureText: addUserController.isPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(
                    addUserController.isPasswordVisible.value
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
                  ).onTap(() => addUserController.isPasswordVisible.toggle()),
                ),
              ),
            ),
      ],
      if (!(user?.isAdmin ?? false)) ...[
        () => 10.h.heightBox,
        () => 'Address'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              controller: addUserController.addressController,
              onFieldSubmitted: (_) =>
                  addUserController.contactNumberNode.requestFocus(),
              focusNode: addUserController.addressNode,
              keyboardType: TextInputType.streetAddress,
              validator: addUserController.notEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'Address',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Contact number'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              controller: addUserController.contactNumberController,
              onFieldSubmitted: (_) =>
                  addUserController.monthlyRentNode.requestFocus(),
              focusNode: addUserController.contactNumberNode,
              validator: addUserController.contactNumberValidator,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                hintText: '(+977) 9XXXXXXXXX',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Monthly room rent'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) =>
                  addUserController.waterRentNode.requestFocus(),
              focusNode: addUserController.monthlyRentNode,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: addUserController.monthlyRentController,
              validator: addUserController.notEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'Amount',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Monthly water rent'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              onFieldSubmitted: (_) =>
                  addUserController.roomNoNode.requestFocus(),
              focusNode: addUserController.waterRentNode,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
              ],
              controller: addUserController.waterRentController,
              validator: addUserController.notEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'Amount',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Room number'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              onFieldSubmitted: (_) =>
                  addUserController.guardianNameNode.requestFocus(),
              focusNode: addUserController.roomNoNode,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: addUserController.roomNoController,
              validator: addUserController.notEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'Room number',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Guardian name'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              controller: addUserController.guardianNameController,
              onFieldSubmitted: (_) =>
                  addUserController.guardianContactNumberNode.requestFocus(),
              focusNode: addUserController.guardianNameNode,
              validator: addUserController.notEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'Full name',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Guardian contact number'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              onFieldSubmitted: (_) =>
                  addUserController.startingElectricityUnitsNode.requestFocus(),
              focusNode: addUserController.guardianContactNumberNode,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: addUserController.guardianContactNumberController,
              validator: addUserController.contactNumberValidator,
              decoration: const InputDecoration(
                hintText: '(+977) 9XXXXXXXXX',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Starting electricity units'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.next,
              controller: addUserController.startingElectricityUnitsController,
              onFieldSubmitted: (_) =>
                  addUserController.noOfTenantsNode.requestFocus(),
              focusNode: addUserController.startingElectricityUnitsNode,
              validator: addUserController.notEmptyValidator,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              decoration: const InputDecoration(
                hintText: 'Starting electricity units',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Number of tenants'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) =>
                  addUserController.startingYearNode.requestFocus(),
              focusNode: addUserController.noOfTenantsNode,
              controller: addUserController.noOfTenantsController,
              validator: addUserController.lessThan10Validator,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                hintText: 'No of tenants in this room',
              ),
            ),
        () => 10.h.heightBox,
        () => 'Starting Date'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: addUserController.startingYearController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    hintText: 'yyyy',
                  ),
                  onFieldSubmitted: (_) =>
                      addUserController.startingMonthNode.requestFocus(),
                ).w(100.w),
                TextFormField(
                  focusNode: addUserController.startingMonthNode,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: addUserController.startingMonthController,
                  decoration: const InputDecoration(
                    hintText: 'mm',
                  ),
                  onFieldSubmitted: (_) =>
                      addUserController.startingDayNode.requestFocus(),
                ).w(100.w),
                TextFormField(
                  focusNode: addUserController.startingDayNode,
                  controller: addUserController.startingDayController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    hintText: 'dd',
                  ),
                  onFieldSubmitted: (_) => Get.focusScope?.unfocus(),
                ).w(100.w),
              ],
            ),
        () => 10.h.heightBox,
        () => 'Notes'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => TextFormField(
              controller: addUserController.notesController,
              decoration: const InputDecoration(
                hintText: '(Optional)',
              ),
              minLines: 3,
              maxLines: 5,
            ),
        () => 10.h.heightBox,
        () => 'Document'.text.bold.size(16.sp).make(),
        () => 2.h.heightBox,
        () => ImagePickerView(
              imageController: addUserController.documentImagePath,
            ),
      ],
      () => 10.h.heightBox,
      () => 'Photo'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => ImagePickerView(
            imageController: addUserController.profileImagePath,
          ),
      () => 20.h.heightBox,
      () => ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Get.theme.scaffoldBackgroundColor,
              ),
            ),
            onPressed: user?.isAdmin ?? false
                ? addUserController.registerAdmin
                : addUserController.registerUser,
            child:
                '${user == null ? 'Add' : 'Update'} ${user?.isAdmin ?? false ? 'Admin' : 'Tenant'}'
                    .text
                    .white
                    .bold
                    .size(16.sp)
                    .makeCentered(),
          ),
      () => 30.heightBox,
    ];

    return Form(
      key: addUserController.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => users[index].call(),
      ).pSymmetric(v: 5, h: 20),
    );
  }
}
