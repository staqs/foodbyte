import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FoodService {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  List<Food> foods = [];

  FoodService() {
    getAllFoods();

    print("Get all Foods");
  }
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
      }
    }

    // print(foods.toList());
  }
}
