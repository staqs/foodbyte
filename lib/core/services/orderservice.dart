import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/order.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/core/services/authenticationservice.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:flutter_foodybite/core/utils/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class OrderService with ReactiveServiceMixin {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  final AuthService authService = locator<AuthService>();
  RxValue<List<Order>> _orders = RxValue<List<Order>>(initial: []);

  List<Order> get allOrders => _orders.value;

  // List<Order> _orders = [];
  List<Food> _foods = [];
  double _total_price = 0;
  OrderService() {
    print("Order Service started");
  }

  addOrder(Food food, double totalPrice, int quantity, Restaurant restaurant) {
    print(food.id);
    // print(food.description)
    Order order = new Order(
      id: "124",
      price: food.price,
      foodId: food.id.toString(),
      quantity: quantity,
      userId: authService.getCurrentUser.id,
      resId: restaurant.id,
    );
    _orders.value.add(order);
    _foods.add(food);

    _total_price += totalPrice;
    print("Order ${food.name} added to Order Service");
    print("We have ${_orders.value.length} orders");
  }

  sendOrder() async {
    for (var item in _orders.value) {
      await sendSingleFood(item);
    }

    _orders.value = [];
  }

  sendSingleFood(Order order) async {
    print("sending order");
    QueryResult dl = await cl.query(
      QueryOptions(document: Mutations.addItemToOrder, variables: {
        "price": order.price,
        "quantity": order.quantity,
        "food": {
          "connect": {"id": order.foodId}
        },
        "customer": {
          "connect": {"id": authService.getCurrentUser.id}
        },
        "res": {
          "connect": {"id": order.resId}
        }
      }),
    );

    if (!dl.hasException) {
      print("has no error");
      print(dl.data);
      print("Order Sent");
    } else {
      print(dl.exception);
    }
  }

  List<Food> getAllFoods() {
    return _foods;
  }

  List<Order> getAllOrders() {
    return _orders.value;
  }

  Order getOrder(String id) {
    for (int i = 0; i > _orders.value.length; i++) {
      Order temp = _orders.value[i];

      if (temp.foodId == id) return temp;
    }

    return null;
  }

  double getTotalPrice() {
    return _total_price;
  }

  removeOrder(String orderID) {}

  Food getFoodFromOrder(String id) {
    print("Length of foods ${_foods.length}");

    for (int i = 0; i <= _foods.length; i++) {
      Food temp = _foods[i];
      print("id ${temp.id}");
      print("Food print is ${temp.id}");
      if (temp.id == id) return temp;
    }

    return null;
  }
}
