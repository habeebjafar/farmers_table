class UsersModel{
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? password;


  toJson(){

    return{
       "name": this.name,
       "first_name": this.firstName,
       "last_name": this.lastName,
       "email": this.email,
       "password": this.password
    };
  }

  
  toJson2(){

    return{
       "email": this.email,
       "password": this.password
    };
  }
}