import 'package:ebuy/model/order.dart';
import 'package:objectbox/objectbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
//model entity for User
@JsonSerializable()
@Entity()
class User {
  @Id(assignable: true) //auto increment
  int uId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? userId;  
  String? email;
  String? name;
  String? password;
    String? image;

      final user = ToOne<Orders>;

  User({this.userId,this.email, this.name, this.password,
      this.uId = 0}); //user constructer


  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}