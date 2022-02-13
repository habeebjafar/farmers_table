import 'package:farmerstable/bloc/user_provider.dart';
import 'package:farmerstable/pages/add_farm.dart';
import 'package:farmerstable/pages/login_page.dart';
import 'package:farmerstable/widgets/progressHUD.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


//import '../api_service.dart';

class CreateAccountPage extends StatefulWidget {


  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  late TapGestureRecognizer _gestureRecognizer, _gestureRecognizerTerms;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
   GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  late String firstName;
  late String lastName;
  late String email;
  late String password;

  bool termsChecked = false;
  String termsText = "";
 // APIService apiService;



    _displaySnackBar(String message){

      
     final snackBar = SnackBar(
      content:  Text("$message"),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


    }
    

  
  @override
  void initState() {
    //apiService = new APIService();
    super.initState();
    _gestureRecognizer = TapGestureRecognizer()
    ..onTap = _handleTap;
    _gestureRecognizerTerms = TapGestureRecognizer()
    ..onTap = _handleTapTerms;

  }

    @override
  void dispose() {
    _gestureRecognizer.dispose();
    _gestureRecognizerTerms.dispose();
    super.dispose();
  }

  void _handleTapTerms() async{
_launchInBrowser("https://habeebjafar.github.io/cattle_privacy_policy.html");
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
       // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleTap(){
    Navigator.push(context,
     MaterialPageRoute(builder: (context) => LoginPage()));

  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      isAsyncCall: isApiCallProcess,
      opacity: 0.3, key: globalKey2 ,
      
      
    );
  }

  Widget _uiSetup(BuildContext context){

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 20
                      )
                    ]
                  ),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Text(
                          "Create Account",
                          style: Theme.of(context).textTheme.headline4,
                          ),

                          SizedBox(height: 20,),

                          new TextFormField(
                            keyboardType: TextInputType.name,
                            onSaved: (input) => firstName = input!,
                            validator: (input) => input!.length < 1 ?
                            "Name must not be empty" : null,

                            decoration: new InputDecoration(
                              hintText: "First name",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                                )

                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  
                                ),
                                
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ),
                          ),

                          SizedBox(height: 20,),

                                           new TextFormField(
                            keyboardType: TextInputType.name,
                            onSaved: (input) => lastName = input!,
                            validator: (input) => input!.length < 1 ?
                            "Name must not be empty" : null,

                            decoration: new InputDecoration(
                              hintText: "Last name",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                                )

                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  
                                ),
                                
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ),
                          ),

                          SizedBox(height: 20,),

                                           new TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => email = input!,
                            validator: (input) => !input!.contains('@') ?
                            "Email Id should be valid" : null,

                            decoration: new InputDecoration(
                              hintText: "Email Address",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                                )

                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  
                                ),
                                
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ),
                          ),

                          SizedBox(height: 20,),

                           new TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => password = input!,
                            validator: (input) => input!.length < 3 ?
                            "Password should be more 3 character" : null,

                            obscureText: hidePassword,

                            decoration: new InputDecoration(
                              hintText: "Password",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                                )

                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  
                                ),
                                
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).colorScheme.secondary,
                              ), 
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword ? Icons.visibility_off : Icons.visibility
                                ), 
                              onPressed: (){
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                              )
                            ),
                          ),

                          SizedBox(height: 15,),

                          Row(
                            children: [
                              Checkbox(value: termsChecked, onChanged: (value){
                                setState(() {
                                  termsChecked = value!;
                                });

                              }
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Accept ",
                                   style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  children: [
                                    TextSpan(
                                      text: "Terms and User Agreement",
                                       style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                    recognizer: _gestureRecognizerTerms
                                    )
                                  ]
                                ),
                                
                              )
                            ],
                          ),
                          !termsChecked ? Text(termsText,
                          style: TextStyle(fontSize: 13,
                          color: Colors.red),
                          ):SizedBox(),

                          FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                            onPressed: () async{

                              if(!termsChecked){
                                setState(() {
                                  termsText = "Please accept terms and users agreement";
                                });

                              }else{
                                setState(() {
                                  termsText = " ";
                                });
                              }

                              if(validateAndSave()){

                                setState(() {
                                  isApiCallProcess = true;
                                });
                                var response = Provider.of<UserProvider>(context, listen: false);
                               var result = await response.createUser(firstName, lastName, email, password);
                               if(result['result'] == 'duplicated'){
                                 
                                 setState(() {
                                  isApiCallProcess = false;
                                });
                                _displaySnackBar("This email is already registered, please try to login");
                                
                                
                               }else if(result['result'] == true){
                                 
                                  setState(() {
                                  isApiCallProcess = false;
                                });
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setBool("loggedIn", true);
                                pref.setStringList("loginDetails", [firstName, lastName, email]);
                                _registeredDialog();

                               }else{
                                 
                                  setState(() {
                                  isApiCallProcess = false;
                                });
                                _displaySnackBar("Oop! something went wrong");
                               }
                                // await apiService.loginCustomer(username, password).then(
                                //   (ret){
                                //     if(ret != null ){
                                      
                                //         setState(() {
                                //   isApiCallProcess = false;
                                // });
                                //      FormHelper.showMessage(
                                //        context, 
                                //        "WooCommerce App",
                                //         "Login successful",
                                //         "OK",
                                //          (){Navigator.of(context).pop();
                                //          }

                                //          );
                                //     } else{
                                      
                                //      FormHelper.showMessage(
                                //        context, 
                                //        "WooCommerce App",
                                //         "Invalid login",
                                //         "OK",
                                //          (){Navigator.of(context).pop();
                                //          }

                                //          );
                                //     }
                                //   }
                                //   );

                              }
                            }, 
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                            shape: StadiumBorder(),
                            ),
                            RichText(
                              softWrap: true,
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.black
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                    recognizer: _gestureRecognizer
                                  )
                                ]
                              ),

                            ),
                            SizedBox(height: 15,)

                      ],
                    )
                    ),
                )
              ],
            )
          ],
        ),
      ),
    );

  }

      bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate() && termsChecked) {
      form.save();
      return true;
    }
    return false;
  }


  _registeredDialog(){
    return showDialog(
      context: context,
      barrierDismissible: false,
       builder: (BuildContext context){
         return AlertDialog(

           title: Text("Successfully registered"),
           content: Text("Your account has been successfully registered, you can now go ahead to add your farm"),
           actions: [
             ElevatedButton(
               onPressed: (){
                 Navigator.pop(context);
                 Navigator.pushReplacement(
                   context, 
                   MaterialPageRoute(builder: (context) => AddFarmPage())
                   );
               },
                child: Text("OK")
                )
           ],

         );
       }
       );
  }


}