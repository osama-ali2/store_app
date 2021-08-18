class BaseResponseModel <T>{
  bool status ;
  String message ;
  T data ;

  BaseResponseModel(){
    status = false ;
    message = 'ssss' ;
  }
  BaseResponseModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}