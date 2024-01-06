import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileUploadToFireBaseUtils {
  static final _firebaseStorage = FirebaseStorage.instance;

  static Future<String> uploadToFirebaseStorage(
      File file, String path, String contentType) {
    var metadata = SettableMetadata(contentType: contentType);
    return _firebaseStorage
        .ref(path)
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(file, metadata)
        .then((takeSnapShot) {
      return takeSnapShot.ref.getDownloadURL().then((value) {
        return value;
      });
    });
  }
}
