// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      orderid: json['_id'] as String?,
      oid: json['oid'] as int? ?? 0,
      userr: json['userid'] == null
          ? null
          : User.fromJson(json['userid'] as Map<String, dynamic>),
      Products: json['Productid'] == null
          ? null
          : Product.fromJson(json['Productid'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'oid': instance.oid,
      'userid': instance.userr,
      'Productid': instance.Products,
      '_id': instance.orderid,
    };
