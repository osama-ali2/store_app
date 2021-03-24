import 'package:yagot_app/models/product/image.dart';
class ProductDetails{
  int id  , categoryId , currencyId , cityId ;
  String title , image , price , dateTime , currencyName , categoryName , cityName , details , countryCode , clientName , notes , updatedAt  ;
  List<Image> images , certifiedImages ;
  bool isFavorites ;

  ProductDetails({
    this.id,
    this.categoryId,
    this.currencyId,
    this.cityId,
    this.title,
    this.image,
    this.price,
    this.dateTime,
    this.currencyName,
    this.categoryName,
    this.cityName,
    this.details,
    this.countryCode,
    this.clientName,
    this.notes,
    this.updatedAt,
    this.images,
    this.certifiedImages,
    this.isFavorites});
  ProductDetails.fromJson(Map<String , dynamic> json){
    id = json["id"] ;
    title = json["title"];
    details = json['details'] ;
    countryCode = json['country_code'];
    image = json["image"] ;
    price = json["price"] ;
    dateTime = json["date"] ;
    currencyName = json["currency_name"] ;
    categoryId = json["category_id"] ;
    currencyId = json["currency_id"] ;

    categoryName = json["category_name"] ;
    cityName = json["city_name"];
    cityId = json['city_id'];
    clientName = json['client_name'];
    notes = json['notes'] ;
    updatedAt  = json['updated_at'];
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((image) {
        this.images.add(Image.fromJson(image));
      });
    }
    if (json['certified_images'] != null) {
      certifiedImages = <Image>[];
      json['certified_images'].forEach((cImage) {
        this.certifiedImages.add(Image.fromJson(cImage));
      });
    }
    isFavorites = (json["is_favorites"] == 1);
  }
}