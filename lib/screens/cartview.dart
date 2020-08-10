import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/order.dart';
import 'package:flutter_foodybite/core/viewmodels/cartviewmodel.dart';
import 'package:flutter_foodybite/screens/food_details.dart';
import 'package:flutter_foodybite/widgets/cartwidget.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => CartViewModel(),
      // onModelReady: () =>  ,
      builder: (context, model, child) => GestureDetector(
          // onTap: () => model.longUpdateStuff(),
          child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Your Cart GH${model.totalPrice.toString()}"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: model.allOrders.length > 0
              ? ListView(
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
                      itemCount: model.allOrders.length == null
                          ? 0
                          : model.allOrders.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Food food = model.allOrders[index];
                        Order order = model.allOrders[index];
                        Food food = model.getFoodFromOrderId(order.foodId);
                        print(order.foodId);
                        print("Food");
                        if (food != null) {
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FoodDetailsView(food))),
                            child: CartWidget(
                              img: food.image,
                              title: "${food.name}  GH${food.price.toString()}",
                              price: "quantity : ${order.quantity}",
                              rating: food.name,
                            ),
                          );
                        }

                        return Container();
                      },
                    ),
                    SizedBox(height: 10.0),
                  ],
                )
              : Center(
                  child: Container(
                      child: Text(
                  "You Have No Items",
                  style: TextStyle(fontSize: 20),
                ))),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: InkWell(
              onTap: () {
                model.allOrders.length > 0
                    ? showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Send Order'),
                              content:
                                  Text('Are you sure you want to checkout ?'),
                              actions: <Widget>[
                                RaisedButton(
                                    onPressed: () {
                                      model.proceedOrder();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Yes')),
                                RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No')),
                              ],
                            ))
                    : showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Cart'),
                              content: Text('You have nothing in your cart'),
                            ));
              },
              child: Container(
                alignment: Alignment.center,
                // color: Colors.black87,
                // decoration: BoxDecoration(
                //     color: Colors.yellowAccent, shape: BoxShape.rectangle),
                height: 60,
                child: Text(
                  "Proceed To Buy",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      )),
    );
  }
}
