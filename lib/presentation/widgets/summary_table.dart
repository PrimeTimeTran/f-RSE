import 'package:flutter/material.dart';

import 'package:rse/data/models/all.dart' as models;
import 'package:rse/presentation/utils/all.dart';

class SummaryTable extends StatefulWidget {
  final int num;
  final String title;
  final List<models.Investment> items;
  final Function(int idx) onCategoryHover;
  final Function(int idx) onCategoryExit;
  final Function(List<models.Investment> newOrder, String field) sortSecurities;

  const SummaryTable({
    Key? key,
    required this.num,
    required this.title,
    required this.items,
    required this.sortSecurities,
    required this.onCategoryHover,
    required this.onCategoryExit,
  }) : super(key: key);

  @override
  State<SummaryTable> createState() => _SummaryTableState();
}

extension DataRowExtensions on DataRow {
  Widget wrapWithMouseRegion({
    required VoidCallback onEnter,
    required VoidCallback onExit,
  }) {
    return MouseRegion(
      onEnter: (event) => onEnter(),
      onExit: (event) => onExit(),
      child: Container(
        child: this as Widget,
      ),
    );
  }
}

class _SummaryTableState extends State<SummaryTable> {
  late final int num;
  late final String title;
  late final List<models.Investment> items;

  int sortedColumnIndex = 0;
  bool sortAscending = true;

  @override
  void initState() {
    num = widget.num;
    title = widget.title;
    items = widget.items;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 0,
      columns: rowHeaders(),
      showCheckboxColumn: false,
      rows: List<DataRow>.generate(
        num, (int idx) => DataRow(
          cells: rowCells(idx),
          onSelectChanged: (bool? value) {
            setState(() {
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
          child: const Text('# Shares'),
          onTap: () => sortColumn(1, 'quantity'),
        ),
      ),
      DataColumn(
        label: InkWell(
          child: const Text('\$ Price'),
          onTap: () => sortColumn(2, 'value'),
        ),
      ),
      DataColumn(
        label: InkWell(
          child: const Text('Percentage %'),
          onTap: () => sortColumn(3, 'percentage'),
        ),
      ),
      DataColumn(
        label: InkWell(
          child: const Text('\$ Total'),
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
        widget.sortSecurities(items, field);
      } else {
        sortAscending = true;
        sortedColumnIndex = columnIndex;
        items.sort((a, b) => a.compareTo(b, field));
        widget.sortSecurities(items, field);
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
        wrapHover(item, formatMoney(item.value.toString())),
      ),
      DataCell(
        wrapHover(item, '${item.percentage}%'),
      ),
      DataCell(
        wrapHover(item, formatMoney(item.totalValue.toString())),
      ),
    ];
  }

  MouseRegion wrapHover(models.Investment item, String val) {
    return MouseRegion(
        onEnter: (_) {
          widget.onCategoryHover(item.idx);
        },
        onExit: (_) {
          widget.onCategoryExit(item.idx);
        },
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(val),
          ),
        ),
      );
  }
}
