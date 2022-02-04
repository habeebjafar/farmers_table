import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:farmerstable/pages/product_details_page.dart';
import 'package:farmerstable/widgets/build_stock_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StockWidget extends StatefulWidget {
  final stock;
  const StockWidget({Key? key, this.stock}) : super(key: key);

  @override
  _StockWidgetState createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  
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
                              .contains(this.widget.stock)
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
                                          stockList: provider.items[index].farmersStocksList),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _makePhoneCall("${provider.items[index].phoneNumber}");
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
                                             
                                            onTap: () async{
                                              

                                             
                                              if(provider.items[index].website!.isNotEmpty){
                                                 await  _launchInBrowser("${provider.items[index].website}");

                                              } else{
                                                _displaySnackBar("No website associated with this farm");

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
                                            onTap: (){
                                              _sendEmail("${provider.items[index].email}", "${provider.items[index].farmName}");
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
                            )
                          : Container();
                    }),
          )),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

  _sendEmail(String email, String subject){
   final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: email,
  query: encodeQueryParameters(<String, String>{
    'subject': 'Enquiry @ $subject'
  }),
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

    _displaySnackBar(String message){

     final snackBar = SnackBar(
      content:  Text("$message"),
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


  //  Future<void> _sendEmail(String email) async {
  //   // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
  //   // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
  //   // such as spaces in the input, which would cause `launch` to fail on some
  //   // platforms.
  //   final Uri launchUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //   );
  //   await launch(launchUri.toString());
  // }

//   final TextEditingController address = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//    // _determinePosition();
//    testApi();
//   }

//   testApi() async{
//     var url = "http://192.168.43.95:9000/api/get-all-farmers-stocks";
//     var response = await http.get(Uri.parse(url));
//     print(response.body);
//   }

//     String location ='Null, Press Button';
//   String locAddress = 'search';

//   Future<Position> _geCurrentGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }

//   Future<void> getAddressFromLatLong(Position position)async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     locAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     setState(()  {
//     });
//   }

//   _getDistance(double userLat, double userLog, double farmLat, double farmLog){
//     double distanceInMeters = Geolocator.distanceBetween(userLat, userLog, farmLat, farmLog);
//     return distanceInMeters;
//   }

// //   Future<Position> _determinePosition() async {
// //   bool serviceEnabled;
// //   LocationPermission permission;

// //   // Test if location services are enabled.
// //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //   if (!serviceEnabled) {
// //     // Location services are not enabled don't continue
// //     // accessing the position and request users of the
// //     // App to enable the location services.
// //     return Future.error('Location services are disabled.');
// //   }

// //   permission = await Geolocator.checkPermission();
// //   if (permission == LocationPermission.denied) {
// //     permission = await Geolocator.requestPermission();
// //     if (permission == LocationPermission.denied) {
// //       // Permissions are denied, next time you could try
// //       // requesting permissions again (this is also where
// //       // Android's shouldShowRequestPermissionRationale
// //       // returned true. According to Android guidelines
// //       // your App should show an explanatory UI now.
// //       return Future.error('Location permissions are denied');
// //     }
// //   }

// //   if (permission == LocationPermission.deniedForever) {
// //     // Permissions are denied forever, handle appropriately.
// //     return Future.error(
// //       'Location permissions are permanently denied, we cannot request permissions.');
// //   }

// //   // When we reach here, permissions are granted and we can
// //   // continue accessing the position of the device.
// //   return await Geolocator.getCurrentPosition();
// // }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             child: Text("BeefPage"),
//           ),
//           TextFormField(
//             controller: address,
//           ),
//           TextButton(

//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
//             ),
//             onPressed: () async{
//               var newAdd = address.text;

//               List<Location> locations = await locationFromAddress(newAdd);
//               Location newLoc = locations[0];
//               var newPositions ='Positions: ${newLoc.latitude} , Long: ${newLoc.longitude}';
//               print(newPositions);

//              print("$newAdd . $locations");

//               List<Placemark> placemarks = await placemarkFromCoordinates(newLoc.latitude, newLoc.longitude);

//                print("get address $placemarks");

//             },
//             child: Text("Get location"),

//             ),

//             SizedBox(height: 15,),

//             Text('Coordinates Points',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//             SizedBox(height: 10,),
//             Text(location,style: TextStyle(color: Colors.black,fontSize: 16),),
//             SizedBox(height: 10,),
//             Text('ADDRESS',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//             SizedBox(height: 10,),
//             Text('$locAddress'),
//             ElevatedButton(onPressed: () async{
//               var newAdd = address.text;
//               List<Location> locations = await locationFromAddress(newAdd);
//               Location newLoc = locations[0];

//               Position position = await _geCurrentGeoLocationPosition();
//               location ='Lat: ${position.latitude} , Long: ${position.longitude}';
//               double userDistance = _getDistance(position.latitude, position.longitude, newLoc.latitude, newLoc.longitude);
//               double userDistanceInMiles = userDistance/1609.344;
//               print("this is the distance in metres $userDistance");
//               print("this is the distance in miles $userDistanceInMiles");
//               getAddressFromLatLong(position);
//             },
//              child: Text('Get Location'))
//         ],
//       ),
//     );
//   }
}

//501 Congress Ave, Austin, TX 78701, USA
