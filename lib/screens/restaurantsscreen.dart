import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/category.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/core/viewmodels/homeviewmodel.dart';
import 'package:flutter_foodybite/screens/food_details.dart';
import 'package:flutter_foodybite/widgets/trending_item.dart';
import 'package:stacked/stacked.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  RestaurantScreen(this.restaurant);
  @override
  RestaurantScreenState createState() => RestaurantScreenState();
}

class RestaurantScreenState extends State<RestaurantScreen> {
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
                  title: Text("${widget.restaurant.name}"),
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
                        itemCount: widget.restaurant.foods == null
                            ? 0
                            : widget.restaurant.foods.length,
                        itemBuilder: (BuildContext context, int index) {
                          Food food = widget.restaurant.foods[index];
                          print("Item List is ${model.allFoods.length}");

                          print("category ${food.name}  match");
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FoodDetailsView(food))),
                            child: TrendingItem(
                              img: food.image,
                              title: food.name,
                              price: food.price.toString(),
                              rating: food.name,
                              description: food.description,
                            ),
                          );
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
