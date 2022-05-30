import 'package:social_media_app/data/models/social_model.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/network/real_time_database_data_agent_impl.dart';
import 'package:social_media_app/network/social_data_agent.dart';

class SocialModelImpl extends SocialModel {

  static final SocialModelImpl _singleton = SocialModelImpl._internal();

  factory SocialModelImpl() {
    return _singleton;
  }

  SocialModelImpl._internal();

  SocialDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }

  @override
  Future<void> addNewPost(String description) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = NewsFeedVO(
      id: currentMilliseconds,
      userName: "Nyan Win Naing",
      postImage: "",
      description: description,
      profilePicture: "https://wallpapers.com/images/high/happy-jerry-mouse-2021-illustration-x1kxds1wc02j9l8l.jpg",
    );
    return mDataAgent.addNewPost(newPost);
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

}