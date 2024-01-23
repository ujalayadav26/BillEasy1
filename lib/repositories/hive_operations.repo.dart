import 'package:hive/hive.dart';

class HiveOperationsRepository<T extends HiveObject> {
  final String boxName;

  HiveOperationsRepository(this.boxName);

  Future<Box<T>> _openBox() async {
    return Hive.isBoxOpen(boxName)
        ? Hive.box<T>(boxName)
        : await Hive.openBox<T>(boxName);
  }

  Future<void> save(T object, dynamic? id) async {
    final box = await _openBox();
    if (id != null) {
      await box.put(id, object);
    } else {
      await box.add(object);
    }
  }

  Future<List<T>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<T?> getById(dynamic id) async {
    final box = await _openBox();
    return box.get(id);
  }

  Future<void> delete(dynamic id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
