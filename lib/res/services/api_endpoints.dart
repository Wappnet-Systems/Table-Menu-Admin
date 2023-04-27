class ApiEndPoint {
  static const String baseImageUrl = "http://192.168.10.179:8001/api/media/";
  static const String baseUrl = "http://192.168.10.179:8001/api/";
  static _AuthEndPoint authEndPoint = _AuthEndPoint();
  static _CategoryEndPoint categoryEndPoint = _CategoryEndPoint();
}

class _AuthEndPoint {
  final String admin_login = "adminside/admin_login/";
}

class _CategoryEndPoint {
  final String categoryEndPoint = "adminside/category/";
}