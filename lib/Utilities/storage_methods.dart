import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Custom_storage {
  final String name;
  final String email;
  final String address;
  Custom_storage({required this.name, required this.email, required this.address});

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference meals = FirebaseFirestore.instance.collection('meal');

  // FirebaseAuth current = FirebaseAuth.instance;


  Future<void> registerNewUser(String currentUser) async {
    try{
      await users.doc(currentUser).set({ //need to add userUID
        'name': name,
        'email' : email,
        'address': address,
      });
    } catch(e){
      print(e);
    }
  }
  Future<void> mealCounter(String currentUser) async{
    try{
      await meals.add({
        'name': currentUser,
      });
    } catch (e){
      print(e);
    }
  }
}
