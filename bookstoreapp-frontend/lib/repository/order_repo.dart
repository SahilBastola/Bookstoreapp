import 'package:ebuy/data_source/remote_data_source/order_data_source.dart';
import 'package:ebuy/model/order.dart';

abstract class OrderRepository {
  Future<int> addOrderhostel(String productid);
  Future<List<Orders>> getAllOrder();
  Future<List<Orders>> getOrderByUserid();
  Future<int>  deleteorder();
}

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<List<Orders>> getAllOrder() async {
    bool status = true;
    List<Orders> lsthostel = [];
    if (status) {
      lsthostel = await OrderRemoteDataSource().getAllPRouct();
      return lsthostel;
    }
  }

  @override
  Future<List<Orders>> getOrderByUserid() async {
    bool status = true;
    List<Orders> lsthostel = [];
    if (status) {
      lsthostel = await OrderRemoteDataSource().getUserByUserId();
      return lsthostel;
    }
  }

  @override
  Future<int> addOrderhostel(String productid) {
    return OrderRemoteDataSource().addOrderhostel(productid);
  }

  @override
  Future<int> deleteorder()async  {
      bool status = true;
    int lsthostel = 2;
    if (status) {
      lsthostel = await OrderRemoteDataSource().deleteorder();
      return lsthostel;
    }
  }
}
