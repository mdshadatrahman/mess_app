import 'package:flutter/material.dart';
import 'package:mess_app/Utilities/storage_methods.dart';

class AllMeal extends StatefulWidget {
  const AllMeal({Key? key}) : super(key: key);

  @override
  _AllMealState createState() => _AllMealState();
}

class _AllMealState extends State<AllMeal> {
  @override
  Widget build(BuildContext context) {
    return GetDataFromFirebase();
  }
}