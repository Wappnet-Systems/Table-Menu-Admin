import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_admin/view/home_screen.dart';

import '../repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginAdmin(dynamic data, BuildContext context) async {
    setLoading(true);
     _myRepo.loginAdmin(data).then((value) async {
      setLoading(false);

        print(value.toString());
        print(value.data['status']);

      if (value.data['status'] == true && value.statusCode == 200) {
        String token = value.data['data']['token'];
        print(token);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        await Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),)));
        email_controller.clear();
        password_controller.clear();
      } else if (value.data['status'] == false) {
      }
    }).onError((error, stackTrace) async {
      setLoading(false);
        print(error.toString());
    });
  }
}