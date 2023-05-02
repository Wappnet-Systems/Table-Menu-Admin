import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_admin/view/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:  IconButton(
            onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.remove('token');
              exit(0);
            },
            icon:const Icon(Icons.exit_to_app),
          ),
        ),
      ),
    );
  }
}
