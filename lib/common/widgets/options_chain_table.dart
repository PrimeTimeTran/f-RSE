import 'package:flutter/material.dart';

class OptionsTable extends StatefulWidget {
  final List<OptionData> optionsData;

  OptionsTable({required this.optionsData});

  @override
  _OptionsTableState createState() => _OptionsTableState();
}

class _OptionsTableState extends State<OptionsTable> {
  List<OptionData> optionsData = [
    OptionData(
      delta: 0.1,
      volume: 0,
      bid: 1,
      ask: 1,
      askIv: 0.8,
      strike: 1,
      bidIv: 0.9,
    ),
    OptionData(
      delta: 0.52,
      volume: 10,
      bid: 10,
      ask: 12.1,
      askIv: 0.8,
      strike: 100,
      bidIv: 0.9,
    ),
    OptionData(
      delta: 0.53,
      volume: 100,
      bid: 10.0,
      ask: 12.02,
      askIv: 0.8,
      strike: 100.01,
      bidIv: 0.9,
    ),
  ];

  final List<Map<String, dynamic>> propertiesOrder = [
    {'name': 'delta', 'icon': Icons.ac_unit},
    {'name': 'volume', 'icon': Icons.volume_up},
    {'name': 'bid', 'icon': Icons.attach_money},
    {'name': 'ask', 'icon': Icons.attach_money},
    {'name': 'askIv', 'icon': Icons.settings},
    {'name': 'strike', 'icon': Icons.show_chart},
    {'name': 'bidIv', 'icon': Icons.settings},
    {'name': 'bid', 'icon': Icons.attach_money},
    {'name': 'ask', 'icon': Icons.attach_money},
    {'name': 'askIv', 'icon': Icons.settings},
    {'name': 'volume', 'icon': Icons.volume_up},
    {'name': 'delta', 'icon': Icons.ac_unit},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FittedBox(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: DataTable(
                columnSpacing: 1.0,
                columns: propertiesOrder.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String name = entry.value['name'];
                  final IconData? icon = entry.value['icon'];
                  return DataColumn(
                    label: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width:
                                index < propertiesOrder.length - 1 ? 1.0 : 0.0,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          if (icon != null) Icon(icon),
                          Text(
                            name,
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                rows: optionsData.map((o) {
                  return DataRow(
                    cells: propertiesOrder.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final String name = entry.value['name'];
                      final dynamic value = o.getPropertyValue(name);
                      return DataCell(
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.black,
                                width: index < propertiesOrder.length - 1
                                    ? 1.0
                                    : 0.0,
                              ),
                            ),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Center(
                              child: Text(
                                value.toString(),
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OptionData {
  final double delta;
  final int volume;
  final double bid;
  final double ask;
  final double askIv;
  final double strike;
  final double bidIv;

  OptionData({
    required this.delta,
    required this.volume,
    required this.bid,
    required this.ask,
    required this.askIv,
    required this.strike,
    required this.bidIv,
  });

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'delta':
        return delta;
      case 'volume':
        return volume;
      case 'bid':
        return bid;
      case 'ask':
        return ask;
      case 'askIv':
        return askIv;
      case 'strike':
        return strike;
      case 'bidIv':
        return bidIv;
      default:
        throw Exception('Invalid property name: $propertyName');
    }
  }
}
