import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess_app/Utilities/auth.dart';
import 'package:mess_app/Utilities/constants.dart';
import 'package:mess_app/screens/signup.dart';
import 'package:mess_app/widgets/Login_SignUp_toogle_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_input_field.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSpinning = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isSpinning,
      child: Scaffold(
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
                    'LOG IN',
                    style: GoogleFonts.openSansCondensed(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Constants().primaryColor,
                    ),
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
                    buttonText: 'LOG IN',
                    onPressed: () async {
                      setState(() {
                        isSpinning = true;
                      });
                      try {
                        String loginCondition = await Auth().loginUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (loginCondition == 'success') {
                          Get.off(() => const HomeScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loginCondition),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                      _emailController.clear();
                      _passwordController.clear();
                      setState(() {
                        isSpinning = false;
                      });
                    },
                  ),
                  LoginSignupToogle(
                    text: 'Not a user yet?',
                    buttonText: 'REGISTER',
                    onTap: () {
                      Get.off(
                        () => const SignUpScreen(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
