import 'package:flutter/material.dart';
import '../model/post/post.dart';
import '../api/api.dart';

class SearchProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Post> productList = [];

  int page = 1;
  bool hasNextPage = true;
  bool isLoadingPage = false;
  bool startSearch = false;

  void getPostKeyWord(String type, String keyword, String sortType,
      {int? page}) {
    if (!startSearch) startSearch = true;
    int newPage = page ?? this.page;
    _client.getPosts(newPage, 20, type, keyword).then((value) {
      if (newPage == 1) {
        productList = value.dtoList;
      } else {
        productList.addAll(value.dtoList);
      }
      hasNextPage = value.next;
      this.page = newPage++;
      listSort(sortType);
    });
  }

  void listSort(String sortType) {
    switch (sortType) {
      case '가격 낮은 순':
        productList.sort((a, b) => a.pprice.compareTo(b.pprice));
        break;
      case '가격 높은 순':
        productList.sort((b, a) => a.pprice.compareTo(b.pprice));
        break;
      case '최신순':
        productList.sort((b, a) => a.regDate.compareTo(b.regDate));
        break;
    }
    _notify();
  }

  void _notify() {
    productList = [...productList];
    isLoadingPage = false;
    notifyListeners();
  }
}
