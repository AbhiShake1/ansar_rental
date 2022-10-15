import 'package:ansar_rental/app/packages/firestore_client/firestore_client.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService {
  final _dbClient = Get.find<FirestoreClient>();

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

  Future<void> kickUser(String uid) => callService(
        () => _dbClient.kickUser(uid),
        onFailure: (error) => Get
          ..back<dynamic>()
          ..snackbar('Something went wrong', 'User could not be deleted'),
        onSuccess: () => Get
          ..back<dynamic>()
          ..back<dynamic>()
          ..snackbar('Success', 'Tenant unregistered successfully'),
      );

  String get currentUid => _dbClient.currentUID;
}
