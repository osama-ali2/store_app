import 'package:flutter/material.dart';
import 'package:yagot_app/constants/constants.dart';
import 'package:yagot_app/models/home/category_model.dart';
import 'package:yagot_app/models/home/home_part_model.dart';
import 'package:yagot_app/models/home/slider_model.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/LoginRegister/login_details_model.dart';
import 'package:yagot_app/singleton/APIsData.dart';
import 'package:yagot_app/singleton/dio.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/singleton/AppSP.dart';
import 'package:yagot_app/models/settings/settings_model.dart';

class GeneralProvider extends ChangeNotifier {
  List<SliderModel> _banners = [];

  HomePartModel _homeCategories;

  List<ProductDetails> _categoryProducts;

  List<HomePartModel> _homeSections;

  List<HomePartModel> _homeProducts = [];

  List<CategoryModel> _categories = [];
  ProductModel _product;

  List<String> _productImages = [];

  LoginDataModel _loginData;

  bool _isLogin = (getIt<AppSharedPreferences>().getToken() != null &&
      getIt<AppSharedPreferences>().getToken().isNotEmpty);
  SettingsModel _settingsModel;
 List<String> _countries = [];
  List<String> _zones = [];

  List<SliderModel> get banners => _banners;

  HomePartModel get homeCategories => _homeCategories;

  List<ProductDetails> get categoryProducts => _categoryProducts;

  List<HomePartModel> get homeSections => _homeSections;

  List<HomePartModel> get homeProducts => _homeProducts;

  List<CategoryModel> get categories => _categories;

  ProductModel get product => _product;

  List<String> get productImages => _productImages;

  LoginDataModel get loginData => _loginData;

  bool get isLogin => _isLogin;

  SettingsModel get settingsModel => _settingsModel;
  List<String>get countries => _countries;
  List<String> get zones => _zones;
  getHomeSections(BuildContext context) {
    getIt<APIsData>().getHomeSections().then((value) {
      _homeSections = value;
      _separateHomeSections();
      notifyListeners();
      return value;
    }).catchError((error) {
      print("The Home sections error is" + error.toString());
      showError(context, error);
    });
  }

  _separateHomeSections() {
    _homeSections.forEach((element) {
      if (element.type == SLIDER) {
        _banners.addAll(element.slider);
      } else if (element.type == CATEGORY) {
        _homeCategories = element;
      } else {
        _homeProducts.add(element);
      }
    });
  }

  getCategories() {
    getIt<APIsData>().fetchCategories().then((value) {
      _categories = value;
      notifyListeners();
      return value;
    }).catchError((error) {
      print("The categoeries error is " + error.toString());
    });
  }

  getCategoryById(int id) {
    getIt<APIsData>().fetchCategoryById(id).then((value) {
      _categoryProducts = value;
      print(value);
      notifyListeners();
      return value;
    }).catchError((error) {
      print("The CategoryById error is " + error.toString());
    });
  }

  getProductById(int id) {
    getIt<APIsData>().fetchProductById(id).then((value) {
      _product = value;
      _getProductImage();
      notifyListeners();
      return value;
    }).catchError((error) {
      print("The ProductById error is " + error.toString());
    });
  }

  _getProductImage() {
    _productImages.add(product.details.image);
    product.details.images.forEach((element) {
      _productImages.add(element.attachment);
    });
  }

  login(Map<String, String> data) {
    getIt<APIsData>().login(data).then((value) {
      _isLogin = true;
      _loginData = value;
      notifyListeners();
      return value;
    }).catchError((error) {
      print('The login error is' + error.toString());
    });
  }
  singUp(Map<String, String> data) {
    getIt<APIsData>().signUp(data).then((value) {
      _isLogin = true;
      _loginData = value;
      notifyListeners();
      return value;
    }).catchError((error) {
      print('The signUp error is' + error.toString());
    });
  }
  logout() {
    getIt<APIsData>().logout().then((value) {
      _isLogin = false;
      notifyListeners();
    }).catchError((error) {
      print('The logout error is' + error.toString());
    });
  }

  getSettings(Function onDone){
    getIt<APIsData>().getSettings().then((value){
      _settingsModel = value ;
      _getCountries();
      _getZones();
      notifyListeners();
      onDone() ;
    }).catchError((error){
      print('The settings error is' + error.toString());

    });
  }

  _getCountries(){
    _settingsModel.countries.forEach((element) {
      _countries.add(element.name);
    }) ;
  }
  _getZones(){
    _settingsModel.zones.forEach((element) {
      _zones.add(element.name);
    }) ;
  }
  clearCategoryProducts() {
    _categoryProducts = null;
  }

  clear() {
    if (_banners != null) _banners.clear();
    _homeCategories = null;
    _categoryProducts = null;
    _homeSections = null;
    _product = null;
    if (_homeProducts != null) _homeProducts.clear();
    if (_categories != null) _categories.clear();
    notifyListeners();
  }

  clearProduct()  {
    _product = null;
    if (_productImages != null) {
      _productImages.clear();
    }
  }


}
