class ApiEndPoint {
  static const String baseImageUrl = "http://192.168.10.179:8001/";
  static const String baseUrl = "http://192.168.10.179:8001/api/";
  static _AuthEndPoint authEndPoint = _AuthEndPoint();
  static _CategoryEndPoint categoryEndPoint = _CategoryEndPoint();
  static _MenuItemEndPoint menuItemEndPoint = _MenuItemEndPoint();
}

class _AuthEndPoint {
  final String admin_login = "adminside/admin_login/";
}

class _CategoryEndPoint {
  final String categoryEndPoint = "adminside/category/";
}

class _MenuItemEndPoint {
  final String menuItemEndPoint = "adminside/menu_item/";
}