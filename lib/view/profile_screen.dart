import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_provider.dart';
import 'login_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          // child:  IconButton(
          //   // onPressed: (){
          //   //   auth_provider.signOut().then(
          //   //         (value) => Navigator.push(
          //   //       context,
          //   //       MaterialPageRoute(
          //   //         builder: (context) => LoginScreen(),
          //   //       ),
          //   //     ),
          //   //   );
          //   // },
          //   icon:const Icon(Icons.exit_to_app),
          // ),
        ),
      ),
    );
  }
}
