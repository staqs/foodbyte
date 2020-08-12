import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/core/services/orderservice.dart';
import 'package:flutter_foodybite/core/services/restaurantservice.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:stacked/stacked.dart';

class FoodDetailsViewModel extends ReactiveViewModel {
  final RestaurantService restaurantService = locator<RestaurantService>();
  int _quantity = 1;
  Food _food;
  double _price;
  Restaurant asso = null;
  int get quantity => _quantity;
  double get price => _price;

  List<Restaurant> associated = [];
  final OrderService order = locator<OrderService>();

  FoodDetailsViewModel(Food food) {
    this._food = food;
    calculatTotalPrice();
    restaurantsAssociatedWithFood();
    asso = associated[0];
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

  restaurantsAssociatedWithFood() {
    for (Restaurant res in restaurantService.allRestaurants) {
      for (Food food in res.foods) {
        if (_food.id == food.id) {
          associated.add(res);
          notifyListeners();
        }
      }
    }
  }

  updateAssociated(Restaurant res) {
    asso = res;
    notifyListeners();
  }

  addToOrder() {
    order.addOrder(_food, _price, _quantity, asso);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [restaurantService];
}
