import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Custom_storage {
  final String name;
  final String email;
  final String address;

  Custom_storage(
      {required this.name, required this.email, required this.address});

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference meals = FirebaseFirestore.instance.collection('meal');

  Future<void> registerNewUser(String currentUser) async {
    try {
      await users.doc(currentUser).set({
        'name': name,
        'email': email,
        'address': address,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> mealCounter(
      {required String uid,
      required String currentUserName,
      required String dayMeal,
      required String nightMeal,
      required String guestDayMeal,
      required String guestNightMeal}) async {
    try {
      await meals.doc(uid).set({
        'name': currentUserName,
        'day_meal': dayMeal,
        'night_meal': nightMeal,
        'guest_day_meal': guestDayMeal,
        'guest_night_meal': guestNightMeal,
      });
    } catch (e) {
      print(e);
    }
  }
}
