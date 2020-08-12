import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/category.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/utils/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class CategoryService with ReactiveServiceMixin {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  // RxValue<List<Restaurant>> _restaurants =
  //     RxValue<List<Restaurant>>(initial: []);

  RxValue<List<Category>> _categories = RxValue<List<Category>>(initial: []);

  List<Category> get allCategories => _categories.value;

  CategoryService() {
    getAllRestaurants();
    listenToReactiveValues([_categories]);
    // print("Get All Restaurants");
  }

  getAllRestaurants() async {
    QueryResult dl = await cl.query(
      QueryOptions(
        document: Mutations.allCategories,
      ),
    );

    if (!dl.hasException) {
      // print("has no error");
      // print(dl.data);
      Random rng = new Random();
      for (var item in dl.data['allCategories']) {
        // print(item.data);
        // print("Getting Category ${item.data['name']}");
        // var foo = jsonDecode()

        _categories.value.add(new Category(
            color1: Color.fromARGB(100, 0, 0, 0),
            color2: Color.fromARGB(100, 0, 0, 0),
            value: item['name'],
            name: item['name'],
            img: item['image']));
      }
      // _foods.value
      //   ..add(new Food(
      //       name: item.data['name'],
      //       id: item.data['id'],
      //       category: item.data['category']['name'],
      //       price: item.data['price'].toDouble(),
      //       image: item.data['image'],
      //       description: item.data['description']));
      notifyListeners();
    }
  }
}
