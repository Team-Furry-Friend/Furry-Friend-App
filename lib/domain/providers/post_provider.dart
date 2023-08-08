import 'package:flutter/material.dart';
import '../model/post/post.dart';
import '../api/api.dart';

class PostProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Post> postList = [];

  int page = 1;
  bool hasNextPage = true;
  bool isFirstLoading = true;
  bool isLoadingPage = false;

  final limit = 20;

  void getPostKeyWord(int size, String type, String keyword) {
    _client.getPosts(page, size, type, keyword).then((value) {
      postList = value.dtoList;
      hasNextPage = value.next;
      page++;
      isLoadingPage = false;
      _notify();
    });
  }

  void getPopularityPost() {
    _client.getPopularityPost().then((value) {
      postList = value;
      _notify();
    });
  }

  void _notify() {
    postList = [...postList];
    notifyListeners();
  }
}
