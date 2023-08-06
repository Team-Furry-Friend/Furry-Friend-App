import 'post.dart';

class PagePost {
  List<Post> dtoList = [];
  int totalPage = 0;
  int page = 0;
  int size = 0;
  int start = 0;
  int end = 0;
  bool prev = false;
  bool next = false;
  List<int> pageList = [];

  PagePost(
      {this.dtoList = const [],
      this.totalPage = 0,
      this.page = 0,
      this.size = 0,
      this.start = 0,
      this.end = 0,
      this.prev = false,
      this.next = false,
      this.pageList = const []});

  PagePost.fromJson(Map<String, dynamic> json) {
    if (json['dtoList'] != null) {
      dtoList = <Post>[];
      json['dtoList'].forEach((v) {
        dtoList!.add(Post.fromJson(v));
      });
    }
    totalPage = json['totalPage'];
    page = json['page'];
    size = json['size'];
    start = json['start'];
    end = json['end'];
    prev = json['prev'];
    next = json['next'];
    pageList = json['pageList'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dtoList != null) {
      data['dtoList'] = dtoList!.map((v) => v.toJson()).toList();
    }
    data['totalPage'] = totalPage;
    data['page'] = page;
    data['size'] = size;
    data['start'] = start;
    data['end'] = end;
    data['prev'] = prev;
    data['next'] = next;
    data['pageList'] = pageList;
    return data;
  }
}
