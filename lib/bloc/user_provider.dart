import 'dart:convert';

import 'package:farmerstable/models/users_model.dart';
import 'package:farmerstable/services/users_service.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{

   UserService _service = UserService();


Future<dynamic> createUser(firstName, lastName, email, password) async{

  var model = UsersModel();
  model.firstName = firstName;
  model.lastName = lastName;
   model.name = model.firstName! + " " + model.lastName!;
  model.email = email;
  model.password = password;

  var response = await _service.createUser(model);
  // var result = json.decode(json.encode(response.body));
  var result = json.decode(response.body);

  return result;

  // print("json result $result");

  // notifyListeners();

  // if(result['result'] == true){

  //   print("Logged in");
  //   return true;

  // }

  //    print("error logging");
  //    return false;

}

Future<dynamic> login(email, password) async{

  var model = UsersModel();
  model.email = email;
  model.password = password;

  var response = await _service.login(model);
  // var result = json.decode(json.encode(response.body));
  var result = json.decode(response.body);

  return result;

 
}

}