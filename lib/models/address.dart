import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressModel {
  String city, bloc, street, homeNumber;
  LatLng coordinates;
  int id;

  AddressModel(
      {this.id,
      this.city,
      this.bloc,
      this.street,
      this.homeNumber,
      this.coordinates});
}
