import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
StreamBuilder<DocumentSnapshot<Object?>> getMealCount(
    {required String mealTime}) {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  return StreamBuilder<DocumentSnapshot>(
    stream:
    _firestore.collection('meal').doc(_auth.currentUser!.uid).snapshots(),
    builder: (context, snapshot) {
      var testMeal = '';
      if (snapshot.hasData) {
        final meal = snapshot.data;
        testMeal = meal![mealTime];
      }
      return Text(
        testMeal.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      );
    },
  );
}

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

  Future<String> getMealCurrentState() async {
    var totalDayMeal = await meals
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('guest_day_meal')
        .get()
        .toString();

    return totalDayMeal;
  }

  Future<void> mealCounter({
    required String uid,
    required String currentUserName,
    required String dayMeal,
    required String nightMeal,
    required String guestDayMeal,
    required String guestNightMeal,
  }) async {
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

//return ListView(
//           children: snapshot.data!.docs.map((DocumentSnapshot document) {
//             Map<String, dynamic> data =
//                 document.data()! as Map<String, dynamic>;
//             return ListTile(
//               title: Text(data['name']),
//               subtitle: Text(data['guest_day_meal']),
//             );
//           }).toList(),
//         );
