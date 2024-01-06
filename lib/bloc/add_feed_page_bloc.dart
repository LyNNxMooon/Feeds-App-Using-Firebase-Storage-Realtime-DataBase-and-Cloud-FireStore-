import 'dart:io';

import 'package:feeds/bloc/base_bloc.dart';
import 'package:feeds/data/models/feed_model.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/utils/enums.dart';
import 'package:feeds/utils/file_upload_to_fire_base_storage_utils.dart';

class AddFeedPageBloc extends BaseBloc {
  FileType _fileType = FileType.image;
  File? _selectFile;

  File? get getSelectFile => _selectFile;

  FileType get getFileType => _fileType;
  final FeedModel _feedModel = FeedModel();

  Future saveFeed(String description) async {
    if (description.isEmpty) {
      return Future.error("Please write what is in your mind");
    }
    int id = DateTime.now().millisecondsSinceEpoch;

    String fileURL = await _uploadFileToFirebaseStorage();

    final feed = FeedVO(
        id: id,
        feedTitle: description,
        fileURL: fileURL,
        fileType: _fileType.name,
        createdAt: DateTime.now().toString());
    return _feedModel.saveFeed(feed);
  }

  Future _uploadFileToFirebaseStorage() {
    String path = '';
    String contentType = '';
    if (_fileType == FileType.image) {
      path = 'image';
      contentType = 'image/jpg';
    } else if (_fileType == FileType.video) {
      path = 'video';
      contentType = 'video/mp4';
    } else {
      path = 'file';
      contentType = 'file/pdf';
    }
    if (_selectFile == null) {
      return Future.error('Please select File');
    }
    return FileUploadToFireBaseUtils.uploadToFirebaseStorage(
        _selectFile!, path, contentType);
  }

  set setFileType(FileType fileType) {
    _fileType = fileType;
    notifyListeners();
  }

  set setSelectFile(File? file) {
    _selectFile = file;
    notifyListeners();
  }
}
