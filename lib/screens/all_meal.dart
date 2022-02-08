import 'package:flutter/material.dart';
import 'package:mess_app/Utilities/constants.dart';

class AllMeal extends StatefulWidget {
  const AllMeal({Key? key}) : super(key: key);

  @override
  _AllMealState createState() => _AllMealState();
}

class _AllMealState extends State<AllMeal> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MemberTile extends StatefulWidget {
  const MemberTile({Key? key}) : super(key: key);

  @override
  MemberTileState createState() => MemberTileState();
}

class MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //TODO: Listview.builder for firebase firestore.
        );
  }
}

class DateTomorrow extends StatelessWidget {
  const DateTomorrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text(
            'Date: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            Constants().getCurrentDate(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
