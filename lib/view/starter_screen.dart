import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view_model/auth_provider.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) => prefs.setBool('isFirstTime', false));
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/starter_screen_image.jpg",
                    height: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Let's get started",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Never a better time than now to start. ",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    // child: CustomButton(
                    //   // onPressed: () {
                    //   //   auth_provider.isSignedIn == true
                    //   //       ? Navigator.push(
                    //   //           context,
                    //   //           MaterialPageRoute(
                    //   //             builder: (context) => HomeScreen(),
                    //   //           ),
                    //   //         )
                    //   //       : Navigator.push(
                    //   //           context,
                    //   //           MaterialPageRoute(
                    //   //               builder: (context) => LoginScreen()),
                    //   //         );
                    //   // },
                    //   child: Text("Get started",style: TextStyle(fontSize: 16),),
                    // ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}