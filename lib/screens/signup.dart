import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _homeAddressController = TextEditingController();

  bool isSpinning = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _homeAddressController.dispose();
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
                    label: 'Home Address',
                    textEditingController: _homeAddressController,
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
                      setState(() {
                        isSpinning = true;
                      });
                      try {
                        String signUpCondition = await Auth().registerUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                        User? user = FirebaseAuth.instance.currentUser;
                        FirebaseFirestore _storage = FirebaseFirestore.instance;
                        await Custom_storage(
                          name: _nameController.text,
                          email: _emailController.text,
                          address: _homeAddressController.text,
                        ).registerNewUser(user!.uid);
                        await Custom_storage(
                          name: _nameController.text,
                          email: _emailController.text,
                          address: _homeAddressController.text,
                        ).mealCounter(
                          uid: user.uid,
                          currentUserName: _nameController.text,
                          dayMeal: '0',
                          guestDayMeal: '0',
                          guestNightMeal: '0',
                          nightMeal: '0',
                        );

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
                      _homeAddressController.clear();
                      setState(() {
                        isSpinning = false;
                      });
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
      ),
    );
  }
}
