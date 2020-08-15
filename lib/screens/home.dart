import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/category.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/core/viewmodels/homeviewmodel.dart';
import 'package:flutter_foodybite/screens/allcategories.dart';
import 'package:flutter_foodybite/screens/allrestaurant.dart';
import 'package:flutter_foodybite/screens/categories_screen.dart';
import 'package:flutter_foodybite/screens/food_details.dart';
import 'package:flutter_foodybite/screens/restaurantsscreen.dart';
import 'package:flutter_foodybite/screens/trending.dart';
import 'package:flutter_foodybite/util/categories.dart';
import 'package:flutter_foodybite/util/friends.dart';
import 'package:flutter_foodybite/widgets/slide_item.dart';
import 'package:stacked/stacked.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        // onModelReady: () =>  ,
        builder: (context, model, child) => GestureDetector(
              // onTap: () => model.longUpdateStuff(),
              child: Scaffold(
                appBar: PreferredSize(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
                    child: Card(
                      elevation: 6.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: "Search..",
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            suffixIcon: Icon(
                              Icons.filter_list,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          maxLines: 1,
                          controller: _searchControl,
                        ),
                      ),
                    ),
                  ),
                  preferredSize: Size(
                    MediaQuery.of(context).size.width,
                    60.0,
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 20.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Trending",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              "See all (43)",
                              style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return Trending();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),

                      //Horizontal List here
                      Container(
                        height: MediaQuery.of(context).size.height / 2.1,
                        width: MediaQuery.of(context).size.width,
                        child: model.allFoods.length > 0
                            ? ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: model.allFoods.length == null
                                    ? 0
                                    : model.allFoods.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Food food = model.allFoods[index];
                                  print(food.name);

                                  return InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FoodDetailsView(food))),
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: SlideItem(
                                        img: food.image,
                                        title: food.name,
                                        price: food.price.toString(),
                                        description: food.description,
                                        rating: food.name,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text("No Foods"),
                              ),
                      ),

                      SizedBox(height: 10.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              "See all (9)",
                              style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return AllCategories();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),

                      //Horizontal List here
                      Container(
                        height: MediaQuery.of(context).size.height / 6,
                        child: ListView.builder(
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: model.allCategories == null
                              ? 0
                              : model.allCategories.length,
                          itemBuilder: (BuildContext context, int index) {
                            Category cat = model.allCategories[index];

                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CategoriesScreen(cat))),
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        cat.img,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            // Add one stop for each color. Stops should increase from 0 to 1
                                            stops: [0.2, 0.7],
                                            colors: [
                                              Color.fromARGB(100, 0, 0, 0),
                                              Color.fromARGB(100, 0, 0, 0),
                                            ],
                                            // stops: [0.0, 0.1],
                                          ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                      ),
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          padding: EdgeInsets.all(1),
                                          constraints: BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                          ),
                                          child: Center(
                                            child: Text(
                                              cat.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Restaurants",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              "See all (9)",
                              style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return AllRestaurant();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      //Horizontal List here
                      Container(
                        height: MediaQuery.of(context).size.height / 6,
                        child: ListView.builder(
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: model.allRestaurants == null
                              ? 0
                              : model.allRestaurants.length,
                          itemBuilder: (BuildContext context, int index) {
                            Restaurant res = model.allRestaurants[index];

                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RestaurantScreen(res))),
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        res.image,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            // Add one stop for each color. Stops should increase from 0 to 1
                                            stops: [0.2, 0.7],
                                            colors: [
                                              Color.fromARGB(100, 0, 0, 0),
                                              Color.fromARGB(100, 0, 0, 0),
                                            ],
                                            // stops: [0.0, 0.1],
                                          ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                      ),
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          padding: EdgeInsets.all(1),
                                          constraints: BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                          ),
                                          child: Center(
                                            child: Text(
                                              res.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

//                       SizedBox(height: 20.0),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             "Friends",
//                             style: TextStyle(
//                               fontSize: 23,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                           FlatButton(
//                             child: Text(
//                               "See all (59)",
//                               style: TextStyle(
// //                      fontSize: 22,
// //                      fontWeight: FontWeight.w800,
//                                 color: Theme.of(context).accentColor,
//                               ),
//                             ),
//                             onPressed: () {
// //                    Navigator.of(context).push(
// //                      MaterialPageRoute(
// //                        builder: (BuildContext context){
// //                          return DishesScreen();
// //                        },
// //                      ),
// //                    );
//                             },
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 10.0),

//                       Container(
//                         height: 50.0,
//                         child: ListView.builder(
//                           primary: false,
//                           scrollDirection: Axis.horizontal,
//                           shrinkWrap: true,
//                           itemCount: friends == null ? 0 : friends.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             String img = friends[index];

//                             return Padding(
//                               padding: EdgeInsets.only(right: 5.0),
//                               child: CircleAvatar(
//                                 backgroundImage: AssetImage(
//                                   img,
//                                 ),
//                                 radius: 25.0,
//                               ),
//                             );
//                           },
//                         ),
//                       ),

//                       SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
