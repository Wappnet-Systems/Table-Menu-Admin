import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:table_menu_admin/models/category_model.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class CategoryRepository {

  NetworkApiService _apiServices = NetworkApiService();

  Future<CategoryModel> saveCategory(dynamic data) async{

    final response = await _apiServices.getPostApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.categoryEndPoint.categoryEndPoint,
      data
    );
    return CategoryModel.fromMap(response.data);
  }

  Future<Response> getCategories() async{
    final response = await _apiServices.getGetApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.categoryEndPoint.categoryEndPoint
    );
    return response;
  }
  // for (var categoryJson in response.data) {
  //   CategoryModel.fromJson(categoryJson);
  //   //categories = CategoryModel().data!.cast<CategoryModel>();
  //   // Update the category image URL with the base URL
  //   // String categoryImageUrl =
  //   //     ApiEndPoint.baseImageUrl + categoryJson['category_img'];
  //   // // Create a new CategoryModel object
  //   // CategoryModel category = CategoryModel(
  //   //   categoryId: categoryJson['category_id'],
  //   //   categoryName: categoryJson['category_name'],
  //   //   categoryDescription: categoryJson['description'],
  //   //   categoryImageUrl: categoryImageUrl,
  //   // );
  // }


  Future<CategoryModel> updateCategory(dynamic data, int id) async{
    final response = await _apiServices.getPatchApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.categoryEndPoint.categoryEndPoint + '$id/',
      data
    );
    return CategoryModel.fromMap(response.data);
  }

  Future<void> deleteCategory(int id) async{
    await _apiServices.getDeleteApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.categoryEndPoint.categoryEndPoint + "$id/"
    );
  }

}