

import 'package:ebuy/data_source/remote_data_source/product_data_source.dart';
import 'package:ebuy/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProduct();
}

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<Product>> getAllProduct() async {
    bool status = true;
    List<Product> lstproduct = [];
    if (status) {
      lstproduct = await ProductRemoteDataSource().getAllProduct();
      return lstproduct;
    }
  }
}