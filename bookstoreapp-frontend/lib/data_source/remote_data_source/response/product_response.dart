import 'package:ebuy/model/product.dart';
import 'package:ebuy/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  bool? success;
  String? message;
  List<Product>? data;

  ProductResponse({this.success, this.message, this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
