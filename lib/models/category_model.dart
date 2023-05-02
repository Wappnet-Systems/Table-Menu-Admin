import 'dart:convert';
import 'package:dio/dio.dart';

class CategoryModel {

  int? categoryId;
  String? categoryName;
  String? categoryDescription;
  MultipartFile? categoryImage;
  String? categoryImageUrl;
  bool? status;
  String? message;
  List<Data>? data;
  //final String? getCategoryImage;

  CategoryModel({ this.categoryId,  this.categoryName, this.categoryDescription,  this.categoryImage, this.categoryImageUrl, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  FormData toFormData() {
    FormData formData = FormData();
    formData.fields
        .add(MapEntry<String, String>('category_name', this.categoryName!));
    formData.fields
        .add(MapEntry<String, String>('description', this.categoryDescription!));
    formData.files.add(MapEntry<String, MultipartFile>(
        'category_img', this.categoryImage!));
    //formData.('category_img'); // remove MultipartFile instance
    return formData;
  }

  //String toJson() => jsonEncode(toMap());



  CategoryModel.fromMap(Map<String,dynamic> json)
      : categoryId = json['category_id'],
        categoryName = json['category_name'],
        categoryDescription = json['description'],
        categoryImageUrl = json['category_img'],
        categoryImage = json['category_img'] != null ? MultipartFile.fromBytes(utf8.encode(json['category_img'])) : null;


}

class Data {
  int? categoryId;
  String? categoryName;
  String? description;
  String? categoryImg;

  Data(
      {this.categoryId, this.categoryName, this.description, this.categoryImg});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    categoryImg = json['category_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['category_img'] = this.categoryImg;
    return data;
  }
}


