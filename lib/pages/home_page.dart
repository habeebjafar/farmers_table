import 'package:farmerstable/bloc/farm_provider.dart';
import 'package:farmerstable/pages/create_account_page.dart';
import 'package:farmerstable/pages/milk_and_eggs.dart';
import 'package:farmerstable/pages/others_page.dart';
import 'package:farmerstable/pages/produce_page.dart';
import 'package:farmerstable/pages/profile_page.dart';
import 'package:farmerstable/widgets/stock_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'all_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController searchController = TextEditingController();
  bool enableSearch = false;
  PageController? pageController;
  int getPageIndex = 0;
  bool showDeleteButton = false;

  @override
  void initState() {
    super.initState();
    _getAllFarmersStocks();

    pageController = PageController();
  }

  _getAllFarmersStocks() async {
    await Provider.of<FarmProvider>(context, listen: false)
        .getAllFarmersStocks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffefefef),
              //centerTitle: true,
              // titleSpacing: 0.0,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 100,
              title: enableSearch
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      GestureDetector(
                        onTap: (){
                          Provider.of<FarmProvider>(context, listen: false)
                                  .filterSearchResults("");
                          setState(() {
                            searchController.clear();
                            showDeleteButton = false;
                            enableSearch = false;
                            
                          });

                        },
                        child: Icon(Icons.arrow_back,
                        color: Colors.orange,),
                      ),
                        
                        
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: searchController,
                            onChanged: (value) {
                             
                              Provider.of<FarmProvider>(context, listen: false)
                                  .filterSearchResults(value);
                                  setState(() {
                                    if(value.length > 0){
                                      showDeleteButton = true;

                                    }else{
                                      showDeleteButton = false;
                                    }
                                  });
                            },
                            cursorColor: Colors.orange,
                            //mcursorHeight: 30,
                            autofocus: true,

                            style: TextStyle(color: Colors.orange,),

                            decoration: InputDecoration(
                              //labelText: "Search",

                              hintText: "Search...",
                              border: InputBorder.none,

                              hintStyle: TextStyle(color: Colors.orange,),
                            ),
                          ),
                      ),

                        showDeleteButton ? IconButton(
                        onPressed: (){
                          Provider.of<FarmProvider>(context, listen: false)
                                  .filterSearchResults("");
                          setState(() {
                            searchController.clear();
                            showDeleteButton = false;
                            
                          });

                        }, 
                        icon: Icon(Icons.cancel_outlined),
                        color: Colors.orange,
                        ) : Container(),

                        
                    ],
                  ) :  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "01 Congress Ave, TX78701, USA",
                              style: TextStyle(color: Colors.black87, fontSize: 16),
                            ),
                              IconButton(
                      onPressed: () {
                        setState(() {
                          enableSearch = true;
                        });
                      },
                      icon: Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.green,
                      )),
                        ],
                      ),
                
                  
                
              bottom: PreferredSize(
                preferredSize: Size.zero,
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Colors.orange,
                    isScrollable: true,
                    //indicatorWeight: 10,
                    //indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.green,
                    tabs: [
                      Tab(
                        child: Text(
                          "ALL",
                          // style: TextStyle( color: Theme.of(context).primaryColor,),
                        ),
                      ),
                      Tab(
                        child: Text("BEEF"),
                      ),
                      Tab(
                        child: Text("CHICKEN"),
                      ),
                      Tab(
                        child: Text("PRODUCE"),
                      ),
                      Tab(
                        child: Text("MILK & EGGS"),
                      ),
                      Tab(
                        child: Text("SEAFOOD"),
                      ),
                      Tab(
                        child: Text("OTHER"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                AllPage(),
                StockWidget(stock: "Beef"),
                StockWidget(stock: "Chicken"),
                ProducePage(),
                MilkAndEggPage(),
                 StockWidget(stock: "Seafood"),
                OthersPage()
              ],
            ),
            bottomNavigationBar: CupertinoTabBar(
                currentIndex: getPageIndex,
                onTap: onTapChangePage,
                backgroundColor: Colors.white10,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.place),
                    label: "Nearby",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  )
                ])),
      ),
    );
  }

  onTapChangePage(int pageIndex) async{
    // pageController!.animateToPage(pageIndex,
    //     duration: Duration(milliseconds: 10), curve: Curves.bounceInOut);
   // setState(() {
     SharedPreferences pref = await SharedPreferences.getInstance();
     var loggedIn = pref.getBool("loggedIn");
      if (pageIndex == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (pageIndex == 1) {
        Navigator.push(context,

            MaterialPageRoute(builder: (context) => loggedIn == true ? ProfilePage() : CreateAccountPage()
            
            ));
      }
  //  });
  }
}
