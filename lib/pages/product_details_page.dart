import 'package:farmerstable/models/farmers_stocks_model.dart';
import 'package:farmerstable/widgets/build_stock_list.dart';
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
  @override
  void initState() {
    super.initState();
  }

  // Color generateRandomColor2() {
  //   Random random = Random();
  //   // Pick a random number in the range [0.0, 1.0)
  //   double randomDouble = random.nextDouble();

  //   return Color((randomDouble * 0xFFFFFF).toInt()).withOpacity(1.0);
  // }

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
                  CircleAvatar(
                      child: Image.asset(
                    "assets/images/profile.png",
                    width: 30,
                    height: 30,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.stockList![widget.index].farmName}"),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.stockList![widget.index].distance} miles away . ${widget.stockList![widget.index].fullAdrees}",
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 1,
                          // softWrap: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.black26,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.black26,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.black26,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.black26,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.black26,
                  ),
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
              BuildStockList(
                stockList:
                    this.widget.stockList![this.widget.index].farmersStocksList,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall(
                          "${this.widget.stockList![this.widget.index].phoneNumber}");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5)),
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
                      if (this
                          .widget
                          .stockList![this.widget.index]
                          .website!
                          .isNotEmpty) {
                        await _launchInBrowser(
                            "${this.widget.stockList![this.widget.index].website}");
                      } else {
                        _displaySnackBar(
                            "No website associated with this farm");
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
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
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future<void> _launchInBrowser(String url) async {
    if (url.isEmpty) {
      _displaySnackBar("No website associated with this farm");
    } else {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          enableJavaScript: true,
        );
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _displaySnackBar(String message) {
    final snackBar = SnackBar(
      content: Text("$message"),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
