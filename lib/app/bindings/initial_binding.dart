import 'package:ansar_rental/app/controllers/add_user_controller.dart';
import 'package:ansar_rental/app/controllers/local_auth_controller.dart';
import 'package:ansar_rental/app/controllers/profile_controller.dart';
import 'package:ansar_rental/app/data/repo/local_auth_repo.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(LocalAuthRepo.new, fenix: true)
      ..lazyPut(LocalAuthController.new)
      ..lazyPut(ProfileController.new)
      ..lazyPut(AddUserController.new);
  }
}
