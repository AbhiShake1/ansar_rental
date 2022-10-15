import 'package:ansar_rental/app/data/repo/local_auth_repo.dart';
import 'package:ansar_rental/app/modules/login/controllers/login_controller.dart';
import 'package:ansar_rental/app/modules/login/repo/auth_repo.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(AuthClient.new)
      ..lazyPut(LoginController.new)
      ..lazyPut(AuthRepo.new);
  }
}
