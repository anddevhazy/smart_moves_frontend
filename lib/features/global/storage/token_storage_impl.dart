import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_moves/features/global/storage/token_storage.dart';

class TokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage flutterSecureStorage;

  TokenStorageImpl(this.flutterSecureStorage);

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';
  static const _roleKey = 'role';
  static const _userIdKey = 'user_id';
  static const _userNameKey = 'user_name';
  static const _userEmailKey = 'user_email';

  @override
  Future<void> saveAccessToken(String token) async {
    await flutterSecureStorage.write(key: _accessKey, value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await flutterSecureStorage.write(key: _refreshKey, value: token);
  }

  @override
  Future<String?> getAccessToken() async {
    return flutterSecureStorage.read(key: _accessKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return flutterSecureStorage.read(key: _refreshKey);
  }

  @override
  Future<void> clearTokens() async {
    await flutterSecureStorage.delete(key: _accessKey);
    await flutterSecureStorage.delete(key: _refreshKey);
    await flutterSecureStorage.delete(key: _roleKey);
    await flutterSecureStorage.delete(key: _userIdKey);
    await flutterSecureStorage.delete(key: _userNameKey);
    await flutterSecureStorage.delete(key: _userEmailKey);
  }
}
