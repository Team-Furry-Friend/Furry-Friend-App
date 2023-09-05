import 'package:flutter/material.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/model/post/product.dart';
import 'package:furry_friend/domain/model/post/review.dart';
import '../model/post/post.dart';
import '../api/api.dart';

class PostProvider extends ChangeNotifier {
  final _client = ApiRepositories();

  List<Post> _post = [];
  Post _postDetail = Post();
  List<Review> _review = [];

  List<Post> get postList => _post;
  Post get postDetail => _postDetail;
  List<Review> get reviewList => _review;

  void getPopularityPost() {
    _client.getPopularityPost().then((value) {
      _post = [...value];
      notifyListeners();
    });
  }

  void postProduct(BuildContext context, Map<String, dynamic> product) {
    final options = {
      "productDTO": product,
      "jwtRequest": {
        "access_token": PrefsUtils.getString(PrefsUtils.utils.refreshToken)
      }
    };

    _client.postPost(options).then((value) {
      if ((value.data["statusCode"] ?? 400) / 100 == 2) {
        Utils.util.showSnackBar(context, '상품이 게시되었습니다!');
        Navigator.pop(context);
      } else {
        Utils.util.showSnackBar(context, '오류가 발생하였습니다.');
      }
    });
  }

  void putPost(BuildContext context, Product product) {
    final updateProduct = product.toJson();
    updateProduct.remove('imageDTOList');
    updateProduct['mid'] = _postDetail.mid;
    updateProduct['regDate'] = _postDetail.regDate;

    final options = {
      "productDTO": updateProduct,
      "jwtRequest": {
        "access_token": PrefsUtils.getString(PrefsUtils.utils.refreshToken)
      }
    };

    _client.putPost(options).then((value) {
      if ((value.data["statusCode"] ?? 400) / 100 == 2) {
        Map<String, dynamic> detail = _postDetail.toJson();

        for (var element in updateProduct.entries) {
          if (detail.containsKey(element.key)) {
            detail[element.key] = element.value;
          }
        }
        _postDetail = Post.fromJson(detail);
        notifyListeners();

        Utils.util.showSnackBar(context, '상품이 수정되었습니다!');
        Navigator.pop(context);
      } else {
        Utils.util.showSnackBar(context, '오류가 발생하였습니다.');
      }
    });
  }

  void getReviews(int pid) {
    _client.getReviews(pid).then((value) {
      _review = [...value];
      notifyListeners();
    });
  }

  void getPostDetail(int pid) {
    _client.getPostDetail(pid).then((value) {
      _postDetail = value;
      notifyListeners();
    });
  }

  void deletePost(int pid, BuildContext context) {
    _client.deletePost(pid).then((value) {
      if ((value.data["statusCode"] ?? 400) / 100 == 2) {
        _post.removeWhere((element) => element.pid == pid);

        Utils.util.showSnackBar(context, '상품이 삭제되었습니다.');
        Navigator.pop(context);
        Navigator.pop(context);
        notifyListeners();
      }
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
