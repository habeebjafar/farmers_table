import 'dart:math';

import 'package:flutter/material.dart';

class BuildStockList extends StatelessWidget {
  final List<String>? stockList;
  const BuildStockList({this.stockList});

  @override
  Widget build(BuildContext context) {
    return Container(

           child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        children: stockList!.map((item) {
          return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment:  CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 // CircleAvatar(
                   // radius: 27,
                   // backgroundColor: generateRandomColor2(),
                    //child: 
                    Image.asset(
                      "assets/images/${item.toLowerCase()}.png",
                      width: 80,
                      height: 80,
                    ),
                 // ),
                  Text(
                     item)
                ],
              ));

        
        }).toList(),
      ),
      
    );
  }

  
  Color generateRandomColor2() {
    Random random = Random();
    // Pick a random number in the range [0.0, 1.0)
    double randomDouble = random.nextDouble();

    return Color((randomDouble * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}