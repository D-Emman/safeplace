import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String gratitudeBox = 'gratitude';
  static const String settingsBox = 'settings';
  static const String cacheBox = 'cache';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(gratitudeBox);
    await Hive.openBox(settingsBox);
    await Hive.openBox(cacheBox);
  }

  Box getGratitudeBox() => Hive.box(gratitudeBox);
  Box getSettingsBox() => Hive.box(settingsBox);
  Box getCacheBox() => Hive.box(cacheBox);

  Future<void> addGratitude(String text) async {
    final box = getGratitudeBox();
    await box.add({'text': text, 'createdAt': DateTime.now().toIso8601String()});
  }

  List<Map> getAllGratitude() {
    final box = getGratitudeBox();
    return box.values.cast<Map>().toList();
  }
}
