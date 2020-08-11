import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/services/apiservice.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:flutter_foodybite/screens/aroundmescreen.dart';
import 'package:flutter_foodybite/screens/cartview.dart';
import 'package:flutter_foodybite/screens/home.dart';
import 'package:flutter_foodybite/screens/mapscreen.dart';
import 'package:flutter_foodybite/screens/profiledetails.dart';
import 'package:flutter_foodybite/screens/profilescreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;
  GraphQLClientAPI _myService = locator<APIService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Home(),
          CartView(),
          MapsScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            IconButton(
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              color: _page == 0
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => _pageController.jumpToPage(0),
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 24.0,
              ),
              color: _page == 1
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CartView()));
                print("Cart View Clicked");
              },
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.add,
            //     size: 24.0,
            //     color: Theme.of(context).primaryColor,
            //   ),
            //   color: _page == 2
            //       ? Theme.of(context).accentColor
            //       : Theme.of(context).textTheme.caption.color,
            //   onPressed: () => _pageController.jumpToPage(2),
            // ),
            IconButton(
              icon: Icon(
                Icons.gps_fixed,
                size: 24.0,
              ),
              color: _page == 2
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => _pageController.jumpToPage(2),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              color: _page == 3
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => _pageController.jumpToPage(3),
            ),
            SizedBox(width: 7),
          ],
        ),
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //     elevation: 10.0,
      //     child: Icon(
      //       Icons.shopping_cart,
      //     ),
      //     // onPressed: () => _pageController.jumpToPage(2),
      //     onPressed: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //           builder: (BuildContext context) => CartView()));
      //       print("Cart View Clicked");
      //     }),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
      _myService.logSomething();
    });
  }
}
