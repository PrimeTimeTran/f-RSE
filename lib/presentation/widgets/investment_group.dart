import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class InvestmentGroup extends StatefulWidget {
  final int num;
  final String title;
  final Current current;
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
  List<Investment> sortedSecurities = [];
  late ActivationMode activationMode = ActivationMode.none;

  @override
  void initState() {
    super.initState();
    sortedSecurities = widget.securities.mapIndexed((idx, s) =>
        Investment(
          idx: idx,
          name: s.symbol,
          value: s.price,
          quantity: s.quantity,
          totalValue: s.totalValue,
          percentage: s.percentOfGroup,
        ),
    ).toList();
  }

  sortSecurities(List<Investment> newOrder, String field) {
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


  getWidth() {
    final width = MediaQuery.of(context).size.width;
    if (isS(context)) {
      return width *.4;
    } else if (isM(context)) {
      return width *.8;
    } else if (isL(context)) {
      return width *.7;
    }
    return width *.9;
  }

  getHeight() {
    final height = MediaQuery.of(context).size.height;
    if (isS(context)) {
      return height *.4;
    } else if (isM(context)) {
      return height *.8;
    } else if (isL(context)) {
      return height *.7;
    }
    return height *.9;
  }

  @override
  Widget build(BuildContext context) {
    if (isS(context) || isM(context)) {
      return Column(
        children: [
          Doughnut(
            field: _sortField,
            data: sortedSecurities,
            explodeIdx: explodeIdx,
            shouldExplode: shouldExplode,
            activationMode: activationMode,
            hoveredRowIndex: hoveredRowIdx,
          ),
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
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SummaryTable(
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
        ),
        Expanded(
          flex: 2,
          child: Doughnut(
            field: _sortField,
            data: sortedSecurities,
            explodeIdx: explodeIdx,
            shouldExplode: shouldExplode,
            activationMode: activationMode,
            hoveredRowIndex: hoveredRowIdx,
          ),
        ),
      ],
    );
  }
}