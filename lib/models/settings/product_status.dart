class ProductStatus {
  int id;
  String name;

  ProductStatus({
    this.id,
    this.name});

  ProductStatus.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }

}