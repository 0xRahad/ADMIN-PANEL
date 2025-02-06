import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      webOptions: WebOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));


  Future<bool> setValue(String key, dynamic value) async {
    await storage.write(key: key, value: value);
    return true;
  }

  Future<dynamic> readValue(String key) async {
    return await storage.read(key: key);
  }

  Future<bool> clearValue(String key) async {
    await storage.delete(key: key);
    return true;
  }
}
