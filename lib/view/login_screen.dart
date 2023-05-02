import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/auth_provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final GlobalKey<FormState> _formKey_admin_login = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  child: Column(children: [
                    Container(
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset("assets/images/mobile_login.png"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Admin Login",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Enter Your Admin Credentials",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey_admin_login,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CustomTextFormField().getCustomEditTextArea(
                              labelValue: "Email",
                              hintValue: "Enter Email",
                              obscuretext: false,
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              prefixicon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              controller: auth_provider.email_controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email Field is Required";
                                }
                              },
                              onchanged: (newValue) {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),CustomTextFormField().getCustomEditTextArea(
                              labelValue: "Password",
                              hintValue: "Enter Password",
                              obscuretext: true,
                              maxLines: 1,
                              prefixicon: const Icon(
                                Icons.password_outlined,
                                color: Colors.black,
                              ),
                              controller: auth_provider.password_controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password Field is Required";
                                }
                              },
                              onchanged: (newValue) {},
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: CustomButton(
                                onPressed: () async {
                                  if (_formKey_admin_login.currentState!
                                      .validate()) {
                                    Map data = {
                                      'email': auth_provider.email_controller.text
                                          .toString(),
                                      'password': auth_provider.password_controller.text
                                          .toString()
                                    };
                                    auth_provider.loginAdmin(data, context);
                                  }
                                },
                                child: auth_provider.loading ?
                                    CircularProgressIndicator(color: Colors.white,)
                                    : Text(
                                  "Login",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )
        )
    );
  }
}
