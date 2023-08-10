import 'package:ebuy/data_source/remote_data_source/order_data_source.dart';
import 'package:ebuy/data_source/remote_data_source/product_data_source.dart';
import 'package:ebuy/model/order.dart';
import 'package:ebuy/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "token":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2ZkOTcwNDM5YTI1OGE3NzhlNGVlMTkiLCJlbWFpbCI6ImFkbWluMUBnbWFpbC5jb20iLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE2Nzc1NjM3MDEsImV4cCI6MTY3NzY1MDEwMX0.IyMArAVOxswXBmLnAHy1f5lNfn9h_zNwW3LJhaqcf58"
    });
  });

  WidgetsFlutterBinding.ensureInitialized();

  test('Get All Products', () async {
    List<Product> actualResult = await ProductRemoteDataSource().getAllProduct();
    expect(actualResult, isNotEmpty);
  });

  test('Get All Orders', () async {
    List<Orders> actualResult =
        await OrderRemoteDataSource().getAllPRouct();
    expect(actualResult, isNotEmpty);
  });

  test('User should be able to add to Order', () async {
    int expectedResult = 1;
    String productId = "63fd9030f203f86871481de4";
    int actualResult = await OrderRemoteDataSource().addOrderhostel(productId);
    expect(actualResult, expectedResult);
  });

  test('Get All Cart Products', () async {
    List<Product> actualResult = await ProductRemoteDataSource().getAllProduct();
    expect(actualResult, isNotEmpty);
  });
}

// flutter test --coverage ./test/unit_test/product_test.dart 
// flutter pub run test_cov_console