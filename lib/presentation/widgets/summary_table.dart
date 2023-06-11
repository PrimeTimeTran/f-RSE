import 'package:flutter/material.dart';
import 'package:rse/data/models/all.dart' as models;

class SummaryTable extends StatefulWidget {
  final int num;
  final String title;
  final List<models.Investment> items;
  final Function(int index) onCategoryTap;

  SummaryTable({
    Key? key,
    required this.num,
    required this.title,
    required this.items,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  State<SummaryTable> createState() => _SummaryTableState();
}

class _SummaryTableState extends State<SummaryTable> {
  late final int num;
  late final String title;
  late final List<models.Investment> items;
  late final Function(int index) onCategoryTap;
  List<bool> selected = [];
  bool sortAscending = true;
  int? sortedColumnIndex;

  @override
  void initState() {
    num = widget.num;
    title = widget.title;
    items = widget.items;
    onCategoryTap = widget.onCategoryTap;
    super.initState();
    selected = List<bool>.generate(widget.num, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DataTable(
        columns: rowHeaders(),
        sortColumnIndex: sortedColumnIndex,
        sortAscending: sortAscending,
        showCheckboxColumn: false,
        rows: List<DataRow>.generate(
          num,
              (int idx) => DataRow(
            cells: rowCells(idx),
            selected: selected[idx],
            onSelectChanged: (bool? value) {
              setState(() {
                selected[idx] = value!;
              });
            },
            color: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> rowHeaders() {
    return [
      DataColumn(
        label: Expanded(
          child: InkWell(
            child: const Text('Name'),
            onTap: () => sortColumn(0, 'name'),
          ),
        ),
      ),
      DataColumn(
        label: InkWell(
          child: const Text('Shares'),
          onTap: () => sortColumn(1, 'quantity'),
        ),
      ),
      DataColumn(
        label: InkWell(
          child: const Text('Price'),
          onTap: () => sortColumn(2, 'value'),
        ),
      ),
      DataColumn(
        label: InkWell(
          child: const Text('Percentage'),
          onTap: () => sortColumn(3, 'percentage'),
        ),
      ),
      DataColumn(
        label: InkWell(
          child: const Text('Total \$'),
          onTap: () => sortColumn(4, 'totalValue'),
        ),
      ),
    ];
  }

  void sortColumn(int columnIndex, String field) {
    if (columnIndex == sortedColumnIndex) {
      setState(() {
        sortAscending = !sortAscending;
        items.sort((a, b) {
          return sortAscending ? a.compareTo(b, field) : b.compareTo(a, field);
        });
      });
    } else {
      setState(() {
        sortedColumnIndex = columnIndex;
        sortAscending = true;
        items.sort((a, b) {
          return a.compareTo(b, field);
        });
      });
    }
  }

  List<DataCell> rowCells(int idx) {
    var item = items[idx];
    return [
      DataCell(
        SizedBox(
          width: 200,
          child: InkWell(
            child: Text(item.name),
            onTap: () => onCategoryTap(idx),
          ),
        ),
      ),
      DataCell(Text(item.quantity.toString())),
      DataCell(Text(item.value.toString())),
      DataCell(Text(item.percentage.toString())),
      DataCell(Text(item.totalValue.toString())),
    ];
  }
}
