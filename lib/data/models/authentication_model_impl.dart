import 'package:social_media_app/data/models/authentication_model.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:social_media_app/network/real_time_database_data_agent_impl.dart';
import 'package:social_media_app/network/social_data_agent.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton =
      AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();

  SocialDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();
  // SocialDataAgent mDataAgent = CloudFirestoreDataAgentImpl();

  @override
  UserVO getLoggedInUser() {
    // TODO: implement getLoggedInUser
    throw UnimplementedError();
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> register(String email, String userName, String password) {
    return craftUserVO(email, password, userName)
        .then((user) => mDataAgent.registerNewUser(user));
  }

  Future<UserVO> craftUserVO(String email, String password, String userName) {
    var newUser = UserVO(
      id: "",
      userName: userName,
      email: email,
      password: password,
    );
    return Future.value(newUser);
  }
}
