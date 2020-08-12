import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/order.dart';
import 'package:flutter_foodybite/core/services/foodservice.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/orderservice.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends ReactiveViewModel {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  final OrderService order = locator<OrderService>();
  final FoodService foodService = locator<FoodService>();
  List<Food> foods = [];
  // final InformationService _informationService = locator<InformationService>();

  // @override
  // List<ReactiveServiceMixin> get reactiveServices => [_informationService];

  List<Food> get allFoods => foodService.allFoods;
  List<Order> get allOrders => order.allOrders;

  double get totalPrice => order.getTotalPrice();

  CartViewModel() {
    print("Home View Model is Working");
  }

  longUpdateStuff() async {
    print("Calling a method");

    // var data = await HTTPDriver.loadFromHTTP(getfoods, '{}');
    // print(data);

    print(foods.toList());
    // print(dl.data[0]["name"]);
  }

  Order getOrder(String orderId) {
    return order.getOrder(orderId);
  }

  Food getFoodFromOrderId(String foodIdInOrder) {
    return order.getFoodFromOrder(foodIdInOrder);
  }

  proceedOrder() {
    order.sendOrder();
    print("sending order called");
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [order];
}
