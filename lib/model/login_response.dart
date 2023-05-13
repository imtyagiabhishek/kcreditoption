class LoginResponse {
  String? token;
 // Result? result;

  LoginResponse({this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
 /*   result =
    json['result'] != null ? Result.fromJson(json['result']) : null;*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
   /* if (result != null) {
      data['result'] = result?.toJson();
    }*/
    return data;
  }
}

class Result {
  String? name;
  String? phoneNumber;
  String? id;
  String? createdAt;
  String? updatedAt;

  Result(
      {this.name, this.phoneNumber, this.id, this.createdAt, this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

