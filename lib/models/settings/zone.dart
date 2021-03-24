class Zones {
  int id;
  String name;
  int countryId;

  Zones({
    this.id,
    this.name,
    this.countryId});

  Zones.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    countryId = json["country_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["country_id"] = countryId;
    return map;
  }

}