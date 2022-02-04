import 'dart:math';

import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:farmerstable/pages/product_details_page.dart';
import 'package:farmerstable/widgets/build_stock_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeafoodPage extends StatefulWidget {
  const SeafoodPage({ Key? key }) : super(key: key);

  @override
  _SeafoodPageState createState() => _SeafoodPageState();
}

class _SeafoodPageState extends State<SeafoodPage> {

    @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<FarmProvider>(
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

                      return provider.items[index].farmersStocks!
                              .contains("Seafood")
                          ? Card(
                              elevation: 10,
                              child: GestureDetector(
                                onTap: () {
                                  //got to productdetails page
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                                FontWeight
                                                                    .bold),
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
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                            onTap: () {},
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
                                          Container(
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
                                          Container(
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
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container();
                    }),
          )),
    );
  }
}