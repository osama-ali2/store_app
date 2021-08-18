import 'feature.dart';
class Subscription {
  int id;
  String nameEn;
  int price;
  int numberSlider;
  int numberProducts;
  int numberDays;
  int currencyId;
  String currencyName;
  List<Feature> features;

  Subscription({
    this.id,
    this.nameEn,
    this.price,
    this.numberSlider,
    this.numberProducts,
    this.numberDays,
    this.currencyId,
    this.currencyName,
    this.features});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nameEn = json["name_en"];
    price = json["price"];
    numberSlider = json["number_slider"];
    numberProducts = json["number_products"];
    numberDays = json["number_days"];
    currencyId = json["currency_id"];
    currencyName = json["currency_name"];
    if (json["features"] != null) {
      features = [];
      json["features"].forEach((v) {
        features.add(Feature.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name_en"] = nameEn;
    map["price"] = price;
    map["number_slider"] = numberSlider;
    map["number_products"] = numberProducts;
    map["number_days"] = numberDays;
    map["currency_id"] = currencyId;
    map["currency_name"] = currencyName;
    if (features != null) {
      map["features"] = features.map((v) => v.toJson()).toList();
    }
    return map;
  }

}