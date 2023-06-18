import 'package:flutter/material.dart';

class AssetOverview extends StatelessWidget {
  const AssetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.lightBlueAccent,
          child: const Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Market Value', style: TextStyle(fontSize: 15),),
                        Text('\$100,000', style: TextStyle(fontSize: 25),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Average Cost'),
                        Text('\$30', style: TextStyle(fontSize: 25),),
                        Text('Shares'),
                        Text('\$30', style: TextStyle(fontSize: 25),),
                      ],
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}
