import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess_app/Utilities/auth.dart';
import 'package:mess_app/Utilities/constants.dart';
import 'package:mess_app/Utilities/storage_methods.dart';
import 'package:mess_app/screens/home.dart';
import 'package:mess_app/screens/login.dart';
import '../widgets/Login_SignUp_toogle_text.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants().appName),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.blue.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'REGISTER',
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Constants().primaryColor,
                  ),
                ),
                CustomTextInputField(
                  label: 'Name',
                  textEditingController: _nameController,
                ),
                CustomTextInputField(
                  label: 'Email',
                  textEditingController: _emailController,
                ),
                CustomTextInputField(
                  label: 'Password',
                  textEditingController: _passwordController,
                  isObscure: true,
                ),
                CustomTextButton(
                  buttonText: 'CREATE ACCOUNT',
                  onPressed: () async {
                    try {
                      String signUpCondition = await Auth().registerUser(
                        _emailController.text,
                        _passwordController.text,
                      );
                      await Custom_storage(
                        name: _nameController.text,
                        email: _emailController.text,
                      ).registerNewUser();

                      if (signUpCondition == 'success') {
                        Get.off(() => const HomeScreen());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(signUpCondition),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }

                    _emailController.clear();
                    _passwordController.clear();
                    _nameController.clear();
                  },
                ),
                LoginSignupToogle(
                  text: 'Already have an account?',
                  buttonText: 'LOG IN',
                  onTap: () {
                    Get.off(
                      () => const LoginScreen(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}