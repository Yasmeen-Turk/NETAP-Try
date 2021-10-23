import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    return await _auth.canCheckBiometrics;
  }

  static Future<List<BiometricType>> getBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    return await _auth.authenticate(
      localizedReason: 'Scan Fingerprint to Authenticate',
      useErrorDialogs: true,
      stickyAuth: true,
    );
  }
}
