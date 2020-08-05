import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/services/foodservice.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:flutter_foodybite/core/utils/constants.dart';
import 'package:flutter_foodybite/core/utils/httpdriver.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ChangeNotifier {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
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
        foods.add(new Food(item.data['name'], item.data['price'].toDouble(),
            item.data['image']));
        notifyListeners();
      }
    }
  }
}

class Food {
  final String name;
  final double price;
  final String image;

  Food(this.name, this.price, this.image);
}
