import 'package:json_annotation/json_annotation.dart';

import '../../../model/user.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  bool? success;
  String? message;
  List<User>? data;

  ProfileResponse({this.success, this.message, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
