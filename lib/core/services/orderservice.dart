import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/order.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:flutter_foodybite/core/utils/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OrderService {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  List<Order> _orders = [];
  List<Food> _foods = [];
  double _total_price = 0;
  OrderService() {
    print("Order Service started");
  }

  addOrder(Food food, double totalPrice, int quantity) {
    print(food.id);
    // print(food.description)
    Order order = new Order(
        id: "124",
        price: food.price,
        foodId: food.id.toString(),
        quantity: quantity,
        userId: "eli");
    _orders.add(order);
    _foods.add(food);

    _total_price += totalPrice;
    print("Order ${food.name} added to Order Service");
    print("We have ${_orders.length} orders");
  }

  sendOrder() async {
    for (var item in _orders) {
      await sendSingleFood(item);
    }

    _orders = [];
  }

  sendSingleFood(Order order) async {
    print("sending order");
    QueryResult dl = await cl.query(
      QueryOptions(document: Mutations.addItemToOrder, variables: {
        "price": order.price,
        "itemId": order.foodId,
        "customer": "Customer",
        "quantity": order.quantity
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
    return _orders;
  }

  Order getOrder(String id) {
    for (int i = 0; i > _orders.length; i++) {
      Order temp = _orders[i];

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
