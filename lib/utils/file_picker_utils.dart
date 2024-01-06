import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtils {
  static Future<File?> getImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result == null) {
      return null;
    }
    return File(result.files.single.path ?? '');
  }

  static Future<File?> getVideo() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false);
    if (result == null) {
      return null;
    }
    return File(result.files.single.path ?? '');
  }

  static Future<File?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf']);
    if (result == null) {
      return null;
    }
    return File(result.files.single.path ?? '');
  }
}
