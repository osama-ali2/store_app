class InformationModel {
  int id;
  String title;
  String details;

  InformationModel({
    this.id,
    this.title,
    this.details});

  InformationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    details = json["details"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["details"] = details;
    return map;
  }

}