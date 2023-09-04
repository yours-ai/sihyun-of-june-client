import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage getSecureStorage() {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  return FlutterSecureStorage(aOptions: _getAndroidOptions());
}