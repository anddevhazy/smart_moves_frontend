import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  final FlutterSecureStorage _storage;
  static const _key = 'device_id';

  DeviceIdService(this._storage);

  Future<String> getOrCreate() async {
    final existing = await _storage.read(key: _key);
    if (existing != null) return existing;

    final newId = const Uuid().v4();
    await _storage.write(key: _key, value: newId);
    return newId;
  }
}
