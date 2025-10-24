import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadAvatar(String userId, Uint8List bytes) async {
    final ref = _storage.ref().child('avatars/$userId.jpg');
    final task = await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
    return await task.ref.getDownloadURL();
  }

  Future<void> deleteAvatar(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      // ignore if missing
    }
  }
}
