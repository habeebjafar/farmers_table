import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class TestPage extends StatefulWidget {
  
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  

  
  final TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();
   // _determinePosition();
 //  testApi();
  }

  // testApi() async{
  //   var url = "http://192.168.43.95:9000/api/get-all-farmers-stocks";
  //   var response = await http.get(Uri.parse(url));
  //   print(response.body);
  // }

    String location ='Null, Press Button';
  String locAddress = 'search';

  Future<Position> _geCurrentGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    locAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }

  _getDistance(double userLat, double userLog, double farmLat, double farmLog){
    double distanceInMeters = Geolocator.distanceBetween(userLat, userLog, farmLat, farmLog);
    return distanceInMeters;
  }

//   Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition();
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text("BeefPage"),
            ),
            TextFormField(
              controller: address,
            ),
            TextButton(
    
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
              ),
              onPressed: () async{
                var newAdd = address.text;
    
                List<Location> locations = await locationFromAddress(newAdd);
                Location newLoc = locations[0];
                var newPositions ='Positions: ${newLoc.latitude} , Long: ${newLoc.longitude}';
                print(newPositions);
    
               print("$newAdd . $locations");
    
                List<Placemark> placemarks = await placemarkFromCoordinates(newLoc.latitude, newLoc.longitude);
    
                 print("get address $placemarks");
    
              },
              child: Text("Get location"),
    
              ),
    
              SizedBox(height: 15,),
    
              Text('Coordinates Points',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(location,style: TextStyle(color: Colors.black,fontSize: 16),),
              SizedBox(height: 10,),
              Text('ADDRESS',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('$locAddress'),
              
              ElevatedButton(onPressed: () async{
                var newAdd = address.text;
                List<Location> locations = await locationFromAddress(newAdd);
                Location newLoc = locations[0];
    
                Position position = await _geCurrentGeoLocationPosition();
                location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                double userDistance = _getDistance(position.latitude, position.longitude, newLoc.latitude, newLoc.longitude);
                double userDistanceInMiles = userDistance/1609.344;
                print("this is the distance in metres $userDistance");
                print("this is the distance in miles $userDistanceInMiles");
                await getAddressFromLatLong(position);
              },
               child: Text('Get Location'))
          ],
        ),
      ),
    );
  }



  


}
