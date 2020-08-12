import 'package:flutter_foodybite/core/services/apiservice.dart';
import 'package:flutter_foodybite/core/services/authenticationservice.dart';
import 'package:flutter_foodybite/core/services/categoryservice.dart';
import 'package:flutter_foodybite/core/services/foodservice.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/orderservice.dart';
import 'package:flutter_foodybite/core/services/restaurantservice.dart';
import 'package:flutter_foodybite/core/services/storage_service_shared_pref.dart';
import 'package:get_it/get_it.dart';
import 'storageservice.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<StorageService>(
      () => new StorageServiceSharedPreferences());
  locator.registerLazySingleton<APIService>(() => new GraphQLClientAPI());

  locator.registerLazySingleton<OrderService>(() => new OrderService());
  locator.registerLazySingleton<FoodService>(() => new FoodService());
  locator.registerLazySingleton<AuthService>(() => new AuthService());
  locator
      .registerLazySingleton<RestaurantService>(() => new RestaurantService());
  locator.registerLazySingleton<CategoryService>(() => new CategoryService());
}
