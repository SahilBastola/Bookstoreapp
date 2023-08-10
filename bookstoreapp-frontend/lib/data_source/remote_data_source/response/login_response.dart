class LoginResponse {
  bool? success;
  String? message;
  String? token;
   String? id;

  LoginResponse({this.success, this.message, this.token,this.id});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
      id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    data['_id'] = id;
    return data;
  }
}
