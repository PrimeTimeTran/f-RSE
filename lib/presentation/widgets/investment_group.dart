import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/all.dart' as models;
import 'package:rse/presentation/all.dart';

class InvestmentGroup extends StatefulWidget {
  final int num;
  final String title;
  final models.Current current;
  final List<dynamic> securities;

  const InvestmentGroup({
    Key? key,
    required this.num,
    required this.title,
    required this.current,
    required this.securities,
  }) : super(key: key);

  @override
  State<InvestmentGroup> createState() => InvestmentGroupState();
}

class InvestmentGroupState extends State<InvestmentGroup> {
  int explodeIdx = 0;
  int hoveredRowIdx = 0;
  bool shouldExplode = false;
  String _sortField = 'totalValue';
  List<models.Investment> sortedSecurities = [];
  late ActivationMode activationMode = ActivationMode.none;

  @override
  void initState() {
    super.initState();
    sortedSecurities = widget.securities.mapIndexed((idx, s) =>
        models.Investment(
          idx: idx,
          name: s.symbol,
          value: s.price,
          quantity: s.quantity,
          totalValue: s.totalValue,
          percentage: s.percentOfGroup,
        ),
    ).toList();
  }

  sortSecurities(List<models.Investment> newOrder, String field) {
    setState(() {
      _sortField = field;
      sortedSecurities = newOrder;
    });
  }

  void handleHover(int idx) {
    setState(() {
      explodeIdx = idx;
      shouldExplode = true;
      // activationMode = ActivationMode.singleTap;
    });
  }

  void resetExplosion(int idx) {
    setState(() {
      explodeIdx = idx;
      shouldExplode = false;
      activationMode = ActivationMode.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SummaryTable(
          num: widget.num,
          title: widget.title,
          items: sortedSecurities,
          sortSecurities: sortSecurities,
          onCategoryHover: (int idx) {
            setState(() {
              hoveredRowIdx = idx;
            });
            handleHover(idx);
          },
          onCategoryExit: (int idx) {
            resetExplosion(idx);
          }
        ),
        Doughnut(
          field: _sortField,
          data: sortedSecurities,
          explodeIdx: explodeIdx,
          shouldExplode: shouldExplode,
          activationMode: activationMode,
          hoveredRowIndex: hoveredRowIdx,
        ),
      ],
    );
  }
}