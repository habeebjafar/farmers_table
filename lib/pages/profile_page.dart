import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  String? ftName;
  String? ltName;
 

  @override
  void initState() {

     super.initState();

     _getPref();
   
   
  }

    _getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var loginDetails = pref.getStringList("loginDetails");
    setState(() {
      if (loginDetails != null) {

        ftName  = loginDetails[0];
        ltName = loginDetails[1];
       
        
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        actions: [
          GestureDetector(
              onTap: () {
                _showDialog();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.settings),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        "assets/images/profile.png",
                        width: 50,
                        height: 50,
                      )
                      ),
                  Column(
                    children: [
                      Text(
                        "0",
                      ),
                      Text("Reviews")
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$ftName $ltName")
            ],
          ),
        ),
      ),
    );
  }

  _showDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 110,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Share.share(''' 

                    A powerful app for livestock farming. Track cattle, events, milk production and revenue. \n\n

Click on the Link below to download it from App Store. \n\n

https://apps.apple.com/us/app/track-my-brand/id1597499479
                   
                    
                    ''', 
                    subject: 'The Brand Marketing');
                    },
                    child: Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        //pref.getBool("loggedIn");
                        pref.remove("loggedIn");
                        pref.remove("loginDetails");
                        pref.clear();
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (_) => false);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                      ))
                ],
              ),
            ),
          );
        });
  }
}
