import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _dbClient = Get.find<AuthClient>();

  Future<UserModel> get currentUser => _dbClient.getCurrentUser();
  Stream<UserModel> get streamCurrentUser => _dbClient.streamCurrentUser();

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
