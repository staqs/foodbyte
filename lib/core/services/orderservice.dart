import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/order.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OrderService {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  List<Order> _orders = [];
  OrderService() {
    print("Order Service started");
  }

  addOrder(Food food, double totalPrice) {
    Order order = new Order("124", 123.00, "1234", "eli");
    _orders.add(order);

    print("Order ${food.name} added to Order Service");
    print("We have ${_orders.length} orders");
  }

  sendOrder() async {
    print("sending order");
    QueryResult dl = await cl.query(
      QueryOptions(
          document: addItemToOrder,
          variables: {"price": 42.0, "itemId": "1234"}),
    );

    if (!dl.hasException) {
      print("has no error");
      print(dl.data);

      // for (var item in dl.data['allProducts']) {
      //   print(item.data);
      //   // var foo = jsonDecode()
      //   foods.add(new Food(
      //       name: item.data['name'],
      //       price: item.data['price'].toDouble(),
      //       image: item.data['image'],
      //       description: item.data['description']));
      // }
    }
  }

  removeOrder(String orderID) {}

  String addItemToOrder = r'''
    mutation addOrder($price : Float!, $itemId:String!){
		createOrder(data : {price:$price, itemId: $itemId}){
    itemId
  }
}
''';
}
