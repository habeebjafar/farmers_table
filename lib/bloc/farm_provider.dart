import 'dart:convert';

import 'package:farmerstable/models/farmers_stocks_model.dart';
import 'package:farmerstable/services/farmers_stocks_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:permission_handler/permission_handler.dart';

class FarmProvider with ChangeNotifier {

//   checkPermission() async{
//     if (await Permission.location.request().isGranted) {
//   // Either the permission was already granted before or the user just granted it.
// }
// if (await Permission.location.isPermanentlyDenied) {
//   openAppSettings();
// }
// if (await Permission.location.isDenied) {
//    Permission.location.request();
//   // Either the permission was already granted before or the user just granted it.
  
// }
//   }
List<FarmersStockModel> items = [];
//List<FarmersStockModel> duplicateItems  = [];
bool? noDataFound;



  

 bool  isFarmAdded = false;

  FarmersStocksService _service = FarmersStocksService();
  List<FarmersStockModel> farmersStocksList = [];
  List<FarmersStockModel> beefList = [];
  List<FarmersStockModel> chickenList = [];
  List<FarmersStockModel> produceList = [];
  List<FarmersStockModel> fruitsList = [];
  List<FarmersStockModel> vegetablesList = [];
  List<FarmersStockModel> milkAndEggsList = [];
  List<FarmersStockModel> milkList = [];
  List<FarmersStockModel> eggsList = [];
  List<FarmersStockModel> seafoodList = [];
  List<FarmersStockModel> bisonList = [];
  List<FarmersStockModel> duckList = [];
  List<FarmersStockModel> elkList = [];
  List<FarmersStockModel> gooseList = [];
  List<FarmersStockModel> lambList = [];
  List<FarmersStockModel> rabbitList = [];
  List<FarmersStockModel> turkeyList = [];
  List<FarmersStockModel> honeyList = [];
  

  List animals = [];
  List deliveryMethods = [];
  bool marketSellerValue = false;

  Future<bool> saveFarmersStocks(
      farmName,
      fullAddress,
      firstName,
      lastName,
      phoneNumber,
      email,
      website,
      ) async {
         List<Location> locations = await locationFromAddress(fullAddress);
         
              //Location newLoc = locations[0];
    String deliveryMethod = deliveryMethods.toString();
    String farmersStocks = animals.toString();

    var model = FarmersStockModel();
    model.farmName = farmName;
    model.fullAdrees = fullAddress;
    model.firstName = firstName;
    model.lastName = lastName;
    model.phoneNumber = phoneNumber;
    model.email = email;
    model.website = website;
    model.deliveryMethod = deliveryMethod;
    model.farmersStocks = farmersStocks;
    model.marketSeller = "1";
    model.latitude = locations[0].latitude.toString();
    model.longitude = locations[0].longitude.toString();
    model.distance = _getDistance(locations[0].latitude, locations[0].longitude);

    var response = await _service.addFarmersStocks(model);
    var result = json.decode(response.body);
     //var result = await json.decode(json.encode(response.body));  

    notifyListeners();

    if (result['result'] == "successful") {
      print("for success $result");
      isFarmAdded = true;
      return true;
    }
     print("for failed attempt $result");
    return false;
  }

