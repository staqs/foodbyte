import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/utils/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class RestaurantService with ReactiveServiceMixin {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  RxValue<List<Restaurant>> _restaurants =
      RxValue<List<Restaurant>>(initial: []);

  List<Restaurant> get allRestaurants => _restaurants.value;

  RestaurantService() {
    getAllRestaurants();
    listenToReactiveValues([_restaurants]);
    // print("Get All Restaurants");
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
        // print(item.data);
        print("Getting Restuarant ${item.data['name']}");
        // var foo = jsonDecode()
        List<Food> foods = [];
        String resId = item.data['id'];
        String name = item.data['name'];
        String image = item.data['image'];
        String location = item.data['location'];
        String status = item.data['status'];
        double longitude = double.parse(item.data['longitude']);
        double latitude = double.parse(item.data['latitude']);
        for (var item in item.data['foods']) {
          // print(item);
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

        print("Restaurnat ID $resId");
        _restaurants.value.add(new Restaurant(
          id: resId,
          status: status,
          name: name,
          location: location,
          image: image,
          foods: foods,
          longitude: longitude,
          latitude: latitude,
        ));
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
}
