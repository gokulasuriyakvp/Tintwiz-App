class register_model {
  String? status;
  ResData? resData;

  register_model({this.status, this.resData});

  register_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    resData = json['res_data'] != null
        ? new ResData.fromJson(json['res_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.resData != null) {
      data['res_data'] = this.resData!.toJson();
    }
    return data;
  }
}

class ResData {
  Response? response;

  ResData({this.response});

  ResData.fromJson(Map<String, dynamic> json) {
    response = json['Response:'] != null
        ? new Response.fromJson(json['Response:'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response:'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? msg;
  String? username;
  String? email;
  String? password;

  Response({this.msg, this.username, this.email, this.password});

  Response.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    username = json['Username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['Username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
