import 'package:ebuy/data_source/remote_data_source/user_data_source.dart';

import '../model/user.dart';

abstract class Userrepository {
  Future<int> registeruser(User user);
  Future<bool?> loginstudent(String username, String password);
  Future<List<User>> getUser();
  Future<int> updateUser(String username, String email, String pic);
}

class Userrepositoryimp extends Userrepository {
  @override
  Future<int> registeruser(User user) {
    return UserRemoteDataSource().adduser(user);
  }

  @override
  Future<bool> loginstudent(String username, String password) {
    return UserRemoteDataSource().loginuser(username, password);
  }

  @override
  Future<List<User>> getUser() async {
    bool status = true;
    List<User> lsthostel = [];
    print(lsthostel);

    lsthostel = await UserRemoteDataSource().getUser();
    print(lsthostel);
    return lsthostel;
  }

  @override
  Future<int> updateUser(String username, String email, String pic) async {
    bool status = true;
    int lsthostel = 2;
    if (status) {
      lsthostel = await UserRemoteDataSource().updateUser(username, email, pic);
      return lsthostel;
    }
  }
}
