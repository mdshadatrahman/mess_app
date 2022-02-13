import 'package:flutter/material.dart';

class AllMealList extends StatefulWidget {
  const AllMealList({
    Key? key,
    required this.name,
    required this.totalDayMeal,
    required this.totalNightMeal,
  }) : super(key: key);
  final String name;
  final String totalDayMeal;
  final String totalNightMeal;

  @override
  _AllMealListState createState() => _AllMealListState();
}

class _AllMealListState extends State<AllMealList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '\n${widget.name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          widget.totalDayMeal,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Night',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.totalNightMeal,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
