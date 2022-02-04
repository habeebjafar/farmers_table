import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CheckDeliveryMethod extends StatefulWidget {
  bool pickUpValue;
  Color pickUpColor;
  String pickUpText;
  String deliveryName;

  CheckDeliveryMethod(
      this.pickUpValue, this.pickUpColor, this.pickUpText, this.deliveryName,
      {Key? key})
      : super(key: key);

  @override
  _CheckDeliveryMethodState createState() => _CheckDeliveryMethodState();
}

class _CheckDeliveryMethodState extends State<CheckDeliveryMethod> {
  
  var provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<FarmProvider>(context, listen: false);
   // provider.deliveryMethods.add("Pickup");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // color: Colors.amberAccent,
          width: 25,
          height: 25,
          child: Checkbox(
              value: this.widget.pickUpValue,
              onChanged: (bool? value) {
                setState(() {
                  this.widget.pickUpValue = value!;
                  if (this.widget.pickUpValue == true) {
                    this.widget.pickUpColor = Colors.blue;
                    this.widget.pickUpText = this.widget.deliveryName;
                  } else {
                    this.widget.pickUpColor = Colors.grey;
                  }

                  if (this.widget.pickUpText.isNotEmpty &&
                      !provider.deliveryMethods.contains(this.widget.pickUpText)) {
                    provider.deliveryMethods.add(this.widget.pickUpText);
                  }
                  if (this.widget.pickUpValue == false &&
                      provider.deliveryMethods.contains(this.widget.pickUpText)) {
                    provider.deliveryMethods.remove(this.widget.pickUpText);
                    provider.deliveryMethods.join(', ');
                  }
                });
              }),
        ),
        Text(
          "${this.widget.deliveryName}",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: this.widget.pickUpColor),
        ),
      ],
    );
  }
}
