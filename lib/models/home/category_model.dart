class CategoryModel {
  int id;

  String name;

  CategoryModel({this.id, this.name});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String , dynamic> toJson(){
    final map = Map<String , dynamic >() ;
    map['id'] = id ;
    map['name'] = name ;
    return map ;
  }
}
