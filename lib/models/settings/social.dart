class Social {
  int id;
  String image;
  String url;

  Social({
    this.id,
    this.image,
    this.url});

  Social.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["image"] = image;
    map["url"] = url;
    return map;
  }

}