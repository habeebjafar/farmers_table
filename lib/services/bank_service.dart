import 'package:farmerstable/repository/repository.dart';

class BankService{

  late Repository _repository;
  BankService(){
    _repository = Repository();
  }

  getAllBanks() async{
    return await _repository.httpget();
  }
}