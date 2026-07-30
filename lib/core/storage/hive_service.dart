import 'package:hive_flutter/hive_flutter.dart';


class HiveService {
  HiveService._internal();

  static final HiveService _instance = HiveService._internal();

  factory HiveService() => _instance;

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter();

    _isInitialized = true;
  }

  Future<Box<T>> openBox<T>(
    String boxName,
  ) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }

    return Hive.box<T>(boxName);
  }

  Box<T> getBox<T>(
    String boxName,
  ) {
    if (!Hive.isBoxOpen(boxName)) {
      throw Exception(
        "Box $boxName is not opened.",
      );
    }

    return Hive.box<T>(boxName);
  }

  Future<void> put<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = await openBox<T>(boxName);

    await box.put(key, value);
  }

  T? get<T>({
    required String boxName,
    required String key,
  }) {
    final box = getBox<T>(boxName);

    return box.get(key);
  }

  Future<void> delete({
    required String boxName,
    required String key,
  }) async {
    final box = await openBox(boxName);

    await box.delete(key);
  }

  bool containsKey({
    required String boxName,
    required String key,
  }) {
    final box = getBox(boxName);

    return box.containsKey(key);
  }

  Future<void> clearBox(
    String boxName,
  ) async {
    final box = await openBox(boxName);

    await box.clear();
  }

  Future<void> closeBox(
    String boxName,
  ) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  Future<void> closeHive() async {
    await Hive.close();
  }
}
