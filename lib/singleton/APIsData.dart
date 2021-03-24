import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yagot_app/models/home/category_model.dart';
import 'package:yagot_app/models/home/home_section_model.dart';
import 'package:yagot_app/models/LoginRegister/login_details_model.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/singleton/AppSP.dart';
import 'package:yagot_app/singleton/dio.dart';
import 'package:yagot_app/models/settings/settings_model.dart';

class APIsData {
  String url = "https://yagot.tejaratek.com/";

  Dio client;

  APIsData({@required this.client});
  
  _setAuthorizationHeader(String token){
    client.options.headers.addAll({'Authorization' : token}) ;
  }
  _removeAuthorizationHeader(){
    client.options.headers.remove('Authorization') ;
  }
  // ignore: missing_return
  // Future<List<SliderModel>> getBanners() async {
  //   final response = await client.get('$url/api/home');
  //
  //   if (response != null && response.data != null) {
  //     List<SliderModel> sliders;
  //     Map<String, dynamic> jsonData = jsonDecode(response.toString());
  //     List dataList = jsonData['data'];
  //     sliders = HomeSectionModel.fromJson(dataList[0]).slider;
  //     return sliders;
  //   }
  // }
  // ignore: missing_return
  Future<List<HomeSectionModel>> getHomeSections() async {
    final response = await client.get('$url/api/home');

    if (response != null && response.data != null) {
      List<HomeSectionModel> homeSections = <HomeSectionModel>[];
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      List dataList = jsonData['data'];
      dataList.forEach((element) {
        homeSections.add(HomeSectionModel.fromJson(element));
      });
      return homeSections;
    }
  }

  // ignore: missing_return
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await client.get('$url/api/category');
    if (response != null && response.data != null) {
      List<CategoryModel> categories = <CategoryModel>[];
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      var categoriesData = jsonData['data'];
      List categoriesList = categoriesData['data'];
      print(categoriesList);
      if (categoriesList != null) {
        categoriesList.forEach((cJson) {
          categories.add(CategoryModel.fromJson(cJson));
        });
        return categories;
      }
    }
  }

  // ignore: missing_return
  Future<List<ProductDetails>> fetchCategoryById(int id) async {
    final response = await client.get('$url/api/products?category_id=$id');
    if (response != null && response.data != null) {
      List<ProductDetails> products = <ProductDetails>[];
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      var productsInfo = jsonData['data']['products'];
      var jsonList = productsInfo['data'];
      if (jsonList != null) {
        jsonList.forEach((pJson) {
          products.add(ProductDetails.fromJson(pJson));
        });
        return products;
      }
    }
  }

  // ignore: missing_return
  Future<ProductModel> fetchProductById(int id) async {
    final response = await client.get('$url/api/products/getProduct?id=$id');
    if (response != null && response.data != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (jsonData['data'] != null) {
        return ProductModel.fromJson(jsonData['data']);
      }
    }
  }

  createNewAccount(Map data) async {
    final response = await client.post('$url/api/auth/signup', data: FormData.fromMap({}));
    if (response != null && response.data != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (jsonData['data'] != null) {
        return ProductModel.fromJson(jsonData['data']);
      }
    }
  }
  // ignore: missing_return
  Future<LoginDataModel> login(Map<String,String> data) async {
    final response = await client.post('$url/api/auth/login', data: FormData.fromMap(data));
    if (response != null && response.data != null && response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (jsonData['data'] != null) {
        print(response);
        getIt<AppSharedPreferences>().setToken(jsonData['data']['token']);
        getIt<AppSharedPreferences>().preferences.reload();
        _setAuthorizationHeader(jsonData['data']['token']);
        return LoginDataModel.fromJson(jsonData['data']);
      }
    }
  }
  // ignore: missing_return
  Future<LoginDataModel> signUp(Map<String,String> data) async {
    final response = await client.post('$url/api/auth/signup', data: FormData.fromMap(data));
    if (response != null && response.data != null && response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (jsonData['status'] && jsonData['data'] != null) {
        print(response);
        getIt<AppSharedPreferences>().setToken(jsonData['data']['token']);
        getIt<AppSharedPreferences>().preferences.reload();
        _setAuthorizationHeader(jsonData['data']['token']);
        return LoginDataModel.fromJson(jsonData['data']);
      }
    }
  }
  logout()async{
    print(client.options.headers);
    final response = await client.post('$url/api/auth/logout');
    if (response != null && response.data != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (jsonData['message'] != null) {
        getIt<AppSharedPreferences>().setToken('');
        getIt<AppSharedPreferences>().preferences.reload();
        _removeAuthorizationHeader();
        return jsonData['message'] ;
      }
    }
  }

  getSettings() async {
    final response = await client.get('$url/api/getSetting');
    if (response != null && response.data != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (jsonData['status']) {
        return SettingsModel.fromJson(jsonData['data']);
      }
    }
  }
}
