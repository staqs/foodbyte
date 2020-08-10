import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/services/foodservice.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/orderservice.dart';
import 'package:flutter_foodybite/core/services/restaurantservice.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:geolocator/geolocator.dart';

class HomeViewModel extends ReactiveViewModel {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  final OrderService order = locator<OrderService>();
  final FoodService foodService = locator<FoodService>();
  final RestaurantService restaurantService = locator<RestaurantService>();
  List<Food> foods = [];

  List<Food> get allFoods => foodService.allFoods;

  HomeViewModel() {
    print("Home View Model is Working");
    print(foodService.allFoods.length);
    getPosition();
  }

  longUpdateStuff() async {
    print("Calling a method");

    print(foods.toList());
    // print(dl.data[0]["name"]);
  }

  proceedOrder() {
    order.sendOrder();
    print("sending order called");
  }

  getPosition() async {
    print("Getting Location");
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [foodService, restaurantService];
}
