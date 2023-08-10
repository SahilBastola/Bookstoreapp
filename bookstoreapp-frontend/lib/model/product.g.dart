// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      img: json['img'] as String?,
      categories: json['categories'] as List<dynamic>?,
      Author: json['Author'] as String?,
      price: json['price'] as int?,
      productid: json['_id'] as String?,
      pId: json['pId'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'pId': instance.pId,
      '_id': instance.productid,
      'title': instance.title,
      'desc': instance.desc,
      'img': instance.img,
      'categories': instance.categories,
      'Author': instance.Author,
      'price': instance.price,
    };
