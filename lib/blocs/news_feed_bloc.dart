import 'package:flutter/foundation.dart';
import 'package:social_media_app/data/models/social_model.dart';
import 'package:social_media_app/data/models/social_model_impl.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';

class NewsFeedBloc extends ChangeNotifier {
  List<NewsFeedVO>? newsFeed;

  final SocialModel _mSocialModel = SocialModelImpl();

  bool isDisposed = false;

  NewsFeedBloc() {
    _mSocialModel.getNewsFeed().listen((newsFeedList) {
      newsFeed = newsFeedList;
      if(!isDisposed) {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}