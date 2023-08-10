import 'package:ebuy/model/product.dart';
import 'package:ebuy/model/user.dart';
import 'package:objectbox/objectbox.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

//model entity for Hostel
@JsonSerializable()
@Entity()
class Orders {
  @Id(assignable: true) //auto increment
  int oid;
  final user = ToOne<User>;

  @Backlink()
  final hostel = ToMany<Product>;

  @JsonKey(name: 'userid')
  User? userr;

  @JsonKey(name: 'Productid')
  Product? Products;

    @Unique()
  @Index()
  @JsonKey(name: "_id")
  String? orderid;

  Orders({
    this.orderid ,
    this.oid = 0,
    this.userr,
    this.Products,
  }); //user constructer

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

//flutter pub run build_runner build  --delete-conflicting-outputs