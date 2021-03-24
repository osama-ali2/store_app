import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/user.dart';

class Seller{
  String name , image , email , phone , description ;
  List<ProductModel> products ;

  Seller({this.name, this.image, this.email, this.phone, this.description,this.products});
}