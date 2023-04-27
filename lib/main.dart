import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_admin/view/login_screen.dart';
import 'package:table_menu_admin/view_model/auth_provider.dart';
import 'package:table_menu_admin/view_model/menu_category_provider.dart';
import 'package:table_menu_admin/view_model/menu_provider.dart';
import 'package:table_menu_admin/view_model/nav_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2))
      .then((value) => FlutterNativeSplash.remove());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        home: LoginScreen(),
      ),
    );
  }
}




