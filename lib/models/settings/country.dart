class Country {
  int id;
  String name;
  String countryCode;
  String flag;

  Country({
    this.id,
    this.name,
    this.countryCode,
    this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    countryCode = json["country_code"];
    flag = json["flag"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["country_code"] = countryCode;
    map["flag"] = flag;
    return map;
  }

}