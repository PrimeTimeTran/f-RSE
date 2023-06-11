import 'package:flutter/material.dart';

import 'package:rse/data/models/all.dart' as models;
import 'package:rse/presentation/widgets/all.dart';

class InvestmentGroup extends StatefulWidget {
  final int num;
  final String title;
  final models.Current current;
  final List<models.Investment> securities;

  const InvestmentGroup({
    Key? key,
    required this.num,
    required this.title,
    required this.current,
    required this.securities,
  }) : super(key: key);

  @override
  State<InvestmentGroup> createState() => _InvestmentGroupState();
}

class _InvestmentGroupState extends State<InvestmentGroup> {
  int? _selectedSliceIndex;
  int _hoveredRowIndex = -1;
  String _sortField = 'name';

  List<models.Investment> orderedSecurities = [];

  sortSecurities(List<models.Investment> newOrder, String field) {
    setState(() {
      _sortField = field;
      orderedSecurities = newOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SummaryTable(
          num: widget.num,
          title: widget.title,
          items: widget.securities,
          sortSecurities: sortSecurities,
          onCategoryTap: (int idx) {
            setState(() {
              _selectedSliceIndex = idx;
            });
          },
          onCategoryHover: (int idx) {
            setState(() {
              _hoveredRowIndex = idx;
            });
          },
        ),
        Doughnut(
          field: _sortField,
          data: widget.securities,
          hoveredRowIndex: _hoveredRowIndex,
          hoveredCellIndex: ValueNotifier(_selectedSliceIndex ?? -1),
        ),
      ],
    );
  }
}