import 'package:ansar_rental/app/modules/login/controllers/login_controller.dart';
import 'package:ansar_rental/app/modules/login/repo/auth_repo.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(LoginController.new)
      ..lazyPut(AuthRepo.new);
  }
}
