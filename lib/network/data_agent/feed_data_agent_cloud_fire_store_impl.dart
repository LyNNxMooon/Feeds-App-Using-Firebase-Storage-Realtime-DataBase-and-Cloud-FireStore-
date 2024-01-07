import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/network/data_agent/feed_data_agent.dart';

const kFeedPath = 'feed';

class FeedDataAgentCloudFireStoreImpl extends FeedDataAgent {
  FeedDataAgentCloudFireStoreImpl._();

  static final FeedDataAgentCloudFireStoreImpl _singleton =
      FeedDataAgentCloudFireStoreImpl._();

  factory FeedDataAgentCloudFireStoreImpl() => _singleton;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future deleteFeed(int id) =>
      _firebaseFirestore.collection(kFeedPath).doc(id.toString()).delete();

  @override
  Future<FeedVO> getFeedByID(int id) async {
    return _firebaseFirestore
        .collection(kFeedPath)
        .doc(id.toString())
        .get()
        .then((value) {
      final rawData = value.data();
      return FeedVO.fromJson(Map<String, dynamic>.from(rawData as Map));
    });
  }

  @override
  Stream<List<FeedVO>?> getFeedListStream() =>
      _firebaseFirestore.collection(kFeedPath).snapshots().map((event) {
        return event.docs.map((document) {
          return FeedVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future saveFeed(FeedVO feedVO) => _firebaseFirestore
      .collection(kFeedPath)
      .doc(feedVO.id.toString())
      .set(feedVO.toJson());
}
