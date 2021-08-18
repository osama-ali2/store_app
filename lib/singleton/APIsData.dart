import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yagot_app/models/auth/login_data_model.dart';
import 'package:yagot_app/models/base_response_model.dart';
import 'package:yagot_app/models/home/category_model.dart';
import 'package:yagot_app/models/home/home_part_model.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/models/profile/profile_data.dart';
import 'package:yagot_app/models/settings/settings_model.dart';
import 'package:yagot_app/utilities/custom_exceptions.dart';

class APIsData {
  String url = "https://yagot.tejaratek.com/";
  Dio client;

  APIsData({@required this.client});

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
  Future<List<HomePartModel>> getHomeSections() async {
    final response = await client.get('$url/api/home');

    if (response != null && response.data != null) {
      List<HomePartModel> homeSections = <HomePartModel>[];
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      List dataList = jsonData['data'];
      dataList.forEach((element) {
        homeSections.add(HomePartModel.fromJson(element));
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

  login(Map<String, String> data) async {
    final response =
        await client.post('$url/api/auth/login', data: FormData.fromMap(data));
    if (response != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      print(jsonData);
      if (response.data != null && response.statusCode == 200) {
        return LoginDataModel.fromJson(jsonData['data']);
      } else {
        throw ResponseException(
            BaseResponseModel.fromJson(jsonData), response.statusCode);
      }
    }
  }

  signUp(Map<String, String> data) async {
    final response =
        await client.post('$url/api/auth/signup', data: FormData.fromMap(data));
    if (response != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (response.data != null && response.statusCode == 200) {
        return LoginDataModel.fromJson(jsonData['data']);
      }else {
        throw ResponseException(
            BaseResponseModel.fromJson(jsonData), response.statusCode);
      }
    }
  }

  logout() async {
    print(client.options.headers);
    final response = await client.post('$url/api/auth/logout');
    if (response != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (response.data != null && response.statusCode == 200) {
        return BaseResponseModel.fromJson(jsonData);
      } else {
        throw ResponseException(
            BaseResponseModel.fromJson(jsonData), response.statusCode);
      }
    }
  }

   fetchSettings() async {
    final response = await client.get('$url/api/getSetting');
    if (response != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (response.data != null && response.statusCode == 200) {
        return SettingsModel.fromJson(jsonData['data']);
      }else{
        throw ResponseException(BaseResponseModel.fromJson(jsonData), response.statusCode);
      }
    }
  }

// ignore: missing_return
  fetchProfile() async {
    final response = await client.get('$url/api/profile');
    if (response != null) {
      Map<String, dynamic> jsonData = jsonDecode(response.toString());
      if (response.data != null && response.statusCode == 200) {
        return ProfileDataModel.fromJson(jsonData['data']);
      } else {
        throw ResponseException(
            BaseResponseModel.fromJson(jsonData), response.statusCode);
      }
    }
  }

  postProduct(Map<String, dynamic> data) async {
    final response = await client.post('$url/api/products/addProduct',
        data: FormData.fromMap(data));
    print(response.toString() + "response");
    if (response != null) {
      if (response.data != null && response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.toString());
        if (jsonData['status'] && jsonData['data'] != null) {
          print(response);
          return jsonData['data'];
        }
      }
    }
  }
}
