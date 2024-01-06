import 'package:feeds/bloc/base_bloc.dart';
import 'package:feeds/constants/strings.dart';
import 'package:feeds/data/models/feed_model.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/utils/enums.dart';

class HomePageBloc extends BaseBloc {
  List<FeedVO>? _feedList;

  List<FeedVO>? get getFeedList => _feedList;

  final FeedModel _feedModel = FeedModel();

  Future deleteFeed(int id) => _feedModel.deleteFeed(id);

  HomePageBloc() {
    setLoadingState = LoadingState.loading;
    notifyListeners();
    _feedModel.getFeedListStream().listen((event) {
      if (event?.isEmpty ?? true) {
        setLoadingState = LoadingState.error;
        setErrorMessage = kHomePageEmptyFeedText;
        notifyListeners();
      } else {
        setLoadingState = LoadingState.complete;
        _feedList = event;
        notifyListeners();
      }
    }, onError: (error) {
      setErrorMessage = error;
      notifyListeners();
    });
  }
}
