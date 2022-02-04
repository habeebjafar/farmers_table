import 'package:farmerstable/models/users_model.dart';
import 'package:farmerstable/repository/repository.dart';

class UserService{
  
  late Repository _repository;

  UserService(){
    _repository = Repository();
  }

  createUser(UsersModel model) async{

    return await _repository.httpPost("register-user", model.toJson());
  }

  
   login(UsersModel user) async {
    return await _repository.httpPost('login', user.toJson2());
  }



}