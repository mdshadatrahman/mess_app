import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_app/Utilities/auth.dart';
import 'package:mess_app/Utilities/constants.dart';
import 'package:mess_app/screens/all_meal.dart';
import 'package:mess_app/screens/login.dart';
import 'package:mess_app/screens/my_meal.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  late PageController pageController;
  bool isSpinning = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isSpinning,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The Unknown'),
          backgroundColor: Constants().primaryColor,
          actions: [
            InkWell(
              onTap: () {
                // print('Logged out');
              },
              child: InkWell(
                onTap: () async {
                  setState(() {
                    isSpinning = true;
                  });
                  await Auth().logout();
                  setState(() {
                    isSpinning = false;
                  });
                  Get.off(
                    () => const LoginScreen(),
                  );
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Log out'),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            const MyMeal(),
            getAllMealCount(),
          ],
        ),
        // bottomNavigationBar: CupertinoTabBar(
        //   onTap: navigationTapped,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.add,
        //         color: _page == 0 ? Colors.blue : Colors.grey,
        //       ),
        //       backgroundColor: Colors.green,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.food_bank_outlined,
        //         color: _page == 1 ? Colors.blue : Colors.grey,
        //       ),
        //       label: '',
        //       backgroundColor: Colors.green,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
