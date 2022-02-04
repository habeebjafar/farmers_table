import 'dart:convert';

import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:farmerstable/bloc/user_provider.dart';
import 'package:farmerstable/models/bank_model.dart';
import 'package:farmerstable/pages/home_page.dart';
import 'package:farmerstable/pages/test_page.dart';
import 'package:farmerstable/services/bank_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

ChangeNotifierProvider<FarmProvider>(
  create: (context) => FarmProvider(),
),

ChangeNotifierProvider<UserProvider>(
  create: (context) => UserProvider(),
)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
///  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BankService _bankService  = BankService();
  List<BankModel> bankList = [];

  @override
  void initState(){
    super.initState();
     _getAllNigeriaBanks();
  
  }


  _getAllNigeriaBanks() async{

    var response = await _bankService.getAllBanks();

    var result = await json.decode(response.body);
     //var result = json.decode(json.encode(response.body));
    print(result);

    result.forEach((data){
      
      setState(() {
        var model = BankModel();
        model.bankName = data['name'];
        model.ussdCode = data['ussd'];
        model.bankLogo = data['logo'];

        bankList.add(model);
      });

    });
     ///print("this is the bank list ${bankList[1]}");


  }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Nigeria Banks"),
      ),

      body: ListView.builder(
        itemCount: bankList.length ,
        itemBuilder: (BuildContext context, index){
          return ListTile(
            leading: Image.network("${bankList[index].bankLogo}"),
            title: Text("${bankList[index].bankName}"),
            trailing: Text("${bankList[index].ussdCode}"),
          );
        }
        )
    );
  }
}
