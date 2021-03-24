class Image {
  int id , productId ;
  String attachment ;
  Image({this.id, this.productId , this.attachment});
  Image.fromJson(Map<String , dynamic> json){
    id = json['id'] ;
    productId = json['product_id'] ;
    attachment = json['attachment'] ;
  }
}