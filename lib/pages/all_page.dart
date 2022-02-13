import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:farmerstable/pages/add_farm.dart';
import 'package:farmerstable/pages/create_account_page.dart';
import 'package:farmerstable/pages/product_details_page.dart';
import 'package:farmerstable/widgets/build_stock_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                var loggedIn = pref.getBool("loggedIn");

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => loggedIn == true
                            ? AddFarmPage()
                            : CreateAccountPage()));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                    child: Text(
                  "ADD YOUR FARM",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<FarmProvider>(
              builder: (_, provider, __) => provider.items.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Center(
                          child: Image.asset(
                        "assets/images/loading.gif",
                        width: 70,
                        height: 70,
                      )),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        provider.items
                            .sort((a, b) => a.distance!.compareTo(b.distance!));

                        return Card(
                          elevation: 10,
                          child: GestureDetector(
                            onTap: () {
                              //got to productdetails page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                          index: index,
                                          stockList: provider.items)));
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 16),
                              width: double.infinity,
                              // height: 350,
                              decoration: BoxDecoration(
                                  // color: Color(0xffad5240),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          child: Image.asset(
                                        "assets/images/profile.png",
                                        width: 30,
                                        height: 30,
                                      )
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${provider.items[index].farmName}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${provider.items[index].distance} miles away . ${provider.items[index].fullAdrees}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
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
                                      provider.items[index].deliveryMethod!
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      provider.items[index].deliveryMethod!
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      provider.items[index].deliveryMethod!
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Available Products"),
                                      Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  BuildStockList(
                                      stockList: provider
                                          .items[index].farmersStocksList),
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
                                              "${provider.items[index].phoneNumber}");
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
                                          if (provider.items[index].website!
                                              .isNotEmpty) {
                                            await _launchInBrowser(
                                                "${provider.items[index].website}");
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
                                              "${provider.items[index].email}",
                                              "${provider.items[index].farmName}");
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
                      }),
            )
          ],
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

  // Widget _buildBody(List? data) {
  //   //List data = ['biscuits', 'cakes', 'drinks', 'snacks', 'food'];

  //   return Container(
  //     //color: Colors.yellow[100],
  //     //height: 60,
  //     // width: 300,
  //     child: Wrap(
  //       direction: Axis.horizontal,
  //       children: data!.map((item) {
  //         return Padding(
  //             padding: const EdgeInsets.all(3.0),
  //             child: Column(
  //               children: [
  //                 CircleAvatar(
  //                   radius: 27,
  //                   backgroundColor: generateRandomColor2(),
  //                   child: Image.asset(
  //                     "assets/images/${item.toLowerCase()}.png",
  //                     width: 40,
  //                     height: 40,
  //                   ),
  //                 ),
  //                 Text(
  //                    item)
  //               ],
  //             ));

  //       }).toList(),
  //     ),
  //   );
  // }
}