   _getCurrentPositionofUsers() async{
     LocationPermission permission = await Geolocator.checkPermission();
    
     await _geCurrentGeoLocationPosition();
      if(permission !=  LocationPermission.denied){
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
    
  }



  Future<List<FarmersStockModel>> getAllFarmersStocks() async {

     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
     LocationPermission permissionEnabled = await Geolocator.requestPermission();
     
      Position? position; 
     if(serviceEnabled){
     position = await _getCurrentPositionofUsers();
     }
   
    //double distanceInMeters = Geolocator.distanceBetween(position.latitude, position.longitude, farmLat, farmLog);
    // double userDistanceInMiles = distanceInMeters/1609.344;
    items.clear();
    farmersStocksList.clear();
    beefList.clear();
    chickenList.clear();
    chickenList.clear();
    produceList.clear();
    fruitsList.clear();
    vegetablesList.clear();
    milkAndEggsList.clear();
    milkList.clear();
    eggsList.clear();
    seafoodList.clear();
    bisonList.clear();
    duckList.clear();
    elkList.clear();
    gooseList.clear();
    lambList.clear();
    rabbitList.clear();
    turkeyList.clear();
    honeyList.clear();

   
    var response = await _service.getAllFarmersStocks();
    //var result = await json.decode(json.encode(response.body));  

    var result = await json.decode(response.body);  
    print("hello print thsis $result");
  

    result['data'].forEach((data) {
      var model = FarmersStockModel();
      model.id = data['id'];
      model.farmName = data['farm_name'];
      model.fullAdrees = data['full_address'];
      model.firstName = data['first_name'];
      model.lastName = data['last_name'];
      model.phoneNumber = data['phone_number'];
      model.email = data['email'];
      model.website = data['website'];
      model.deliveryMethod = data['delivery_method'];
      model.farmersStocks = data['farmers_stocks'];
      model.marketSeller = data['market_seller'];
      model.latitude = data['latitude'];
      model.longitude = data['longitude'];
      model.distance = permissionEnabled != LocationPermission.denied &&  serviceEnabled ? (Geolocator.distanceBetween(position!.latitude, position.longitude, double.parse(data['latitude']), 
         double.parse(data['longitude']))/1609.344).floor() :
      double.parse(data['distance']).floor();

       var farmersStocks = model.farmersStocks!.substring(1, model.farmersStocks!.length - 1);

       var realFarmersStocksList = farmersStocks.split(', ');
       
       model.farmersStocksList = realFarmersStocksList;

      farmersStocksList.add(model);

      if(model.farmersStocks!.contains("Beef")){
        beefList.add(model);

      }

      if(model.farmersStocks!.contains("Chicken")){
        chickenList.add(model);

      }

       if(model.farmersStocks!.contains("Fruits") && model.farmersStocks!.contains("Vegetables")){
        produceList.add(model);

      }

       if(model.farmersStocks!.contains("Fruits")){
        fruitsList.add(model);

      }

       if(model.farmersStocks!.contains("Vegetables")){
        vegetablesList.add(model);

      }

       if(model.farmersStocks!.contains("Dairy") && model.farmersStocks!.contains("Eggs")){
        milkAndEggsList.add(model);

      }

       if(model.farmersStocks!.contains("Dairy")){
        milkList.add(model);

      }

       if(model.farmersStocks!.contains("Eggs")){
        eggsList.add(model);

      }

       if(model.farmersStocks!.contains("Seafood")){
        seafoodList.add(model);

      }

       if(model.farmersStocks!.contains("Bison")){
        bisonList.add(model);

      }

       if(model.farmersStocks!.contains("Duck")){
        duckList.add(model);

      }

       if(model.farmersStocks!.contains("Elk")){
        elkList.add(model);

      }

       if(model.farmersStocks!.contains("Goose")){
        gooseList.add(model);

      }

       if(model.farmersStocks!.contains("Lamb")){
        lambList.add(model);

      }

       if(model.farmersStocks!.contains("Rabbit")){
        rabbitList.add(model);

      }

       if(model.farmersStocks!.contains("Turkey")){
        turkeyList.add(model);

      }

       if(model.farmersStocks!.contains("Honey")){
        honeyList.add(model);

      }

      

    });

    farmersStocksList.sort((a,b) => a.distance!.compareTo(b.distance!));
    beefList.sort((a,b) => a.distance!.compareTo(b.distance!));
    chickenList.sort((a,b) => a.distance!.compareTo(b.distance!));
    produceList.sort((a,b) => a.distance!.compareTo(b.distance!));
    fruitsList.sort((a,b) => a.distance!.compareTo(b.distance!));
    vegetablesList.sort((a,b) => a.distance!.compareTo(b.distance!));
    milkAndEggsList.sort((a,b) => a.distance!.compareTo(b.distance!));
    milkList.sort((a,b) => a.distance!.compareTo(b.distance!));
    eggsList.sort((a,b) => a.distance!.compareTo(b.distance!));
    seafoodList.sort((a,b) => a.distance!.compareTo(b.distance!));
    bisonList.sort((a,b) => a.distance!.compareTo(b.distance!));
    duckList.sort((a,b) => a.distance!.compareTo(b.distance!));
    elkList.sort((a,b) => a.distance!.compareTo(b.distance!));
    gooseList.sort((a,b) => a.distance!.compareTo(b.distance!));
    lambList.sort((a,b) => a.distance!.compareTo(b.distance!));
    rabbitList.sort((a,b) => a.distance!.compareTo(b.distance!));
    turkeyList.sort((a,b) => a.distance!.compareTo(b.distance!));
    honeyList.sort((a,b) => a.distance!.compareTo(b.distance!));

    
     items.addAll(farmersStocksList);

     //!serviceEnabled ? distance : _getUserCurrentDistance(data['latitude'], data['longitude']) ;

    //farmersStocksList.sort((a,b) => a.distance!.compareTo(b.distance!));

   

    notifyListeners();

    return farmersStocksList;
  }

  int _getDistance(double farmLat, double farmLog){
    double distanceInMeters = Geolocator.distanceBetween(40.6180343, -103.2277387, farmLat, farmLog);
     double userDistanceInMiles = distanceInMeters/1609.344;
    return userDistanceInMiles.toInt();
  }


  //  _getUserCurrentDistance(double farmLat, double farmLog) async{
     
   
  //   Position? position = await _geCurrentGeoLocationPosition();
  //   double distanceInMeters = Geolocator.distanceBetween(position!.latitude, position.longitude, farmLat, farmLog);
  //    double userDistanceInMiles = distanceInMeters/1609.344;
  //   return userDistanceInMiles.ceil();
  //   //return userDistanceInMiles.toString();


  // }

   Future<void> _geCurrentGeoLocationPosition() async {
   // bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled don't continue
    //   // accessing the position and request users of the
    //   // App to enable the location services.
    //   await Geolocator.openLocationSettings();
    //   return Future.error('Location services are disabled.');
    // }
  

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        //return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Geolocator.openLocationSettings();
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.


    //return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


   void filterSearchResults(String query) {
    List<FarmersStockModel> dummySearchList = [];
    dummySearchList.addAll(farmersStocksList);
    if(query.isNotEmpty) {
      List<FarmersStockModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.fullAdrees.toString().toLowerCase().contains(query) ||
         item.farmName.toString().toLowerCase().contains(query) ) {
          dummyListData.add(item);
        }
      });
     
        items.clear();
        items.addAll(dummyListData);
        if(items.length == 0 ){
          noDataFound = true;
        }else{
          noDataFound = false;
        }

        notifyListeners();
    
      return;
    } else {
      
        items.clear();
        items.addAll(farmersStocksList);
        if(items.length == 0 ){
          noDataFound = true;
        }else{
          noDataFound = false;
        }
     notifyListeners();
    }

    notifyListeners();

  }



}
