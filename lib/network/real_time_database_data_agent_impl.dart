import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/social_data_agent.dart';

/// Database Paths
const newsFeedPath = "newsfeed";
const usersPath = "users";

/// File Upload References
const fileUploadRef = "uploads";

class RealTimeDatabaseDataAgentImpl extends SocialDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.reference();

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return databaseRef.child(newsFeedPath).onValue.map((event) {
      print(event.snapshot.value.toString());

      /// event.snapshot.value => Map<String, dynamic> => values => List<Map<String, dynamic>> => NewsFeedVO.fromJson() => List<NewsFeedVO>
      return event.snapshot.value.values.map<NewsFeedVO>((element) {
        return NewsFeedVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    return databaseRef
        .child(newsFeedPath)
        .child(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return databaseRef.child(newsFeedPath).child(postId.toString()).remove();
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId) {
    return databaseRef
        .child(newsFeedPath)
        .child(newsFeedId.toString())
        .once()
        .asStream()
        .map((snapShot) {
      return NewsFeedVO.fromJson(
        Map<String, dynamic>.from(snapShot.value),
      );
    });
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapShot) => taskSnapShot.ref.getDownloadURL());
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
    );
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) =>
            credential.user?..updateDisplayName(newUser.userName))
        .then((user) {
      newUser.id = user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return databaseRef
        .child(usersPath)
        .child(newUser.id.toString())
        .set(newUser.toJson());
  }
}
