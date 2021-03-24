class Feature {
  int subscriptionId;
  int featureId;
  int id;
  String value;
  String name;

  Feature({
    this.subscriptionId,
    this.featureId,
    this.id,
    this.value,
    this.name});

  Feature.fromJson(Map<String, dynamic> json) {
    subscriptionId = json["subscription_id"];
    featureId = json["feature_id"];
    id = json["id"];
    value = json["value"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subscription_id"] = subscriptionId;
    map["feature_id"] = featureId;
    map["id"] = id;
    map["value"] = value;
    map["name"] = name;
    return map;
  }

}