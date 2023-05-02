import 'package:dio/dio.dart';
import 'package:table_menu_admin/models/menuItem_model.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class MenuItemRepository {

  NetworkApiService _apiServices = NetworkApiService();

  Future<MenuItemModel> saveMenuItem(dynamic data) async{

    final response = await _apiServices.getPostApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.menuItemEndPoint.menuItemEndPoint,
        data
    );
    return MenuItemModel.fromJson(response.data['data']);
  }

  Future<Response> getMenuItems() async{
    final response = await _apiServices.getGetApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.menuItemEndPoint.menuItemEndPoint
    );
    return response;
  }


  Future<MenuItemModel> updateMenuItem(dynamic data, int id) async{
    final response = await _apiServices.getPatchApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.menuItemEndPoint.menuItemEndPoint + '$id/',
        data
    );
    return MenuItemModel.fromJson(response.data);
  }

  Future<void> deleteMenuItem(int id) async{
    await _apiServices.getDeleteApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.menuItemEndPoint.menuItemEndPoint + "$id/"
    );
  }

}