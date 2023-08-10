import 'package:dio/dio.dart';
import 'package:ebuy/app/constants.dart';
import 'package:ebuy/data_source/remote_data_source/response/login_response.dart';
import 'package:ebuy/data_source/remote_data_source/response/profile_response.dart';
import 'package:ebuy/helper/http_service.dart';
import 'package:ebuy/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> adduser(User user) async {
    try {
      Response response = await _httpServices.post(
        Constant.regitserURL,
        data: {
          'name': user.name,
          'email': user.email,
          'password': user.password,
        },
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<bool> loginuser(String username, String password) async {
    try {
      Response response = await _httpServices.post(
        Constant.userLoginURL,
        data: {
          'name': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token!}";
        Constant.usserid = loginResponse.id!;
        addToken(loginResponse.token!);
        adduserid(loginResponse.id!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> updateUser(String username, String email, String pic) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString('_id')!;
    try {
      Response response = await _httpServices.put(
        '${Constant.getuser}/$userid',
        data: {
          'name': username,
          'email': email,
          'pic': pic,
        },
      );
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<User>> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString('_id')!;
    try {
      Response response = await _httpServices.get(
        '${Constant.getuser}/$userid',
      );
      List<User> lstUser = [];
      if (response.statusCode == 200) {
        print("response ko data${response.data}");
        ProfileResponse userResponse = ProfileResponse.fromJson(response.data);
        lstUser = userResponse.data!;
        return lstUser;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

void adduserid(String userid) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('_id', userid);
}

void addToken(String token) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('token', "Bearer $token");

  // await pref.setString('login', token);
}
