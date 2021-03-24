import 'package:yagot_app/models/address.dart';

class User {
  String name, image, email, phone;
  List<AddressModel> addresses;
  User({this.name, this.image, this.email, this.phone, this.addresses});
}
