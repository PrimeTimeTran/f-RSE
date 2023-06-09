import 'package:flutter/material.dart';

class SummaryTable extends StatelessWidget {
  final String title;
  final List<String> categories;
  final List<double> percentages;
  final List<String> totalAmounts;
  final Function(int index) onCategoryTap;

  SummaryTable({
    required this.title,
    required this.categories,
    required this.percentages,
    required this.totalAmounts,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Percentage')),
                DataColumn(label: Text('Total \$')),
              ],
              rows: List.generate(categories.length, (index) {
                return DataRow(
                  cells: [
                    DataCell(
                      InkWell(
                        onTap: () => onCategoryTap(index),
                        child: Text(categories[index]),
                      ),
                    ),
                    DataCell(Text('${percentages[index]}%')),
                    DataCell(Text(totalAmounts[index])),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
