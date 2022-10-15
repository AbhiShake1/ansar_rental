import 'package:local_auth/local_auth.dart';

class LocalAuthClient {
  final _auth = LocalAuthentication();

  // Future<bool> isSupported() async {
  //   final isSupported = await _auth.isDeviceSupported();
  //   if (!isSupported) return false;
  //   return _auth.canCheckBiometrics;
  // }

  ///uses pin/password if biometrics isnt available
  Future<bool> authenticate() => _auth.authenticate(
        localizedReason: 'Enter your fingerprint to login',
      );
}
