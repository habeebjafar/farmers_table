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
        children: stockList!.map((item) {
          return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: generateRandomColor2(),
                    child: Image.asset(
                      "assets/images/${item.toLowerCase()}.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
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