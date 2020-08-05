// import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
// import 'package:flutter_foodybite/core/viewmodels/homeviewmodel.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:observable_ish/observable_ish.dart';
// import 'package:stacked/stacked.dart';

// class InformationService with ReactiveServiceMixin {
//   GraphQLClient cl = GraphQLClientAPI.clientToQuery();
//   List<Food> foods = [];

//   //1
//   InformationService() {
//     //3
//     listenToReactiveValues([foods]);
//     getAllFoods();
//   }

//   //2
//   RxValue<List<Food>> getFoods = RxValue<List<Food>>();
//   List<Food> get allFoods => foods;

//   getAllFoods() async {
//     QueryResult dl = await cl.query(
//       QueryOptions(
//         document: getfoods,
//       ),
//     );

//     if (!dl.hasException) {
//       print("has no error");
//       print(dl.data);

//       for (var item in dl.data['allProducts']) {
//         print(item.data);
//         // var foo = jsonDecode()
//         foods.add(new Food(item.data['name'], item.data['price'].toDouble()));
//       }
//     }
//   }

//   var getfoods = '''
//   query{
//   allProducts{
//     name
//     price
//   }
// }
//   ''';
// }
