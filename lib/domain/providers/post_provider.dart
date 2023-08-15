import 'package:flutter/material.dart';
import '../model/post/post.dart';
import '../api/api.dart';

class PostProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Post> postList = [];

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
