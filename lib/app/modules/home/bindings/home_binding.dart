import 'package:ansar_rental/app/controllers/profile_controller.dart';
import 'package:ansar_rental/app/modules/home/controllers/bill_controller.dart';
import 'package:ansar_rental/app/modules/home/controllers/home_controller.dart';
import 'package:ansar_rental/app/modules/home/controllers/user_controller.dart';
import 'package:ansar_rental/app/modules/home/repo/user_repo.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:ansar_rental/app/packages/firestore_client/firestore_client.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(AuthClient.new)
      ..lazyPut(BillController.new)
      ..lazyPut(UserController.new)
      ..lazyPut(ProfileController.new)
      ..lazyPut(FirestoreClient.new)
      ..lazyPut(HomeController.new)
      ..lazyPut(UserRepo.new);
  }
}
