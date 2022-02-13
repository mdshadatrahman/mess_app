import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/all_meal_list.dart';

StreamBuilder<QuerySnapshot<Object?>> getAllMealCount() {
  final _firestore = FirebaseFirestore.instance;
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('meal').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      List<AllMealList> allMealSecondPage = [];

      final meals = snapshot.data!.docs;
      for (var meal in meals) {
        final String name = meal['name'];
        final String dayMeal = meal['day_meal'];
        final String nightMeal = meal['night_meal'];
        final allmeallist = AllMealList(
          name: name,
          totalDayMeal: dayMeal,
          totalNightMeal: nightMeal,
        );
        allMealSecondPage.add(allmeallist);
      }

      return ListView(
        children: allMealSecondPage,
      );

      // return ListView(
      //   children: allMealSecondPage,
      //   shrinkWrap: true,
      // );
    },
  );
}
