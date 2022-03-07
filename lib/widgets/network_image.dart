import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Center(
          child: Column(
        children: [
          Image.asset(
            "assets/images/network.png",
            width: 90,
            height: 90,
          ),
          Text("No network connection")
        ],
      )),
    );
  }
}
