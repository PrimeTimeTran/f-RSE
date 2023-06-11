import 'package:flutter/material.dart';

import 'package:rse/data/models/all.dart' as models;
import 'package:rse/presentation/widgets/all.dart';

class InvestmentGroup extends StatefulWidget {
  final int num;
  final String title;
  final models.Current current;
  final List<models.Investment> securities;
  const InvestmentGroup({Key? key,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Row(
        children: [
          SummaryTable(
            num: widget.num,
            title: widget.title,
            items: widget.securities,
            onCategoryTap: (int idx) {
              setState(() {
                _selectedSliceIndex = idx;
              });
            },
          ),
          Dougnut(data: widget.securities)
        ],
      ),
    );
  }
}
