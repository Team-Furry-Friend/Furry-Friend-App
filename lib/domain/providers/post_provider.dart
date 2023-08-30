import 'package:flutter/material.dart';
import 'package:furry_friend/domain/model/post/review.dart';
import '../model/post/post.dart';
import '../api/api.dart';

class PostProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Post> postList = [];
  List<Review> reviewList = [];

  void getPopularityPost() {
    _client.getPopularityPost().then((value) {
      postList = [...postList];
      _notify();
    });
  }

  void getReviews(int pid) {
    _client.getReviews(pid).then((value) {
      reviewList = [...value];
      _notify();
    });
  }

  void postReviews(int pid, String text) {
    final data = {
      "pid": pid,
      "text": text,
    };

    _client.postReview(data).then((value) {
      _notify();
    });
  }

  void _notify() {
    notifyListeners();
  }
}
