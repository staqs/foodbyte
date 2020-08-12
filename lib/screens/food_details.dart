import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
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
              children: <Widget>[
                // This is the Item Info
                TrendingItem(
                  img: "${food.image}",
                  title: "${food.name}",
                  description: "${food.description}",
                  price: "${food.price}",
                  rating: "${food.price}",
                ),

                Text(
                    "You Are Buyin From ${model.asso.name}, Choose another Restaurant to Update"),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  // width: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: model.associated.length,
                      itemBuilder: (context, index) {
                        // return buildChip(context, model, index);
                        Restaurant res = model.associated[index];

                        return ActionChip(
                            avatar: CircleAvatar(
                              backgroundColor: Colors.grey.shade800,
                              child: Text("${res.name.substring(0, 1)}"),
                            ),
                            label: Text("${res.name}"),
                            onPressed: () {
                              print("Update model");
                              model.updateAssociated(res);
                            });
                      }),
                ),

                SizedBox(
                  height: 30,
                ),
                // This
                Container(
                    child: Text(
                  "GH ${model.price}",
                  style: TextStyle(color: Colors.black, fontSize: 30.0),
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
                              color: Colors.black, shape: BoxShape.circle),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        )),
                    Container(
                        child: Text(
                      "${model.quantity}",
                      style: TextStyle(color: Colors.black, fontSize: 40.0),
                    )),
                    InkWell(
                        onTap: () => {model.increaseQuantity()},
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),

                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(20),
                  child: InkWell(
                      onTap: () {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Added  ${food.name} to cart"),
                        ));

                        model.addToOrder();
                      },
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.black,
                              shape: BoxShape.rectangle),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
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

buildChip(BuildContext context, FoodDetailsViewModel model, int index) {
  Restaurant res = model.associated[index];
  print(res.name);
  return ActionChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: Text("${res.name.substring(0, 1)}"),
      ),
      label: Text("${res.name}"),
      onPressed: () {
        print("Update model");
      });
}
