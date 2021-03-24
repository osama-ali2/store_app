import 'package:yagot_app/models/home/slider_model.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/models/home/category_model.dart';

class HomeSectionModel {
  int type;

  int id;

  String title;

  List<SliderModel> slider;

  List<CategoryModel> category;

  List<ProductDetails> products;

  HomeSectionModel(
      {this.type,
      this.id,
      this.title,
      this.slider,
      this.category,
      this.products});

  HomeSectionModel.fromJson(Map<String, dynamic> json) {
    this.type = json["type"];
    this.id = json["id"];
    this.title = json["title"];
    if (json['category'] != null) {
      category = <CategoryModel>[];
      json['category'].forEach((category) {
        this.category.add(CategoryModel.fromJson(category));
      });
    }
    if (json['products'] != null) {
      products = <ProductDetails>[];
      json['products'].forEach((product) {
        products.add(ProductDetails.fromJson(product));
      });
    }
    if (json['slider'] != null) {
      slider = <SliderModel>[];
      json['slider'].forEach((s) {
        slider.add(SliderModel.fromJson(s));
      });
    }
  }
}
