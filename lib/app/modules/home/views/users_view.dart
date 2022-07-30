import 'package:ansar_rental/app/config/colors.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/modules/home/controllers/add_user_controller.dart';
import 'package:ansar_rental/app/modules/home/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class UsersView extends GetView<UserController> {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    print(1.sw);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        onPressed: () => Get.bottomSheet<dynamic>(
          //isScrollControlled: true,
          const DecoratedBox(
            //height: .8.sh,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: _AddUser(),
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
          final users = snapshot.data!;
          return ListView(
            children: users
                .map(
                  (e) => FlutterSlimyCard(
                    cardWidth: 1.sw - 50.w,
                    color: Colors.blueAccent,
                    topCardWidget: ListTile(
                      title: e.name.text.bold.size(22.sp).make(),
                      subtitle: 'Room No. ${e.roomNo}'.text.make(),
                      trailing: const CircleAvatar(
                        child: Icon(Iconsax.user),
                      ),
                    ),
                    topCardHeight: 150,
                    bottomCardWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        e.address.text.make().py(5),
                        e.waterRent.text.make().py(5),
                        e.email.text.make().py(5),
                        e.contactNumber.text.make().py(5),
                        e.monthlyRent.text.make().py(5),
                        e.startingDate
                            .toUtc()
                            .toIso8601String()
                            .text
                            .make()
                            .py(5),
                      ],
                    ),
                    bottomCardHeight: 550,
                  ).pSymmetric(h: 20, v: 10),
                )
                .toList(),
          ).py(10);
        },
      ),
    ).pOnly(bottom: 50);
  }
}

class _AddUser extends GetView<AddUserController> {
  const _AddUser();

  @override
  Widget build(BuildContext context) {
    final children = <Widget Function()>[
      () => 'Tenant Registration'
          .text
          .size(34.sp)
          .color(Get.theme.scaffoldBackgroundColor)
          .extraBold
          .makeCentered(),
      () => 20.h.heightBox,
      () => 'Name'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => TextFormField(
            controller: controller.nameController,
            validator: controller.notEmptyValidator,
            textInputAction: TextInputAction.next,
            focusNode: controller.nameNode,
            onFieldSubmitted: (_) => controller.emailNode.requestFocus(),
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: 'Full name',
            ),
          ),
      () => 10.h.heightBox,
      () => 'Email'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => TextFormField(
            validator: controller.emailValidator,
            onFieldSubmitted: (_) => controller.passwordNode.requestFocus(),
            textInputAction: TextInputAction.next,
            focusNode: controller.emailNode,
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
      () => 10.h.heightBox,
      () => 'Password'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => Obx(
            () => TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => controller.addressNode.requestFocus(),
              focusNode: controller.passwordNode,
              controller: controller.passwordController,
              validator: controller.passwordValidator,
              obscureText: controller.isPasswordVisible.value,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: Icon(
                  controller.isPasswordVisible.value
                      ? Iconsax.eye
                      : Iconsax.eye_slash,
                ).onTap(() => controller.isPasswordVisible.toggle()),
              ),
            ),
          ),
      () => 10.h.heightBox,
      () => 'Address'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => TextFormField(
            textInputAction: TextInputAction.next,
            controller: controller.addressController,
            onFieldSubmitted: (_) =>
                controller.contactNumberNode.requestFocus(),
            focusNode: controller.addressNode,
            keyboardType: TextInputType.streetAddress,
            validator: controller.notEmptyValidator,
            decoration: const InputDecoration(
              hintText: 'Address',
            ),
          ),
      () => 10.h.heightBox,
      () => 'Contact number'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => TextFormField(
            textInputAction: TextInputAction.next,
            controller: controller.contactNumberController,
            onFieldSubmitted: (_) => controller.monthlyRentNode.requestFocus(),
            focusNode: controller.contactNumberNode,
            validator: controller.contactNumberValidator,
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
            onFieldSubmitted: (_) => controller.waterRentNode.requestFocus(),
            focusNode: controller.monthlyRentNode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller.monthlyRentController,
            validator: controller.notEmptyValidator,
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
            onFieldSubmitted: (_) => controller.roomNoNode.requestFocus(),
            focusNode: controller.waterRentNode,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            ],
            controller: controller.waterRentController,
            validator: controller.notEmptyValidator,
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
            onFieldSubmitted: (_) => controller.guardianNameNode.requestFocus(),
            focusNode: controller.roomNoNode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller.roomNoController,
            validator: controller.notEmptyValidator,
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
            controller: controller.guardianNameController,
            onFieldSubmitted: (_) =>
                controller.guardianContactNumberNode.requestFocus(),
            focusNode: controller.guardianNameNode,
            validator: controller.notEmptyValidator,
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
                controller.startingElectricityUnitsNode.requestFocus(),
            focusNode: controller.guardianContactNumberNode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller.guardianContactNumberController,
            validator: controller.contactNumberValidator,
            decoration: const InputDecoration(
              hintText: '(+977) 9XXXXXXXXX',
            ),
          ),
      () => 10.h.heightBox,
      () => 'Starting electricity units'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => TextFormField(
            textInputAction: TextInputAction.next,
            controller: controller.startingElectricityUnitsController,
            onFieldSubmitted: (_) => controller.noOfTenantsNode.requestFocus(),
            focusNode: controller.startingElectricityUnitsNode,
            validator: controller.notEmptyValidator,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
            onFieldSubmitted: (_) => Get.focusScope!.unfocus(),
            focusNode: controller.noOfTenantsNode,
            controller: controller.noOfTenantsController,
            validator: controller.lessThan10Validator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              hintText: 'No of tenants in this room',
            ),
          ),
      () => 10.h.heightBox,
      () => 'Admin?'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => 10.h.heightBox,
      () => 'Photo'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => 10.h.heightBox,
      () => 'Document'.text.bold.size(16.sp).make(),
      () => 2.h.heightBox,
      () => 10.h.heightBox,
      () => ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Get.theme.scaffoldBackgroundColor,
              ),
            ),
            onPressed: controller.registerUser,
            child: 'Add Tenant'.text.white.bold.size(16.sp).makeCentered(),
          ),
      () => 30.heightBox,
    ];

    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index].call(),
      ).pSymmetric(v: 5, h: 20),
    );
  }
}
