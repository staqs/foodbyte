import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/utils/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class FoodService with ReactiveServiceMixin {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  // List<Food> foods = [];
  RxValue<List<Food>> _foods = RxValue<List<Food>>(initial: []);
  List<Food> get allFoods => _foods.value;

  FoodService() {
    getAllFoods();
    listenToReactiveValues([_foods]);
    print("Get all Foods In Foods Service");
  }

  getAllFoods() async {
    QueryResult dl = await cl.query(
      QueryOptions(
        document: Mutations.getfoods,
      ),
    );

    if (!dl.hasException) {
      print("has no error");
      // print(dl.data);

      for (var item in dl.data['allProducts']) {
        print(item.data);
        print("Getting food ${item.data['name']}");
        // var foo = jsonDecode()
        _foods.value
          ..add(new Food(
              name: item.data['name'],
              id: item.data['id'],
              category: item.data['category']['name'],
              price: item.data['price'].toDouble(),
              image: item.data['image'],
              description: item.data['description']));
        notifyListeners();
      }
    }

    print(_foods.value.toList());
  }
}
