import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class AlertIcon extends StatefulWidget {
  final String sym;

  const AlertIcon({super.key, required this.sym});

  @override
  State<AlertIcon> createState() => _AlertIconState();
}

class _AlertIconState extends State<AlertIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isS(context)) {
          _showActionSheet(context, widget.sym);
        } else {
          _dialogBuilder(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Icon(
            size: 20,
            Icons.notifications,
            color: T(context, 'outline'),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Price alerts for ${widget.sym}'),
          content: const Text("We'll send an alert when you want us to.\n"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void _showActionSheet(BuildContext context, sym) {
  showModalBottomSheet<void>(
    showDragHandle: true,
    constraints: const BoxConstraints(maxHeight: 300),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$sym  custom alerts.'),
            const Text("We'll send alerts when you want us to."),
            Row(children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price moves above'),
                  Text('Toggle to enter price'),
                ],
              ),
              Toggler(
                type: '',
                onChanged: (hi) {},
                value: true,
              )
            ])
          ],
        ),
      );
    },
  );
}
