import 'package:flutter/material.dart';

class AssetOverview extends StatelessWidget {
  const AssetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.red,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.white)
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Market Value', style: TextStyle(fontSize: 15),),
                          Text('\$100,000', style: TextStyle(fontSize: 25),),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
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
            ),
          ]
        ),
      ),
    );
  }
}
