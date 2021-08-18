class BaseModel<T>{
  String message ;
  bool status ;
  var data ;
  BaseModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}