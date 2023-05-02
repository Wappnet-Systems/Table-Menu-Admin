import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_admin/repository/auth_repository.dart';
import 'package:table_menu_admin/view/home_screen.dart';
import 'package:table_menu_admin/view/login_screen.dart';
import 'package:table_menu_admin/view_model/auth_provider.dart';
import 'package:table_menu_admin/view_model/menu_category_provider.dart';
import 'package:table_menu_admin/view_model/menu_provider.dart';
import 'package:table_menu_admin/view_model/nav_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2))
      .then((value) => FlutterNativeSplash.remove());
  final AuthRepository _authRepository = AuthRepository();

  bool loggedIn = await _authRepository.isLoggedIn();
  runApp(MyApp(loggedIn: loggedIn,));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, required this.loggedIn});

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Table Menu Admin',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.purple,
            fontFamily: 'Roboto'
        ),
        home: loggedIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}




