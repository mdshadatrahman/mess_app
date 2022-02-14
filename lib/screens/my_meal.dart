import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/Utilities/constants.dart';

import '../Utilities/storage_methods.dart';

class MyMeal extends StatefulWidget {
  const MyMeal({Key? key}) : super(key: key);

  @override
  _MyMealState createState() => _MyMealState();
}

class _MyMealState extends State<MyMeal> {
  final _dayMealController = TextEditingController();
  final _nightMealController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nightMealController.dispose();
    _dayMealController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Constants().primaryColor,
                width: 3,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    DayNightTile(
                      controller: _dayMealController,
                      dayTime: 'Day',
                    ),
                    DayNightTile(
                      controller: _nightMealController,
                      dayTime: 'Night',
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomButton(
                      buttonText: 'Confirm',
                      onPressed: () async {
                        if (_dayMealController.text != '') {
                          await _firestore
                              .collection('meal')
                              .doc(_auth.currentUser!.uid)
                              .update({
                            'day_meal': _dayMealController.text,
                            'night_meal': _nightMealController.text,
                          });
                          _dayMealController.clear();
                          _nightMealController.clear();
                        } else {
                          await _firestore
                              .collection('meal')
                              .doc(_auth.currentUser!.uid)
                              .update({
                            'day_meal': '0',
                            'night_meal': '0',
                          });
                          _dayMealController.clear();
                          _nightMealController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const CurrentData(),
      ],
    );
  }
}

//TODO: Working on this
class CurrentData extends StatefulWidget {
  const CurrentData({Key? key}) : super(key: key);

  @override
  State<CurrentData> createState() => _CurrentDataState();
}

class _CurrentDataState extends State<CurrentData> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: const Text(
            'Current Meal:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Constants().primaryColor,
                width: 3,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        getMealCount(mealTime: 'day_meal'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Night',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        getMealCount(mealTime: 'night_meal'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);
  final String buttonText;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}

class DayNightTile extends StatelessWidget {
  DayNightTile({Key? key, required this.dayTime, required this.controller})
      : super(key: key);

  final String dayTime;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    dayTime,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constants().primaryColor,
                          width: 5,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// children: [
// const Text(
// 'Date: ',
// style: TextStyle(
// fontSize: 25,
// fontWeight: FontWeight.bold,
// ),
// ),
// Text(
// getCurrentDate(),
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20,
// ),
// ),
// ],
// ),
// ),
