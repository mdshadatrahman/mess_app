import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataFromFirebase extends StatefulWidget {
  const GetDataFromFirebase({Key? key}) : super(key: key);

  @override
  _GetDataFromFirebaseState createState() => _GetDataFromFirebaseState();
}

class _GetDataFromFirebaseState extends State<GetDataFromFirebase> {
  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('meal').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return const Text('Something went wrong');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading');
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document){
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['guest_day_meal']),
            );
          }).toList(),
        );
      },
    );
  }
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
