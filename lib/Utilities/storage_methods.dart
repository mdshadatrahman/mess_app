import 'package:cloud_firestore/cloud_firestore.dart';

class Custom_storage {
  final String name;
  final String email;
  Custom_storage({required this.name, required this.email});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future<void> registerNewUser() async {
    try{
      await users.add({
        'name': name,
        'email' : email,
      });
    } catch(e){
      print(e);
    }
  }
}
