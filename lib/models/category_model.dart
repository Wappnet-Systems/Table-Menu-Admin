
import 'dart:convert';

import 'package:dio/dio.dart';

class CategoryModel {

   final int? categoryId;
   final String? categoryName;
   final String? categoryDescription;
   final MultipartFile? categoryImage;

  CategoryModel({ this.categoryId,  this.categoryName, this.categoryDescription,  this.categoryImage});

  // Map<String,dynamic> toMap(){
  //   return {
  //     'category_id' : categoryId,
  //     'category_name' : categoryName,
  //     'description' : categoryDescription,
  //     'category_img' : categoryImage
  //   };
  // }

   FormData toFormData() {
     FormData formData = FormData();
     formData.fields
         .add(MapEntry<String, String>('category_id', this.categoryId!.toString()));
     formData.fields
         .add(MapEntry<String, String>('category_name', this.categoryName!));
     formData.fields
         .add(MapEntry<String, String>('description', this.categoryName!));
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
        categoryImage = json['category_img'];
}


