import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketSellerWidget extends StatefulWidget {

  Function(bool) onChanged;
  bool marketSellerValue;
  Color marketSellerColor;
   MarketSellerWidget(this.marketSellerValue, this.marketSellerColor, this.onChanged, { Key? key }) : super(key: key);

  @override
  _MarketSellerWidgetState createState() => _MarketSellerWidgetState();
}

class _MarketSellerWidgetState extends State<MarketSellerWidget> {

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
                Switch(
                    value: this.widget.marketSellerValue,
                    onChanged: (bool value) {
                      setState(() {
                         this.widget.marketSellerValue = value;
                         if(this.widget.marketSellerValue == true){
                           this.widget.marketSellerColor = Colors.blue;
                           

                         }else{
                            this.widget.marketSellerColor = Colors.grey;

                         }

                         provider.marketSellerValue = this.widget.marketSellerValue;
                      });
                      widget.onChanged(value);
                    }),
                Text(
                  "Become a market place seller",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.info,
                  color: Colors.blue,
                )
              ],
            );

  }
}