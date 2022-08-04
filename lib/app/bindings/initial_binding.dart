import 'package:ansar_rental/app/controllers/add_user_controller.dart';
import 'package:ansar_rental/app/controllers/profile_controller.dart';
//import 'package:ansar_rental/app/controllers/profile_setting_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(ProfileController.new)
      ..lazyPut(AddUserController.new);
    //..lazyPut(ProfileSettingController.new);
  }
}
