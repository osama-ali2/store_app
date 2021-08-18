import 'package:yagot_app/models/home/client.dart';
import 'package:yagot_app/models/product/product.dart';
import 'subscription_info.dart';

class ProfileDataModel {
  List<ProductModel> product;

  Client client;
  SubscriptionInfo subscription;

  String alert;

  int numDays;

  ProfileDataModel(
      {this.product, this.client, this.subscription, this.alert, this.numDays});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <ProductModel>[];
      json['product'].forEach((s) {
        product.add(ProductModel.fromJson(s));
      });
    }
    client = Client.fromJson(json['client']);
    subscription = SubscriptionInfo.fromJson(json['subscription']);
    alert = json['alert'] ?? '';
    numDays = json['num_days'];
  }

  // Map<String,dynamic> toJson(){
  //   return {
  //      'product': ,
  //     'client': client.toJson() ,
  //     'subscription' : subscription.toJson(),
  //     'alert':alert,
  //     'num_days':numDays ,
  //   };
  // }
}
