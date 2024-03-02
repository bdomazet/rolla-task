import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage() {
    flutterSecureStorage = const FlutterSecureStorage();
  }
  late FlutterSecureStorage flutterSecureStorage;

  Future<void> addString(String key, String value) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    final String? value = await flutterSecureStorage.read(key: key);
    return value;
  }

  Future<void> deleteString(String key) async {
    await flutterSecureStorage.delete(key: key);
  }
}
