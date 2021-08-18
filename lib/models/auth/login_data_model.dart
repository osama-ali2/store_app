import 'package:yagot_app/models/home/client.dart';

class LoginDataModel {
  String token;

  Client client;

  LoginDataModel({this.token, this.client});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    this.token = json['token'];
    if(json['client'] != null)
      this.client = Client.fromJson(json['client']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['token'] = token;
    if(client != null)
      map['client'] = client.toJson();
    return map;
  }
}
