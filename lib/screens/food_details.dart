import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/viewmodels/fooddetailsview.dart';
import 'package:flutter_foodybite/widgets/trending_item.dart';
import 'package:stacked/stacked.dart';

class FoodDetailsView extends StatelessWidget {
  final Food food;
  FoodDetailsView(this.food);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Details"),
      ),
      body: ViewModelBuilder<FoodDetailsViewModel>.reactive(
        viewModelBuilder: () => FoodDetailsViewModel(food),
        // onModelReady: () =>  giveFoodToViewModel(),
        builder: (context, model, child) => GestureDetector(
          // onTap: () => model.longUpdateStuff(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // This is the Item Info
                TrendingItem(
                  img: "${food.image}",
                  title: "${food.name}",
                  description: "${food.description}",
                  price: "${food.price}",
                  rating: "${food.price}",
                ),

                SizedBox(
                  height: 30,
                ),
                // This
                Container(
                    child: Text(
                  "${model.price}",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                )),

                SizedBox(
                  height: 10,
                ),
                // THis is the Buying Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        onTap: () => {model.decreaseQuantity()},
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.yellowAccent,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.remove,
                          ),
                        )),
                    Container(
                        child: Text(
                      "${model.quantity}",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )),
                    InkWell(
                        onTap: () => {model.increaseQuantity()},
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.yellowAccent,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.add,
                          ),
                        )),
                  ],
                ),

                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(20),
                  child: InkWell(
                      onTap: () => {model.addToOrder()},
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.rectangle),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add to Cart"),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.shopping_cart,
                                ),
                              ]))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}