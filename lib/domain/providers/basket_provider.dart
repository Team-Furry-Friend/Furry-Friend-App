import 'package:flutter/material.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/api/api.dart';
import 'package:furry_friend/domain/model/basket/basket.dart';

class BasketProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Basket> _myBasket = [];
  List<Basket> get myBasket => _myBasket;

  void getMyBasketProducts() {
    _client.getMyBasketProducts().then((value) {
      _myBasket = value;
      notifyListeners();
    });
  }

  void postBasket(int pid) {
    final options = {
      "pid": pid,
      "jwtRequest": {
        "access_token": PrefsUtils.getString(PrefsUtils.utils.refreshToken)
      }
    };
    _client.postBasket(options).then((value) {
      getMyBasketProducts();
    });
  }

  void deleteBasket(int bid) {
    _client.deleteBasket(bid).then((value) {
      _myBasket = [..._myBasket];
      _myBasket.removeWhere((element) => element.bid == bid);
      notifyListeners();
    });
  }
}
