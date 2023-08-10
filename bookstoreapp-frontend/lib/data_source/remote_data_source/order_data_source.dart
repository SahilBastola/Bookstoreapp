import 'package:dio/dio.dart';
import 'package:ebuy/app/constants.dart';
import 'package:ebuy/data_source/remote_data_source/response/order_response.dart';
import 'package:ebuy/helper/http_service.dart';
import 'package:ebuy/model/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRemoteDataSource {
  final Dio _httpservices = HttpServices().getDioInstance();

  Future<int> addOrderhostel(String ProductId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpservices.post(
        Constant.createorder,
        queryParameters: {
          'Productid': ProductId,
        },
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<List<Orders>> getAllPRouct() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpservices.get(
        Constant.getorder,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": token,
          },
        ),
      );
      List<Orders> lstorders = [];
      if (response.statusCode == 200) {
        OrderResponse orderResponse = OrderResponse.fromJson(response.data);
        lstorders = orderResponse.data!;
        return lstorders;
      } else {
        return [];
      }
    } catch (e) {
      // return [];
      throw Exception(e.toString());
    }
  }

  Future<List<Orders>> getUserByUserId() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;

      Response response = await _httpservices.get(
        Constant.getorder,
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      List<Orders> lstorders = [];
      if (response.statusCode == 200) {
        OrderResponse orderResponse = OrderResponse.fromJson(response.data);
        lstorders = orderResponse.data!;
        return lstorders;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

      Future<int> deleteorder() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String Productid = pref.getString('_id')!;
    try {
      Response response = await _httpservices.delete(
        '${Constant.order}/$Productid',
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
}
