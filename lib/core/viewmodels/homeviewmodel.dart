import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/services/foodservice.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/orderservice.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:flutter_foodybite/core/utils/constants.dart';
import 'package:flutter_foodybite/core/utils/httpdriver.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ChangeNotifier {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  final OrderService order = locator<OrderService>();
  List<Food> foods = [];
  // final InformationService _informationService = locator<InformationService>();

  @override
  // List<ReactiveServiceMixin> get reactiveServices => [_informationService];

  List<Food> get allFoods => foods;
  var getfoods = ''' 
  query{
  allProducts{
    name
    price
    image
    description
  }
}
  ''';

  HomeViewModel() {
    print("Home View Model is Working");

    getAllFoods();
  }

  longUpdateStuff() async {
    print("Calling a method");

    // var data = await HTTPDriver.loadFromHTTP(getfoods, '{}');
    // print(data);

    print(foods.toList());
    // print(dl.data[0]["name"]);
  }

  getAllFoods() async {
    QueryResult dl = await cl.query(
      QueryOptions(
        document: getfoods,
      ),
    );

    if (!dl.hasException) {
      print("has no error");
      print(dl.data);

      for (var item in dl.data['allProducts']) {
        print(item.data);
        // var foo = jsonDecode()
        foods.add(new Food(
            name: item.data['name'],
            price: item.data['price'].toDouble(),
            image: item.data['image'],
            description: item.data['description']));
        notifyListeners();
      }
    }
  }

  proceedOrder() {
    order.sendOrder();
    print("sending order called");
  }
}

// class Food {
//   final String name;
//   final double price;
//   final String image;
//   final String description;

//   Food({this.name, this.price, this.image, this.description});
// }
