import 'package:flutter/material.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/model/post/review.dart';
import '../model/post/post.dart';
import '../api/api.dart';

class PostProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Post> _post = [];
  List<Review> _review = [];

  List<Post> get postList => _post;
  List<Review> get reviewList => _review;

  void getPopularityPost() {
    _client.getPopularityPost().then((value) {
      _post = [...value];
      notifyListeners();
    });
  }

  void getReviews(int pid) {
    _client.getReviews(pid).then((value) {
      _review = [...value];
      notifyListeners();
    });
  }

  void postReviews(int pid, String text) {
    final data = {
      "pid": pid,
      "text": text,
      "access_token": PrefsUtils.getString(PrefsUtils.utils.refreshToken)
    };

    _client.postReview(data).then((value) {
      notifyListeners();
    });
  }
}
