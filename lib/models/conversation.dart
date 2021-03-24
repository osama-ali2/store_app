import 'package:yagot_app/models/message.dart';
import 'package:yagot_app/models/product/product.dart';

class ConversationModel{
  String title ;
  ProductModel product ;
  List<Message> messages ;
  bool isOpened ;
  ConversationModel({this.title, this.product, this.messages,this.isOpened});
}