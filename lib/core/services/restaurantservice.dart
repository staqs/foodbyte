import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/utils/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class RestaurantService with ReactiveServiceMixin {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  // List<Food> foods = [];
  RxValue<List<Food>> _foods = RxValue<List<Food>>(initial: []);
  RxValue<List<Restaurant>> _restaurants =
      RxValue<List<Restaurant>>(initial: []);

  List<Restaurant> get allRestaurants => _restaurants.value;
  List<Food> get allFoods => _foods.value;

  RestaurantService() {
    getAllRestaurants();
    listenToReactiveValues([_foods]);
    print("Get all Foods In Foods Service");
  }

  getAllRestaurants() async {
    QueryResult dl = await cl.query(
      QueryOptions(
        document: Mutations.allRestaurants,
      ),
    );

    if (!dl.hasException) {
      print("has no error");
      // print(dl.data);

      for (var item in dl.data['allRestaurants']) {
        print(item.data);
        print("Getting Restuarant ${item.data['name']}");
        // var foo = jsonDecode()
        List<Food> foods = [];
        String name = item.data['name'];
        String image = item.data['image'];
        for (var item in item.data['foods']) {
          print(item);
          // print(item['name']);
          // print(item['id']);
          // print(item['price']);
          // print(item['description']);
          foods.add(new Food(
              name: item['name'],
              id: item['id'],
              category: item['category']['name'],
              price: item['price'].toDouble(),
              image: item['image'],
              description: item['description']));
        }

        _restaurants.value
            .add(new Restaurant(name: name, image: image, foods: foods));
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

    print(_foods.value.toList());
  }
}
