import 'package:ansar_rental/app/modules/home/controllers/add_user_controller.dart';
import 'package:ansar_rental/app/modules/home/controllers/home_controller.dart';
import 'package:ansar_rental/app/modules/home/controllers/user_controller.dart';
import 'package:ansar_rental/app/modules/home/repo/user_repo.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(UserController.new)
      ..lazyPut(AuthClient.new)
      ..lazyPut(AddUserController.new)
      ..lazyPut(HomeController.new)
      ..lazyPut(UserRepo.new);
  }
}
