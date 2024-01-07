import 'package:feeds/bloc/base_bloc.dart';
import 'package:feeds/data/models/feed_model.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/utils/enums.dart';

class FeedDetailsPageBloc extends BaseBloc {
  FeedVO? feed;

  FeedVO? get getFeed => feed;

  final FeedModel _feedModel = FeedModel();

  FeedDetailsPageBloc({required int feedID}) {
    setLoadingState = LoadingState.loading;
    notifyListeners();

    _feedModel.getFeedByID(feedID).then((value) {
      setLoadingState = LoadingState.complete;
      feed = value;
      notifyListeners();
    }).catchError((error) {
      setLoadingState = LoadingState.error;
      setErrorMessage = error.toString();
      notifyListeners();
    });
  }

  Future saveFeed(
      String description, int id, String fileURL, String fileType) async {
    final feed = FeedVO(
        id: id,
        feedTitle: description,
        fileURL: fileURL,
        fileType: fileType,
        createdAt: DateTime.now().toString());
    return _feedModel.saveFeed(feed);
  }

  void deleteFeed(int id) => _feedModel.deleteFeed(id);
}
