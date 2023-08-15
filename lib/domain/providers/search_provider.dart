import 'package:flutter/material.dart';
import '../model/post/post.dart';
import '../api/api.dart';

class SearchProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Post> productList = [];

  int page = 1;
  bool hasNextPage = true;
  bool isLoadingPage = false;

  void getPostKeyWord(String type, String keyword, {int? page}) {
    int newPage = page ?? this.page;
    _client.getPosts(newPage, 20, type, keyword).then((value) {
      if (newPage == 1) {
        productList = value.dtoList;
      } else {
        productList.addAll(value.dtoList);
      }
      hasNextPage = value.next;
      this.page = newPage++;
      _notify();
    });
  }

  void _notify() {
    productList = [...productList];
    isLoadingPage = false;
    notifyListeners();
  }
}
