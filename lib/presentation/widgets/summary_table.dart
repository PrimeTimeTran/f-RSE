import 'package:flutter/material.dart';
import 'package:rse/data/models/all.dart' as models;

class SummaryTable extends StatefulWidget {
  final int num;
  final String title;
  final List<models.Investment> items;
  final Function(int index) onCategoryTap;
  final ValueNotifier<int> hoveredCellIndex;
  final Function(int index) onCategoryHover;

  SummaryTable({
    Key? key,
    required this.num,
    required this.title,
    required this.items,
    required this.onCategoryTap,
    required this.onCategoryHover,

  })  : hoveredCellIndex = ValueNotifier(-1),
        super(key: key);

  @override
  State<SummaryTable> createState() => _SummaryTableState();
}

class _SummaryTableState extends State<SummaryTable> {
  late final int num;
  late final String title;
  late final List<models.Investment> items;
  late ValueNotifier<int> hoveredCellIndex;
  late final Function(int index) onCategoryTap;

  int sortedColumnIndex = 0;
  bool sortAscending = true;

  @override
  void initState() {
    num = widget.num;
    title = widget.title;
    items = widget.items;
    onCategoryTap = widget.onCategoryTap;
    hoveredCellIndex = widget.hoveredCellIndex;
    super.initState();
  }

  @override
  void dispose() {
    hoveredCellIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DataTable(
        columns: rowHeaders(),
        showCheckboxColumn: false,
        rows: List<DataRow>.generate(
          num, (int idx) => DataRow(
            cells: rowCells(idx),
            onSelectChanged: (_) => onCategoryTap(idx),
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
        label: InkWell(
          child: const Text('Name'),
          onTap: () => sortColumn(0, 'name'),
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
    setState(() {
      if (columnIndex == sortedColumnIndex) {
        sortAscending = !sortAscending;
        items.sort((a, b) => sortAscending ? a.compareTo(b, field) : b.compareTo(a, field));
      } else {
        sortAscending = true;
        sortedColumnIndex = columnIndex;
        items.sort((a, b) => a.compareTo(b, field));
      }
    });
  }

  List<DataCell> rowCells(int idx) {
    var item = items[idx];
    return [
      DataCell(
        wrapHover(item, item.name),
      ),
      DataCell(
        wrapHover(item, item.quantity.toString()),
      ),
      DataCell(
        wrapHover(item, item.value.toString()),
      ),
      DataCell(
        wrapHover(item, item.percentage.toString()),
      ),
      DataCell(
        wrapHover(item, item.totalValue.toString()),
      ),
    ];
  }

  MouseRegion wrapHover(models.Investment item, String val) {
    return MouseRegion(
        onEnter: (_) {
          widget.onCategoryHover(item.idx);
        },
        child: InkWell(
          onTap: () => onCategoryTap(item.idx),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(val),
          ),
        ),
      );
  }
}
