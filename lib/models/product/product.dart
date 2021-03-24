import 'package:yagot_app/models/product/product_details.dart' ;
import 'package:yagot_app/models/home/client.dart' ;

class ProductModel {
  ProductDetails details ;
  List<ProductDetails> others ;
  Client client ;
  ProductModel({this.details , this.others , this.client}) ;
  ProductModel.fromJson(Map<String , dynamic> json){
    if(json['product_details'] != null) {
      this.details = ProductDetails.fromJson(json['product_details']) ;
    }
    if(json['others'] != null ){
      this.others = <ProductDetails>[];
      json['others'].forEach((product) {
        this.others.add(ProductDetails.fromJson(product)) ;
      }
      );
    }
    if(json['client'] != null){
      this.client = Client.fromJson(json['client']) ;
    }
  }
}
