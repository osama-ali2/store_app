import 'package:flutter/material.dart';
import 'package:yagot_app/constants/constants.dart';
import 'package:yagot_app/models/home/category_model.dart';
import 'package:yagot_app/models/home/home_part_model.dart';
import 'package:yagot_app/models/home/slider_model.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/models/profile/profile_data.dart';
import 'package:yagot_app/models/settings/InformationModel.dart';
import 'package:yagot_app/models/settings/country.dart';
import 'package:yagot_app/models/settings/settings_model.dart';
import 'package:yagot_app/models/settings/zone.dart';
import 'package:yagot_app/singleton/APIsData.dart';
import 'package:yagot_app/singleton/AppSP.dart';
import 'package:yagot_app/singleton/dio.dart';
import 'package:yagot_app/utilities/custom_exceptions.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class GeneralProvider extends ChangeNotifier {
  List<SliderModel> _banners = [];

  HomePartModel _homeCategories;

  List<ProductDetails> _categoryProducts;

  List<HomePartModel> _homeSections;

  List<HomePartModel> _homeProducts = [];

  List<CategoryModel> _categories = [];
  ProductModel _product;

  List<String> _productImages = [];

  bool _isAuth = (getIt<AppShPref>().getToken() != null &&
      getIt<AppShPref>().getToken().isNotEmpty);
  SettingsModel _settingsModel;
  List<Country> _countries = [];
  List<Zones> _zones = [];
  InformationModel _policyPrivacy ;
  Map<String, dynamic> _productAddedData;

  ProfileDataModel _profileData;

  List<SliderModel> get banners => _banners;

  HomePartModel get homeCategories => _homeCategories;

  List<ProductDetails> get categoryProducts => _categoryProducts;

  List<HomePartModel> get homeSections => _homeSections;

  List<HomePartModel> get homeProducts => _homeProducts;

  List<CategoryModel> get categories => _categories;

  ProductModel get product => _product;

  List<String> get productImages => _productImages;

  bool get isAuth => _isAuth;

  SettingsModel get settingsModel => _settingsModel;

  List<Country> get countries => _countries;

  List<Zones> get zones => _zones;
  InformationModel get policyPrivacy => _policyPrivacy;
  ProfileDataModel get profileData => _profileData;

  getHomeSections(BuildContext context, {bool refresh = false}) {
    if (_homeSections == null || refresh) {
      getIt<APIsData>().getHomeSections().then((value) {
        _homeSections = value;
        _separateHomeSections();
        notifyListeners();
        return value;
      }).catchError((error) {
        print("The Home sections error is" + error.toString());
        parseError(context, error);
      });
    }
  }

  _separateHomeSections() {
    clearHomeSections();
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

  login(BuildContext context, Map<String, String> data, Function success,
      Function fail) {
    getIt<APIsData>().login(data).then((value) {
      _isAuth = true;
      _homeSections = null;
      // if (page == Pages.addProducts) {
      //   addProduct(data: _productAddedData);
      // } else {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => MainPages()),
      //       (route) => false);
      // }
      getIt<AppShPref>().setToken(value.token);
      getIt<AppShPref>().setUsername(value.client.name);
      success();
      updateToken();
    }).catchError((error) {
      _isAuth = false;
      fail();
      parseError(context, error);
    });
    notifyListeners();
  }

  singUp(BuildContext context, Map<String, String> data, Function success,
      Function fail) {
    getIt<APIsData>().signUp(data).then((value) {
      _isAuth = true;
      _homeSections = null;
      getIt<AppShPref>().setToken(value.token);
      getIt<AppShPref>().setUsername(value.client.name);
      success();
      updateToken();
    }).catchError((error) {
      fail();
      parseError(context, error);
      print('The signUp error is' + error.toString());
    });
    notifyListeners();
  }

  logout(BuildContext context, Function success, Function fail) {
    getIt<APIsData>().logout().then((value) {
      Future.delayed(Duration(seconds: 1)).then((value) => _isAuth =
          false); // To change logout to login in the option tile after a while.
      _homeSections = null;
      _profileData = null;
      getIt<AppShPref>().setToken('');
      updateToken();
      success();
      notifyListeners();
    }).catchError((error) {
      fail();
      parseError(context, error);
    });
  }

  getProfile(BuildContext context, Function success, Function fail,
      {bool refresh = false}) {
    if (_profileData == null || refresh) {
      getIt<APIsData>().fetchProfile().then((value) {
        _isAuth = true;
        _profileData = value;
        success();
        return value;
      }).catchError((error) {
        fail();
        if (error is ResponseException) {
          if (error.statusCode == 401) {
            _isAuth = false;
            getIt<AppShPref>().setToken('');
            updateToken();
          }
        }
        print('The getProfile error is' + error.toString());
      });
      notifyListeners();
    }
  }

  getSettings(BuildContext context, Function success, Function fail,
      {bool refresh = false}) {
    if (settingsModel == null || refresh) {
      getIt<APIsData>().fetchSettings().then((value) {
        _settingsModel = value;
        _policyPrivacy = settingsModel.policyPrivacy;
        _countries = _settingsModel.countries ;
        _zones = _settingsModel.zones ;
        notifyListeners();
        success();
      }).catchError((error) {
        fail();
        parseError(context, error);
        print('The settings error is' + error.toString());
      });
    }
  }

  addProduct(BuildContext context, Map<String, dynamic> data, Function success,
      Function fail) {
    _productAddedData = data;
    getIt<APIsData>().postProduct(data).then((value) {
      print(value);
      success();
      showSuccess(context, 'product_added_successfully');
    }).catchError((error) {
      print(error);
      if (error is ResponseException) {
        _isAuth = false;
        notifyListeners();
        fail();
      }
    });
  }

  clearCategoryProducts() {
    _categoryProducts = null;
  }

  clearHomeSections() {
    if (_banners != null) _banners.clear();
    _homeCategories = null;
    _product = null;
    if (_homeProducts != null) _homeProducts.clear();
    if (_categories != null) _categories.clear();
    if (_categoryProducts != null) _categoryProducts.clear();
    notifyListeners();
  }

  clearProduct() {
    _product = null;
    if (_productImages != null) {
      _productImages.clear();
    }
  }
}
