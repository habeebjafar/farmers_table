import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  MySnackBar extends StatelessWidget {
 final message;
 MySnackBar({this.message});

  @override
  Widget build(BuildContext context) {
    
    return  SnackBar(
      content:  Text("$message"),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
      duration: Duration(seconds: 2),
    );
   

  }
}