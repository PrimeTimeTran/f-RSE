import 'package:flutter/material.dart';

class PeriodSelector extends StatelessWidget {
  final List<String> periods;
  final Function(String) changePeriod;

  const PeriodSelector({super.key, required this.periods, required this.changePeriod});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: periods.map((period) {
          return Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () {
                changePeriod(period);
              },
              child: Container(
                height: 20, // Adjust the height as needed
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(period, style: TextStyle(fontSize: 10)),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}