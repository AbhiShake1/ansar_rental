import 'package:ansar_rental/app/config/colors.dart';
import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/modules/home/controllers/bill_controller.dart';
import 'package:ansar_rental/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:velocity_x/velocity_x.dart';

class BillView extends GetView<HomeController> {
  const BillView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BillView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BillView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: PhysicalModel(
        color: AppColors.secondaryAccent,
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: Container(
          width: 140.w,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              'Generate Bill'.text.black.make(),
              10.widthBox,
              Icon(
                Iconsax.receipt_add,
                color: Get.theme.scaffoldBackgroundColor,
              ),
            ],
          ),
        ).onTap(() {
          Get.bottomSheet<dynamic>(
            isScrollControlled: true,
            elevation: 5,
            const _BillUserView().pOnly(top: 32.h),
          );
        }),
      ).py12(),
    ).pOnly(bottom: 50);
  }
}

class _BillUserView extends GetWidget<BillController> {
  const _BillUserView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: .9.sh,
        color: AppColors.white,
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              Obx(
                () => controller.selectedRoomNo.value == null
                    ? 'No User Yet'.text.xl2.bold.make()
                    : FutureBuilder(
                        future: controller.getUserByRoomId(),
                        builder: (context, snapshot) =>
                            (snapshot.data?.name ?? 'Loading user..')
                                .text
                                .xl2
                                .bold
                                .make(),
                      ),
              ),
              20.heightBox,
              'Room No.'.text.bold.extraBlack.make(),
              4.heightBox,
              StreamBuilder<List<UserModel>>(
                initialData: const [],
                stream: controller.getAllUsers(),
                builder: (context, snapshot) => DropdownButtonFormField(
                  validator: (value) => value == null ? 'Required' : null,
                  items: snapshot.data!
                      .map((e) => e.roomNo)
                      .sortedBy((a, b) => a.compareTo(b))
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: e.text.make(),
                        ),
                      )
                      .toSet()
                      .toList(),
                  decoration: const InputDecoration(
                    hintText: 'Select Room No.',
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedRoomNo.value = value;
                    }
                  },
                ),
              ),
              10.heightBox,
              'Room Rent'.text.bold.extraBlack.make(),
              4.heightBox,
              TextFormField(
                validator: controller.notBlankValidator,
                controller: controller.roomRentController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Room Rent',
                ),
              ),
              10.heightBox,
              10.heightBox,
              'Electricity Unit'.text.bold.extraBlack.make(),
              4.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    validator: controller.notBlankValidator,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: controller.electricityOldUnitController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Previous Reading',
                    ),
                  ).w(.45.sw),
                  TextFormField(
                    validator: controller.notBlankValidator,
                    controller: controller.electricityNewUnitController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Present Reading',
                    ),
                  ).w(.45.sw),
                ],
              ),
              10.heightBox,
              'Electricity Price Per Unit'.text.bold.extraBlack.make(),
              4.heightBox,
              TextFormField(
                validator: controller.notBlankValidator,
                controller: controller.electricityPricePerUnitController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Price Per Unit',
                ),
              ),
              10.heightBox,
              'Water & Waste'.text.bold.extraBlack.make(),
              4.heightBox,
              TextFormField(
                controller: controller.waterWasteController,
                validator: controller.notBlankValidator,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Water & waste',
                ),
              ),
              10.heightBox,
              'Previous due'.text.bold.extraBlack.make(),
              4.heightBox,
              TextFormField(
                controller: controller.previousDueController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return null;
                  }
                  if (!value!.isNumericOnly) {
                    return 'Invalid amount';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Previous due',
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    Get
                      ..back<dynamic>()
                      ..dialog<dynamic>(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Screenshot<Widget>(
                              controller: controller.screenshotController,
                              child: const _BillPdfView(),
                            ),
                            20.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.edit),
                                  label: 'Edit'.text.make(),
                                ).backgroundColor(Colors.white).card.make(),
                                TextButton.icon(
                                  onPressed: controller.onSendPress,
                                  icon: const Icon(
                                    Iconsax.send_square,
                                    color: Colors.white,
                                  ),
                                  label: 'Send Invoice'.text.white.make(),
                                )
                                    .backgroundColor(
                                        Get.theme.scaffoldBackgroundColor)
                                    .card
                                    .make(),
                              ],
                            ),
                          ],
                        ).px16(),
                      );
                  }
                },
                icon: const Icon(Iconsax.bill),
                label: const Text('Generate Bill'),
              ).backgroundColor(Vx.gray200).card.makeCentered(),
              20.heightBox,
            ],
          ).px8(),
        ),
      ).card.make(),
    );
  }
}

class _BillPdfView extends GetWidget<BillController> {
  const _BillPdfView();

  UserModel get _user => Get.find<UserModel>(
        tag: controller.selectedRoomNo.string,
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Iconsax.card),
              8.widthBox,
              'Invoice details'.text.bold.make(),
            ],
          ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Room no.'.text.bold.make(),
              controller.selectedRoomNo.string.text.bold.make(),
            ],
          ),
          10.heightBox,
          Container(
            color: Colors.black45,
            width: double.infinity,
            height: 1,
          ).py12(),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Client's email".text.black.make(),
                  _user.email.text.extraBlack.make(),
                ],
              ),
              Container(
                color: Colors.black38,
                width: 1,
                height: 40,
              ).py4(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  'Invoice Date'.text.black.make(),
                  NepaliDateFormat.yMMMMEEEEd()
                      .format(NepaliDateTime.now())
                      .text
                      .extraBlack
                      .make(),
                ],
              ),
            ],
          ),
          Container(
            color: Colors.black45,
            width: double.infinity,
            height: 1,
          ).py12(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Room Rent'.text.make(),
              controller.getRoomRent().text.make(),
            ],
          ),
          4.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Electricity Units Consumed'.text.make(),
              controller.getConsumedUnits().text.make(),
            ],
          ),
          4.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Total Electricity Amount'.text.make(),
              controller.getTotalElectricityAmount().text.make(),
            ],
          ),
          4.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Water & Waste'.text.make(),
              controller.getWaterAndWaste().text.make(),
            ],
          ),
          4.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Due Amount'.text.make(),
              controller.getPreviousDue().text.make(),
            ],
          ),
          4.heightBox,
          Container(
            color: Colors.black45,
            width: double.infinity,
            height: 1,
          ).py12(),
          4.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Total amount'.text.bold.make(),
              controller.getTotalAmount().text.bold.make(),
            ],
          ),
        ],
      ).pSymmetric(v: 32, h: 16),
    );
  }
}
