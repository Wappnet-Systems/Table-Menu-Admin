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

  Future<List<CategoryModel>> getCategories() async{
    final response = await _apiServices.getGetApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.categoryEndPoint.categoryEndPoint
    );
    return (response.data as List).map((category) => CategoryModel.fromMap(category)).toList();
  }

  Future<CategoryModel> updateCategory(CategoryModel categoryModel) async{
    final response = await _apiServices.getPatchApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.categoryEndPoint.categoryEndPoint + '${categoryModel.categoryId}/',
      categoryModel.toFormData()
    );

    return CategoryModel.fromMap(response.data);
  }

  Future<void> deleteCategory(int id) async{
    await _apiServices.getDeleteApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.categoryEndPoint.categoryEndPoint + "$id/"
    );
  }

}