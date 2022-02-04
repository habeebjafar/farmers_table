import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchOnAnimal extends StatefulWidget {
   bool switchValue;
    Color textColor;
    String textValue;
    String animalName;
   
   SwitchOnAnimal(this.switchValue, this.textColor, this.textValue, this.animalName, { Key? key }) : super(key: key);

  @override
  _SwitchOnAnimalState createState() => _SwitchOnAnimalState();
}

class _SwitchOnAnimalState extends State<SwitchOnAnimal> {

 
  var provider;

   @override
  void initState() {
    super.initState();
    provider = Provider.of<FarmProvider>(context, listen: false);
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 35,
          //color: Colors.red,
          child: Switch(
              value: this.widget.switchValue,
              activeColor: Colors.teal,
              onChanged: (bool value) {
                setState(() {
                  this.widget.switchValue = value;
                  if (this.widget.switchValue == true) {
                    this.widget.textColor = Colors.green;
                    this.widget.textValue = "${this.widget.animalName}";
                  } else {
                    this.widget.textColor = Colors.grey;
                    //this.widget.textValue = "";
                  }
                  
                  if(this.widget.textValue.isNotEmpty && !provider.animals.contains(this.widget.textValue)){
                    provider.animals.add(this.widget.textValue);
                  }
                 if(this.widget.switchValue == false && provider.animals.contains(this.widget.textValue)){
                    provider.animals.remove(this.widget.textValue);
                    provider.animals.join(', ');

                  }
                  
                });

               
              }),
        ),
        Text(
          "${this.widget.animalName}",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: this.widget.textColor
              ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}