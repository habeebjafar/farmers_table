import 'dart:math';

import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:farmerstable/pages/home_page.dart';
import 'package:farmerstable/widgets/checkDeliveryMethod.dart';
import 'package:farmerstable/widgets/market_seller.dart';
import 'package:farmerstable/widgets/switch_on_animal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFarmPage extends StatefulWidget {
  const AddFarmPage({Key? key}) : super(key: key);

  @override
  _AddFarmPageState createState() => _AddFarmPageState();
}

class _AddFarmPageState extends State<AddFarmPage> {
  var provider;
  bool isloading = false;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController farmNameController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getPref();
    provider = Provider.of<FarmProvider>(context, listen: false);
    provider.deliveryMethods.add("Pickup");
  }

  _getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var loginDetails = pref.getStringList("loginDetails");
    setState(() {
      if (loginDetails != null) {
        firstNameController.text = loginDetails[0];
        lastNameController.text = loginDetails[1];
        emailController.text = loginDetails[2];
      }
    });
  }

  bool marketSellerValue = false;
  Color marketSellerColor = Colors.grey;
  bool pickUpValue = true;
  Color pickUpColor = Colors.blue;
  String pickUpText = "Pickup";

  bool deliveryValue = false;
  Color deliveryColor = Colors.grey;
  String deliveryText = "";

  bool shippedValue = false;
  Color shippedColor = Colors.grey;
  String shippedText = "";

  bool beefValue = false;
  Color beefTextColor = Colors.grey;
  String beefText = "";

  bool chickenValue = false;
  Color chickenTextColor = Colors.grey;
  String chickenText = "";

  bool eggValue = false;
  Color eggTextColor = Colors.grey;
  String eggText = "";

  bool dairyValue = false;
  Color dairyTextColor = Colors.grey;
  String dairyText = "";

  bool lambValue = false;
  Color lambTextColor = Colors.grey;
  String lambText = "";

  bool elkValue = false;
  Color elkTextColor = Colors.grey;
  String elkText = "";

  bool rabbitValue = false;
  Color rabbitTextColor = Colors.grey;
  String rabbitText = "";

  bool duckValue = false;
  Color duckTextColor = Colors.grey;
  String duckText = "";

  bool goatValue = false;
  Color goatTextColor = Colors.grey;
  String goatText = "";

  bool gooseValue = false;
  Color gooseTextColor = Colors.grey;
  String gooseText = "";

  bool bisonValue = false;
  Color bisonTextColor = Colors.grey;
  String bisonText = "";

  bool vegetablesValue = false;
  Color vegetablesTextColor = Colors.grey;
  String vegetablesText = "";

  bool fruitsValue = false;
  Color fruitsTextColor = Colors.grey;
  String fruitsText = "";

  bool seafoodValue = false;
  Color seafoodTextColor = Colors.grey;
  String seafoodText = "";

  bool honeyValue = false;
  Color honeyTextColor = Colors.grey;
  String honeyText = "";

  bool turkeyValue = false;
  Color turkeyTextColor = Colors.grey;
  String turkeyText = "";

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FarmProvider>(context, listen: false);

    return Scaffold(
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 30,
                          color: Colors.blue,
                        ),
                      )

                      // Container(
                      //   color: Colors.red,
                      //   width: 30,
                      //   height: 30,
                      //   alignment: Alignment.topCenter,
                      //   child: IconButton(onPressed: (){},
                      //   icon: Icon(Icons.keyboard_arrow_down_outlined)
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add your farm",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(height: 13),



                 Form(
                    key: globalKey,
                   child: Column(
                     children: [
                        TextFormField(
                    controller: farmNameController,
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    cursorWidth: 3,
                    validator: (input) => input!.length < 1
                        ? "Farm name must not be empty"
                        : null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                      //hintText: "Cattle name. *",
                      hintText: "Farm name",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),

                       errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                       focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: fullAddressController,
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    cursorWidth: 3,
                    validator: (input) => input!.length < 15
                        ? "Please enter a valid address"
                        : null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                      //hintText: "Cattle name. *",
                      hintText: "Full address",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                       focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: firstNameController,
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    cursorWidth: 3,
                    validator: (input) =>
                        input!.length < 1 ? "Name must not be empty" : null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                      //hintText: "Cattle name. *",
                      hintText: "First name",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                       errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                       focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    cursorWidth: 3,
                    validator: (input) =>
                        input!.length < 1 ? "Name must not be empty" : null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                      //hintText: "Cattle name. *",
                      hintText: "Last name",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),

                       errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                       focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    cursorWidth: 3,
                    keyboardType: TextInputType.number,
                    validator: (input) => input!.length < 1
                        ? "Phone number must not be empty"
                        : null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                      //hintText: "Cattle name. *",
                      hintText: "Phone",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                       errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                       focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    cursorWidth: 3,
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) => !input!.contains('@')
                        ? "Email Id should be valid"
                        : null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                      //hintText: "Cattle name. *",
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                       errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: Colors.red,
                        ),
                      ),
                      
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: websiteController,
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                      //hintText: "Cattle name. *",
                      hintText: "Website (optional)",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                     ],
                   )
                   ),


                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black26,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CheckDeliveryMethod(
                              pickUpValue, pickUpColor, pickUpText, "Pickup"),
                          CheckDeliveryMethod(deliveryValue, deliveryColor,
                              deliveryText, "Delivery"),
                          CheckDeliveryMethod(shippedValue, shippedColor,
                              shippedText, "Shipped"),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SwitchOnAnimal(
                                beefValue, beefTextColor, beefText, "Beef"),
                            SwitchOnAnimal(chickenValue, chickenTextColor,
                                chickenText, "Chicken"),
                            SwitchOnAnimal(
                                eggValue, eggTextColor, eggText, "Eggs"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SwitchOnAnimal(
                                dairyValue, dairyTextColor, dairyText, "Dairy"),
                            SwitchOnAnimal(
                                lambValue, lambTextColor, lambText, "Lamb"),
                            SwitchOnAnimal(
                                elkValue, elkTextColor, elkText, "Elk"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SwitchOnAnimal(rabbitValue, rabbitTextColor,
                                rabbitText, "Rabbit"),
                            SwitchOnAnimal(
                                duckValue, duckTextColor, duckText, "Duck"),
                            SwitchOnAnimal(
                                goatValue, goatTextColor, goatText, "Goat"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SwitchOnAnimal(
                                gooseValue, gooseTextColor, gooseText, "Goose"),
                            SwitchOnAnimal(
                                bisonValue, bisonTextColor, bisonText, "Bison"),
                            SwitchOnAnimal(turkeyValue, turkeyTextColor,
                                turkeyText, "Turkey"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SwitchOnAnimal(seafoodValue, seafoodTextColor,
                                seafoodText, "Seafood"),
                            SwitchOnAnimal(vegetablesValue, vegetablesTextColor,
                                vegetablesText, "Vegetables"),
                            SwitchOnAnimal(fruitsValue, fruitsTextColor,
                                fruitsText, "Fruits"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SwitchOnAnimal(
                                honeyValue, honeyTextColor, honeyText, "Honey"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MarketSellerWidget(marketSellerValue, marketSellerColor)
                  // TextButton(
                  //   style: ButtonStyle(
                  //     backgroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.orange),
                  //   ),
                  //   onPressed: () {
                  //     // Navigator.pop(context);
                  //     var provider =
                  //         Provider.of<FarmProvider>(context, listen: false);
                  //     print(provider.animals);
                  //     print(provider.deliveryMethods);
                  //   },
                  //   child: Text(
                  //     "CANCEL",
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                  // MaterialButton(
                  //     child: Text("Save"),
                  //     onPressed: () {
                  //       var provider =
                  //           Provider.of<FarmProvider>(context, listen: false);
                  //       print(provider.animals);
                  //       print(provider.deliveryMethods);
                  //       // print(beefText);
                  //     })
                ],
              ),
            ),
      bottomNavigationBar: Container(
          child: Row(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.35,
            alignment: Alignment.center,
            child: MaterialButton(
                child: Text(
                  "FREE",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  var provider =
                      Provider.of<FarmProvider>(context, listen: false);
                  print(provider.animals);
                  print(provider.deliveryMethods);
                  // print(beefText);
                }),
          ),
          Container(
            color: Colors.green,
            height: 50,
            width: MediaQuery.of(context).size.width * 0.65,
            alignment: Alignment.center,
            child: MaterialButton(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Text(
                    "FINISH",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                 

                  if(validateAndSave()){

                     setState(() {
                    isloading = true;
                  });

                  var url = websiteController.text;

                  if ((!url.contains("https://") || !url.contains("http://")) &&
                      url.contains("www")) {
                    url = "http://" + url;
                  } else if ((!url.contains("https://") ||
                          !url.contains("http://")) &&
                      !url.contains("www")) {
                    url = "http://www." + url;
                  } else if(url.isEmpty){
                    url = "";

                  }


                       bool isUploaded = await provider.saveFarmersStocks(
                      farmNameController.text,
                      fullAddressController.text,
                      firstNameController.text,
                      lastNameController.text,
                      phoneNumberController.text,
                      emailController.text,
                      url
                      );

                  if (isUploaded == true) {
                    _bottomSheet();

                    setState(() {
                      isloading = false;
                    });

                    //print("successfully added another farm");
                    //_bottomSheet(context);
                  }


                  }

               

                  // print(provider.animals);
                  //print(provider.deliveryMethods);

                  // print(beefText);
                }),
          )

          //  TextButton(
          //     style: ButtonStyle(
          //       backgroundColor:
          //           MaterialStateProperty.all<Color>(Colors.orange),
          //     ),
          //     onPressed: () {
          //       // Navigator.pop(context);
          //       var provider =
          //           Provider.of<FarmProvider>(context, listen: false);
          //       print(provider.animals);
          //       print(provider.deliveryMethods);
          //     },
          //     child: Text(
          //       "FREE",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),

          //  TextButton(
          //     style: ButtonStyle(
          //       backgroundColor:
          //           MaterialStateProperty.all<Color>(Colors.orange),
          //     ),
          //     onPressed: () {
          //       // Navigator.pop(context);
          //       var provider =
          //           Provider.of<FarmProvider>(context, listen: false);
          //       print(provider.animals);
          //       print(provider.deliveryMethods);
          //     },
          //     child: Text(
          //       "FINISH",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
        ],
      )),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _bottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        enableDrag: true,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/congrats.png",
                    width: 130,
                    height: 100,
                  ),
                  Text(
                    "Congrats ${firstNameController.text}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "YOUR LISTING IS LIVE",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "WE WILL FOLLOW UP VIA EMAIL ABOUT BECOMING A SELLER ON OUR MARKET PLACE",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      // var provider =
                      //     Provider.of<FarmProvider>(context, listen: false);
                      // print(provider.animals);
                      // print(provider.deliveryMethods);
                      // Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )));
        });
  }
}
