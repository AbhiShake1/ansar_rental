import 'package:ansar_rental/app/modules/home/repo/user_repo.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

//getx service is implemented so that it doesn't get disposed, but its more
// of a controller than service
class AddUserController extends GetxController implements GetxService {
  late final TextEditingController nameController,
      emailController,
      passwordController,
      addressController,
      contactNumberController,
      monthlyRentController,
      waterRentController,
      roomNoController,
      guardianNameController,
      guardianContactNumberController,
      startingElectricityUnitsController,
      noOfTenantsController;

  late final FocusNode nameNode,
      emailNode,
      passwordNode,
      addressNode,
      contactNumberNode,
      monthlyRentNode,
      waterRentNode,
      roomNoNode,
      guardianNameNode,
      guardianContactNumberNode,
      startingElectricityUnitsNode,
      noOfTenantsNode;

  final isPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();

  final _userRepo = Get.find<UserRepo>();

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController();
    contactNumberController = TextEditingController();
    monthlyRentController = TextEditingController();
    waterRentController = TextEditingController();
    roomNoController = TextEditingController();
    guardianNameController = TextEditingController();
    guardianContactNumberController = TextEditingController();
    startingElectricityUnitsController = TextEditingController();
    noOfTenantsController = TextEditingController();
    nameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    addressNode = FocusNode();
    contactNumberNode = FocusNode();
    monthlyRentNode = FocusNode();
    waterRentNode = FocusNode();
    roomNoNode = FocusNode();
    guardianNameNode = FocusNode();
    guardianContactNumberNode = FocusNode();
    startingElectricityUnitsNode = FocusNode();
    noOfTenantsNode = FocusNode();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    contactNumberController.dispose();
    monthlyRentController.dispose();
    waterRentController.dispose();
    roomNoController.dispose();
    guardianNameController.dispose();
    guardianContactNumberController.dispose();
    startingElectricityUnitsController.dispose();
    noOfTenantsController.dispose();
    nameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    addressNode.dispose();
    contactNumberNode.dispose();
    monthlyRentNode.dispose();
    waterRentNode.dispose();
    roomNoNode.dispose();
    guardianNameNode.dispose();
    guardianContactNumberNode.dispose();
    startingElectricityUnitsNode.dispose();
    noOfTenantsNode.dispose();
    super.onClose();
  }

  String? emailValidator(String? email) =>
      email?.isEmail ?? false ? null : 'Invalid Email';

  String? notEmptyValidator(String? text) =>
      text?.isEmpty ?? true ? 'Required' : null;

  String? contactNumberValidator(String? text) {
    if (text?.isEmpty ?? true) {
      return 'Required';
    }

    if (!RegExp(r'^9[0-9]{9}$').hasMatch(text!)) {
      return 'Invalid Number';
    }

    return null;
  }

  String? passwordValidator(String? text) {
    if (text?.isEmpty ?? true) {
      return 'Required';
    }

    if (text!.length < 8) {
      return 'Password must be at least 8 character long';
    }

    return null;
  }

  String? lessThan10Validator(String? text) {
    if (text?.isEmpty ?? true) {
      return 'Required';
    }
    final number = int.parse(text!);
    if (number == 0) {
      return '0 tenants not allowed';
    }
    if (number > 10) {
      return 'Only 10 tenants allowed';
    }

    return null;
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    await callService(
      () async {
        final user = await _userRepo.registerUser(
          name: nameController.text,
          password: passwordController.text,
          email: emailController.text,
          address: addressController.text,
          contactNumber: int.parse(contactNumberController.text),
          guardianName: guardianNameController.text,
          roomNo: int.parse(roomNoController.text),
          monthlyRent: int.parse(monthlyRentController.text),
          //TODO: use custom date for starting date
          startingDate: DateTime.now(),
          guardianContactNumber:
              int.parse(guardianContactNumberController.text),
          waterRent: num.parse(waterRentController.text),
          startingElectricityUnits:
              num.parse(startingElectricityUnitsController.text),
          noOfTenants: int.parse(noOfTenantsController.text),
          //TODO: use custom data for isAdmin
          isAdmin: false,
          //TODO: add these
          documentUrl: '',
          photoUrl: '',
        );

        // ignore: only_throw_errors
        user.fold((l) => null, (r) => throw r);
      },
      onSuccess: () => Get.snackbar(
        'Successful',
        'Tenant added successfully',
        snackPosition: SnackPosition.BOTTOM,
      ),
      onFailure: (e) => Get.snackbar(
        'Something went wrong',
        e!.toString(),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }
}
