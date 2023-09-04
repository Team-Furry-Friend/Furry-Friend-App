import 'package:furry_friend/domain/model/post/post_image.dart';

class Product {
  String pcategory = '';
  String pname = '';
  String pexplain = '';
  int pprice = 0;
  List<PostImage>? imageDTOList = [];

  Product(
      {this.pcategory = '',
      this.pname = '',
      this.pexplain = '',
      this.pprice = 0,
      this.imageDTOList = const []});

  Product.fromJson(Map<String, dynamic> json) {
    pcategory = json['pcategory'];
    pname = json['pname'];
    pexplain = json['pexplain'];
    pprice = json['pprice'];
    if (json['imageDTOList'] != null) {
      imageDTOList = <PostImage>[];
      json['imageDTOList'].forEach((v) {
        imageDTOList!.add(PostImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pcategory'] = pcategory;
    data['pname'] = pname;
    data['pexplain'] = pexplain;
    data['pprice'] = pprice;
    if (imageDTOList != null) {
      data['imageDTOList'] = imageDTOList!.map((v) => v.toJson()).toList();
    } else {
      data['imageDTOList'] = [];
    }
    return data;
  }
}
