import 'package:yagot_app/models/product/product.dart';

class Purchase{
  ProductModel product ;
  String orderNo;
  double totalPrice ;
  String dateTime ;
  String status ;
  bool isActive ;

  Purchase({this.product, this.orderNo, this.totalPrice, this.dateTime,
      this.status, this.isActive});
}