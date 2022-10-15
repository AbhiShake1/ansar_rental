import 'package:ansar_rental/app/data/repo/local_auth_repo.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalAuthController extends GetxController implements GetxService {
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

  void toggleBioAuth() => GetStorage('BIOMETRIC_AUTH')
      .write('enabled_key', bioAuthEnabled.toggle().value);

  final bioAuthEnabled =
      (GetStorage('BIOMETRIC_AUTH').read<bool>('enabled_key') ?? false).obs;

  final _localAuthRepo = Get.find<LocalAuthRepo>();

  Future<void> authenticateWithBiometrics() => callService(
        _localAuthRepo.authenticateWithBiometrics,
        onFailure: (error) => Get.snackbar(
          'Something went wrong',
          '',
          snackPosition: SnackPosition.BOTTOM,
        ),
        showLoading: false,
      );
}
