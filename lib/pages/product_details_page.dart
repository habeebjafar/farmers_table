import 'dart:math';

import 'package:farmerstable/models/farmers_stocks_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsPage extends StatefulWidget {
  final index;
  final List<FarmersStockModel>? stockList;
  ProductDetailsPage({this.index, this.stockList});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  List<String> farmersStocksList = [];

  List<String> farmersStocksList2 = [];

  List<String> farmersStocksList3 = [];

  //var provider;

  @override
  void initState() {
    super.initState();

    //provider = Provider.of<FarmProvider>(context, listen: false);

    var farmersStocks =widget.stockList![widget.index].farmersStocks!
        .substring(1,
           widget.stockList![widget.index].farmersStocks!.length - 1);

    farmersStocksList = farmersStocks.split(', ');

    if (farmersStocksList.length > 5) {
      farmersStocksList2 = farmersStocksList.sublist(5);
    } else {
      farmersStocksList2 = [];
    }

    if (farmersStocksList.length > 10) {
      farmersStocksList3 = farmersStocksList.sublist(10);
    } else {
      farmersStocksList3 = [];
    }
  }

  Color generateRandomColor2() {
    Random random = Random();
    // Pick a random number in the range [0.0, 1.0)
    double randomDouble = random.nextDouble();

    return Color((randomDouble * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text("hello"),
       actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             child: Row(
               children: [
                 Icon(Icons.verified),
                 Text("Verified"),
               ],
             ),
           ),
         )
       ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${widget.stockList![widget.index].farmName}"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "${widget.stockList![widget.index].distance} miles away . ${widget.stockList![widget.index].fullAdrees}"),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                 widget.stockList![widget.index].deliveryMethod!
                          .contains("Pickup")
                      ? Row(
                          children: [
                            Chip(
                              //backgroundColor: Colors.white54,
                              label: Text(
                                "Pickup",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                          ],
                        )
                      : Container(),
                 widget.stockList![widget.index].deliveryMethod!
                          .contains("Delivery")
                      ? Row(
                          children: [
                            Chip(
                              //backgroundColor: Colors.white,
                              label: Text(
                                "Local Delivery",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                          ],
                        )
                      : Container(),
                 widget.stockList![widget.index].deliveryMethod!
                          .contains("Shipped")
                      ? Row(
                          children: [
                            Chip(
                              //backgroundColor: Colors.white,
                              label: Text(
                                "National Shipping",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Available Products"),
                 
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 85,
                //color: Colors.red,
                child: ListView.builder(
                    itemCount: farmersStocksList.length > 5
                        ? 5
                        : farmersStocksList.length,
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, innerIndex) {
                      return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 27,
                                backgroundColor: generateRandomColor2(),
                                child: Image.asset(
                                  "assets/images/${farmersStocksList[innerIndex].toLowerCase()}.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Text("${farmersStocksList[innerIndex]}")
                            ],
                          ));
                    }),
              ),

              farmersStocksList2.isNotEmpty
                  ? Container(
                      height: 85,
                      child: ListView.builder(
                          itemCount: farmersStocksList2.length > 5
                              ? 5
                              : farmersStocksList2.length,
                          scrollDirection: Axis.horizontal,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, innerIndex) {
                            return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 27,
                                      backgroundColor: generateRandomColor2(),
                                      child: Image.asset(
                                        "assets/images/${farmersStocksList2[innerIndex].toLowerCase()}.png",
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    Text("${farmersStocksList2[innerIndex]}")
                                  ],
                                ));
                          }),
                    )
                  : Container(),

              farmersStocksList3.isNotEmpty
                  ? Container(
                      height: 85,
                      child: ListView.builder(
                          itemCount: farmersStocksList3.length > 5
                              ? 5
                              : farmersStocksList3.length,
                          scrollDirection: Axis.horizontal,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, innerIndex) {
                            return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 27,
                                      backgroundColor: generateRandomColor2(),
                                      child: Image.asset(
                                        "assets/images/${farmersStocksList3[innerIndex].toLowerCase()}.png",
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    Text("${farmersStocksList3[innerIndex]}")
                                  ],
                                ));
                          }),
                    )
                  : Container(),
             
              SizedBox(
                height: 12,
              ),
               Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _makePhoneCall(
                                              "${this.widget.stockList![this.widget.index].phoneNumber}");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            "Call",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (this.widget.stockList![this.widget.index].website!
                                              .isNotEmpty) {
                                            await _launchInBrowser(
                                                "${this.widget.stockList![this.widget.index].website}");
                                          } else {
                                            _displaySnackBar(
                                                "No website associated with this farm");
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            "Website",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _sendEmail(
                                              "${this.widget.stockList![this.widget.index].email}",
                                              "${this.widget.stockList![this.widget.index].farmName}");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            "Email",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
            ],
          ),
        ),
      ),
    );
  }
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  _sendEmail(String email, String subject) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(
          <String, String>{'subject': 'Enquiry @ $subject'}),
    );

    launch(emailLaunchUri.toString());
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future<void> _launchInBrowser(String url) async {
    if(url.isEmpty){
      _displaySnackBar("No website associated with this farm");

    }
    else{
   if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        enableJavaScript: true,

        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
    }
 
  }

  _displaySnackBar(String message) {
    final snackBar = SnackBar(
      content: Text("$message"),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
