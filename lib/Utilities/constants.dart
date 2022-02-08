import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  final primaryColor = Colors.green;
  final appName = 'The Unknown';

  getCurrentDate() {
    return DateFormat('dd-MM-yyyy')
        .format(DateTime.now().add(const Duration(days: 1)));
  }
}
