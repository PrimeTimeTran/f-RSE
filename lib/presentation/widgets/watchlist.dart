import 'package:flutter/material.dart';

const List<String> watched = ['BAC', 'COIN', 'TSLA', 'T', 'JPM', 'GOOGL', 'HOOD', 'BRK.A', 'NKE', 'NFLX', 'ADBE', 'ORCL'];
class Watchlist extends StatelessWidget {

  const Watchlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.33,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 250, 0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: watched.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('BAC', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text('200 Shares', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('CHART'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('\$300', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text('50%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
