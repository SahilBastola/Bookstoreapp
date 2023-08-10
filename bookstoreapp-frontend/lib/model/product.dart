import 'dart:ffi';

import 'package:ebuy/model/order.dart';
import 'package:objectbox/objectbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';
//model entity for User
@JsonSerializable()
@Entity()
class Product {
  @Id(assignable: true) //auto increment
  int pId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? productid;  
  String? title;  
  String? desc;
  String? img;
  List? categories;
  String? Author;
  int? price;

    final order = ToMany<Orders>;

  Product({this.title,this.desc, this.img, this.categories,this.Author,this.price,this.productid,
      this.pId = 0}); //user constructer


  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

//flutter pub run build_runner build --delete-conflicting-outputs