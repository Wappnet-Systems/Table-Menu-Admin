import 'dart:convert';

import 'package:dio/dio.dart';

class MenuItemModel {
  bool? status;
  String? message;
  List<MenuData>? menuData;


  MenuItemModel({this.status, this.message, this.menuData});

  MenuItemModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      menuData = <MenuData>[];
      json['data'].forEach((v) {
        menuData!.add(MenuData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.menuData != null) {
      data['data'] = this.menuData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuData {
  int? id;
  String? name;
  String? ingredients;
  String? price;
  String? description;
  MultipartFile? image;
  String? category_name;
  bool? isNew;
  bool? isVeg;
  bool? isNonVeg;
  bool? isSpicy;
  bool? isJain;
  bool? isSpecial;
  bool? isSweet;
  bool? isPopular;
  int? category_id;
  String? image_url;

  MenuData(
  {
        this.id,
        this.name,
        this.ingredients,
        this.price,
        this.description,
        this.image,
        this.category_name,
        this.isNew,
        this.isVeg,
        this.isNonVeg,
        this.isSpicy,
        this.isJain,
        this.isSpecial,
        this.isSweet,
        this.isPopular,
        this.category_id,
  });


  FormData toFormData() {
    FormData formData = FormData();
    formData.fields
        .add(MapEntry<String, String>('name', this.name!));
    formData.fields
        .add(MapEntry<String, String>('ingredients', this.ingredients!));
    formData.fields
        .add(MapEntry('price', this.price.toString()));
    formData.fields
        .add(MapEntry<String, String>('description', this.description!));
    formData.fields
        .add(MapEntry<String, String>('category_name', this.category_name!));
    formData.fields
        .add(MapEntry<String, String>('is_new', this.isNew.toString()));
    formData.fields
        .add(MapEntry<String, String>('is_veg', this.isVeg.toString()));
    formData.fields
        .add(MapEntry<String, String>('is_non_veg', this.isNonVeg.toString()));
    formData.fields
        .add(MapEntry<String, String>('is_spicy', this.isSpicy.toString()));
    formData.fields
        .add(MapEntry<String, String>('is_jain', this.isJain.toString()));
    formData.fields
        .add(MapEntry<String, String>('is_spicy', this.isSpicy.toString()));
    formData.fields
        .add(MapEntry<String, String>('is_special', this.isSpecial.toString()));
    formData.fields
        .add(MapEntry<String, String>('is_popular', this.isPopular.toString()));
    formData.fields
        .add(MapEntry<String, String>('category_id', this.category_id.toString()));
    formData.files.add(MapEntry<String, MultipartFile>(
        'image', this.image != null ? this.image! : this.image!));
    return formData;
  }


  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ingredients = json['ingredients'];
    price = json['price'];
    description = json['description'];
    category_name = json['category_name'];
    image_url = json['image'] ;
    isNew = json['is_new'];
    isVeg = json['is_veg'];
    isNonVeg = json['is_non_veg'];
    isSpicy = json['is_spicy'];
    isJain = json['is_jain'];
    isSpecial = json['is_special'];
    isSweet = json['is_sweet'];
    isPopular = json['is_popular'];
    category_id = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ingredients'] = this.ingredients;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category_name'] = this.category_name;
    data['image'] = this.image;
    data['is_new'] = this.isNew;
    data['is_veg'] = this.isVeg;
    data['is_non_veg'] = this.isNonVeg;
    data['is_spicy'] = this.isSpicy;
    data['is_jain'] = this.isJain;
    data['is_special'] = this.isSpecial;
    data['is_sweet'] = this.isSweet;
    data['is_popular'] = this.isPopular;
    data['category_id'] = this.category_id;
    return data;
  }
}