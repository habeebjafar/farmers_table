class FarmersStockModel{
  int? id;
  String? farmName;
  String? fullAdrees;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? website;
  String? deliveryMethod;
  String? farmersStocks;
  List<String>? farmersStocksList;
  String? marketSeller;
  String? latitude;
  String? longitude;
  int? distance;

  toJson(){

    return{
      if (id != null) "id": id.toString(),
      "farm_name": this.farmName.toString(),
      "full_address": this.fullAdrees.toString(),
      "first_name": this.firstName.toString(),
      "last_name": this.lastName.toString(),
      "phone_number": this.phoneNumber.toString(),
      "email": this.email.toString(),
      "website": this.website.toString(),
      "delivery_method": this.deliveryMethod.toString(),
      "farmers_stocks": this.farmersStocks.toString(),
      "market_seller": this.marketSeller.toString(),
      "latitude": this.latitude.toString(),
      "longitude": this.longitude.toString(),
      "distance": this.distance.toString()
    };

  }


}