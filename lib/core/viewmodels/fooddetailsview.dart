import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/orderservice.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:flutter_foodybite/core/viewmodels/homeviewmodel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FoodDetailsViewModel extends ChangeNotifier {
  int _quantity = 1;
  Food _food;
  double _price;

  int get quantity => _quantity;
  double get price => _price;

  final OrderService order = locator<OrderService>();

  FoodDetailsViewModel(Food food) {
    this._food = food;
    calculatTotalPrice();
  }

  increaseQuantity() {
    this._quantity++;
    calculatTotalPrice();
    notifyListeners();
  }

  calculatTotalPrice() {
    _price = _quantity * _food.price;
    notifyListeners();
  }

  decreaseQuantity() {
    if (this._quantity > 0) this._quantity--;
    calculatTotalPrice();
    notifyListeners();
  }

  addToOrder() {
    order.addOrder(_food, _price);
  }
}
