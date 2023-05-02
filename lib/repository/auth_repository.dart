import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class AuthRepository {

  NetworkApiService _apiServices = NetworkApiService();

  Future<Response> loginAdmin(dynamic data) async {
    try {
      Response response = await _apiServices.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoint.admin_login, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null;
  }

}