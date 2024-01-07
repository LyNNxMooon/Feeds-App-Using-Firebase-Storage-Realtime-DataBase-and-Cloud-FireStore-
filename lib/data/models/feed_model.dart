import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/network/data_agent/feed_data_agent.dart';
//import 'package:feeds/network/data_agent/feed_data_agent_cloud_fire_store_impl.dart';
import 'package:feeds/network/data_agent/feed_data_agent_real_time_data_base_impl.dart';

class FeedModel {
  FeedModel._();

  static final FeedModel _singleton = FeedModel._();

  factory FeedModel() => _singleton;

  final FeedDataAgent _feedDataAgent = FeedDataAgentRealTimeDatabaseImpl();

  //final FeedDataAgent _feedDataAgent = FeedDataAgentCloudFireStoreImpl();

  Future<FeedVO> getFeedByID(int id) => _feedDataAgent.getFeedByID(id);

  void saveFeed(FeedVO feedVO) => _feedDataAgent.saveFeed(feedVO);

  void deleteFeed(int id) => _feedDataAgent.deleteFeed(id);

  Stream<List<FeedVO>?> getFeedListStream() =>
      _feedDataAgent.getFeedListStream();
}
