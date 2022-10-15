import 'dart:io';

import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/modules/home/repo/user_repo.dart';
import 'package:ansar_rental/app/packages/firestore_client/firestore_client.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

//getx service is implemented so that it doesn't get disposed, but its more
// of a controller than service
class AddUserController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements GetxService {
  AddUserController({this.user});

  final _userRepo = Get.find<UserRepo>();
  final _storageClient = Get.find<FirestoreClient>();

  final UserModel? user;

  Future<CroppedFile?> cropImage(XFile? image) async {
    if (image == null) return null;
    final cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Make sure you are clearly visible',
        ),
        IOSUiSettings(
            //TODO: Setup for IOS
            ),
      ],
    );
    return cropped;
  }

  Future<XFile?> getImage(ImageSource imageSource) =>
      ImagePicker().pickImage(source: imageSource);

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
      noOfTenantsController,
      notesController,
      startingYearController,
      startingMonthController,
      startingDayController;

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
      noOfTenantsNode,
      startingYearNode,
      startingMonthNode,
      startingDayNode;

  late final TabController tabController;

  final isPasswordVisible = false.obs, isAdmin = false.obs;

  final profileImagePath = Rx<String?>(null),
      documentImagePath = Rx<String?>(null);

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    nameController = TextEditingController(text: user?.name);
    emailController = TextEditingController(text: user?.email);
    passwordController = TextEditingController(text: user?.password);
    addressController = TextEditingController(text: user?.address);
    contactNumberController =
        TextEditingController(text: user?.contactNumber.toString());
    monthlyRentController =
        TextEditingController(text: user?.monthlyRent.toString());
    waterRentController =
        TextEditingController(text: user?.waterRent.toString());
    roomNoController = TextEditingController(text: user?.roomNo.toString());
    guardianNameController = TextEditingController(text: user?.guardianName);
    guardianContactNumberController =
        TextEditingController(text: user?.guardianContactNumber.toString());
    startingElectricityUnitsController =
        TextEditingController(text: user?.startingElectricityUnits.toString());
    noOfTenantsController =
        TextEditingController(text: user?.noOfTenants.toString());
    notesController = TextEditingController(text: user?.notes);
    startingYearController = TextEditingController(
      text: user?.startingDate.year.toString(),
    );
    startingYearController.addListener(() {
      if (startingYearController.text.length == 4) {
        startingMonthNode.requestFocus();
      }
    });
    startingMonthController = TextEditingController(
      text: user?.startingDate.month.toString(),
    );
    startingMonthController.addListener(() {
      if (startingMonthController.text.length == 2) {
        startingDayNode.requestFocus();
      }
    });
    startingDayController = TextEditingController(
      text: user?.startingDate.day.toString(),
    );
    startingDayController.addListener(() {
      if (startingDayController.text.length == 2) {
        Get.focusScope?.unfocus();
      }
    });
    nameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    addressNode = FocusNode();
    contactNumberNode = FocusNode();
    monthlyRentNode = FocusNode();
    waterRentNode = FocusNode();
    roomNoNode = FocusNode();
    guardianNameNode = FocusNode();
    startingYearNode = FocusNode();
    startingMonthNode = FocusNode();
    startingDayNode = FocusNode();
    guardianContactNumberNode = FocusNode();
    startingElectricityUnitsNode = FocusNode();
    noOfTenantsNode = FocusNode();
    tabController = TabController(length: 2, vsync: this);

    if (user != null) {
      final cache = DefaultCacheManager();

      cache
          .getSingleFile(user!.photoUrl)
          .then((value) => profileImagePath.value = value.path);

      if (!user!.isAdmin) {
        cache
            .getSingleFile(user!.documentUrl)
            .then((value) => documentImagePath.value = value.path);
      }
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void _clearAll() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    addressController.clear();
    contactNumberController.clear();
    monthlyRentController.clear();
    waterRentController.clear();
    roomNoController.clear();
    guardianNameController.clear();
    guardianContactNumberController.clear();
    startingElectricityUnitsController.clear();
    noOfTenantsController.clear();
    notesController.clear();
    startingYearController.clear();
    startingMonthController.clear();
    startingDayController.clear();
    profileImagePath.value = null;
    documentImagePath.value = null;
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

  Future<void> registerAdmin() async {
    if (!formKey.currentState!.validate()) return;

    if (profileImagePath.value == null) {
      Get.snackbar('Error', 'Please upload required images');
      return;
    }

    await callService(
      () async {
        final profileUrl = await _uploadImage(profileImagePath.value!);

        final _user = await _userRepo.registerUser(
          id: user?.id,
          toUpdate: user != null,
          name: nameController.text,
          password: passwordController.text,
          email: emailController.text,
          photoUrl: profileUrl!,
          isAdmin: user?.isAdmin ?? false,
        );

        // ignore: only_throw_errors
        _user.fold((l) => null, (r) => throw r);
      },
      onSuccess: () {
        //TODO: enable back after testing
        // _clearAll();
        Get
          ..until((route) => route.isFirst)
          ..snackbar(
            'Successful',
            'Admin ${user == null ? 'added' : 'updated'} successfully',
            snackPosition: SnackPosition.BOTTOM,
          );
      },
      onFailure: (e) => Get.snackbar(
        'Something went wrong',
        e!.toString(),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    if (profileImagePath.value == null || documentImagePath.value == null) {
      Get.snackbar('Error', 'Please upload required images');
      return;
    }

    await callService(
      () async {
        final profileUrl = await _uploadImage(profileImagePath.value!),
            documentUrl = await _uploadImage(documentImagePath.value!);

        final year = startingYearController.text,
            month = startingMonthController.text,
            day = startingDayController.text;

        final startingDate = DateTime.tryParse('$year$month$day');

        if (startingDate == null) {
          throw 'Invalid date format';
        }

        final _user = await _userRepo.registerUser(
          id: user?.id,
          toUpdate: user != null,
          name: nameController.text,
          password: passwordController.text,
          email: emailController.text,
          address: addressController.text,
          contactNumber: int.parse(contactNumberController.text),
          guardianName: guardianNameController.text,
          roomNo: int.parse(roomNoController.text),
          monthlyRent: int.parse(monthlyRentController.text),
          //TODO: use custom date for starting date
          startingDate: startingDate,
          guardianContactNumber:
              int.parse(guardianContactNumberController.text),
          waterRent: num.parse(waterRentController.text),
          startingElectricityUnits:
              int.parse(startingElectricityUnitsController.text),
          noOfTenants: int.parse(noOfTenantsController.text),
          //TODO: use custom data for isAdmin
          isAdmin: false,
          //TODO: add these
          documentUrl: documentUrl!,
          photoUrl: profileUrl!,
          notes: notesController.text,
        );

        // ignore: only_throw_errors
        _user.fold((l) => null, (r) => throw r);
      },
      onSuccess: () {
        //TODO: enable back after testing
        // _clearAll();
        Get
          ..until((route) => route.isFirst)
          ..snackbar(
            'Successful',
            'Tenant ${user == null ? 'added' : 'updated'} successfully',
            snackPosition: SnackPosition.BOTTOM,
          );
      },
      onFailure: (e) => Get.snackbar(
        'Something went wrong',
        e!.toString(),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }

  Future<String?> _uploadImage(String path) async {
    final file = File(path);
    final url = await _storageClient.uploadUserImage(file);
    return url;
  }
}
