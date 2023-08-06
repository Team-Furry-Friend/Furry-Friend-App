import 'post_image.dart';

class Post {
  int pid = 0;
  String pcategory = '';
  String pname = '';
  String pexplain = '';
  int pprice = 0;
  bool del = false;
  int reviewCnt = 0;
  dynamic? mid;
  String mname = '';
  String regDate = '';
  String modDate = '';
  List<PostImage> imageDTOList = [];

  Post(
      {this.pid = 0,
      this.pcategory = '',
      this.pname = '',
      this.pexplain = '',
      this.pprice = 0,
      this.del = false,
      this.reviewCnt = 0,
      this.mid,
      this.mname = '',
      this.regDate = '',
      this.modDate = '',
      this.imageDTOList = const []});

  Post.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    pcategory = json['pcategory'];
    pname = json['pname'];
    pexplain = json['pexplain'];
    pprice = json['pprice'];
    del = json['del'];
    reviewCnt = json['reviewCnt'];
    mid = json['mid'];
    mname = json['mname'] ?? '';
    regDate = json['regDate'];
    modDate = json['modDate'];
    if (json['imageDTOList'] != null) {
      imageDTOList = <PostImage>[];
      json['imageDTOList'].forEach((v) {
        imageDTOList!.add(PostImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pid'] = pid;
    data['pcategory'] = pcategory;
    data['pname'] = pname;
    data['pexplain'] = pexplain;
    data['pprice'] = pprice;
    data['del'] = del;
    data['reviewCnt'] = reviewCnt;
    data['mid'] = mid;
    data['mname'] = mname;
    data['regDate'] = regDate;
    data['modDate'] = modDate;
    if (imageDTOList != null) {
      data['imageDTOList'] = imageDTOList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
