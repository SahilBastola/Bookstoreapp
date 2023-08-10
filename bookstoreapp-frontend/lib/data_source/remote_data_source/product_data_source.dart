import 'package:dio/dio.dart';
import 'package:ebuy/app/constants.dart';
import 'package:ebuy/data_source/remote_data_source/response/product_response.dart';
import 'package:ebuy/helper/http_service.dart';
import 'package:ebuy/model/product.dart';
class ProductRemoteDataSource {
  final Dio _httpservices = HttpServices().getDioInstance();

  Future<List<Product>> getAllProduct() async {
    try {
      Response response = await _httpservices.get(
        Constant.productURL,
      );
      List<Product> lstProduct = [];
      if (response.statusCode == 200) {
        ProductResponse productResponse = ProductResponse.fromJson(response.data);
        lstProduct = productResponse.data!;
        return lstProduct;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}