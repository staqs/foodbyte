import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/category.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/core/viewmodels/homeviewmodel.dart';
import 'package:flutter_foodybite/util/categories.dart';
import 'package:flutter_foodybite/widgets/categorylistitem.dart';
import 'package:flutter_foodybite/widgets/restaurantItem.dart';
import 'package:stacked/stacked.dart';

class AllRestaurant extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<AllRestaurant> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        // onModelReady: () =>  ,
        builder: (context, model, child) => GestureDetector(
              // onTap: () => model.longUpdateStuff(),
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text("All Categories"),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: ListView(
                    children: <Widget>[
                      Card(
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
                      SizedBox(height: 10.0),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.allRestaurants == null
                            ? 0
                            : model.allRestaurants.length,
                        itemBuilder: (BuildContext context, int index) {
                          Restaurant food = model.allRestaurants[index];

                          return Container(
                              margin: EdgeInsets.all(10),
                              child: RestaurantItem(cat: food));
                        },
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ));
  }
}
