import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:ansar_rental/app/packages/firestore_client/firestore_client.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _dbClient = Get.find<FirestoreClient>();
  final _authClient = Get.find<AuthClient>();

  Future<UserModel> get currentUser => _dbClient.getCurrentUser();

  Stream<UserModel> get streamCurrentUser => _dbClient.streamCurrentUser();

  Future<void> logout() async {
    await _authClient.logout();
  }

  Future<void> resetPassword() => callService(
        () => _authClient.sendPasswordResetEmail(
          _authClient.currentUser.email!,
        ),
        onSuccess: () {
          Get.snackbar(
            'Successful',
            'Password reset form has been sent to your email. '
                'Be sure to check spam emails for the link too.',
            snackPosition: SnackPosition.BOTTOM,
          );
          _authClient.logout();
        },
        onFailure: (error) => Get.snackbar(
          'Something went wrong',
          error.toString(),
        ),
      );

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
