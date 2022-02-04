import 'package:farmerstable/models/farmers_stocks_model.dart';
import 'package:farmerstable/repository/repository.dart';

class FarmersStocksService{

late Repository _repository;

FarmersStocksService(){
  _repository = Repository();

}

getAllFarmersStocks() async{

  return await _repository.httpGet("get-all-farmers-stocks");

}

addFarmersStocks(FarmersStockModel model) async{

  return await _repository.httpPost("add-to-farmers-stocks", model.toJson());
}


}