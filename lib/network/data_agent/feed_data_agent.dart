import 'package:feeds/data/vos/feed_vo.dart';

abstract class FeedDataAgent {
  Stream<List<FeedVO>?> getFeedListStream();

  Future<FeedVO> getFeedByID(int id);

  Future saveFeed(FeedVO feedVO);

  Future deleteFeed(int id);
}
