import 'package:furry_friend/domain/model/post/product_image.dart';

class Basket {
  int bid = 0;
  int pid = 0;
  String pcategory = '';
  String pname = '';
  String pexplain = '';
  int pprice = 0;
  bool del = false;
  int mid = 0;
  String regDate = '';
  String modDate = '';
  ProductImage? image;

  Basket(
      {this.bid = 0,
        this.pid = 0,
        this.pcategory = '',
        this.pname = '',
        this.pexplain = '',
        this.pprice = 0,
        this.del = false,
        this.mid = 0,
        this.regDate = '',
        this.modDate = '',
        this.image});

  Basket.fromJson(Map<String, dynamic> json) {
    bid = json['bid'];
    pid = json['pid'];
    pcategory = json['pcategory'] ?? '';
    pname = json['pname'] ?? '';
    pexplain = json['pexplain'] ?? '';
    pprice = json['pprice'] ?? 0;
    del = json['del'] ?? false;
    mid = json['mid'] ?? 0;
    regDate = json['regDate'] ?? '';
    modDate = json['modDate'] ?? '';
    image = json['imageDTO'] != null
        ? ProductImage.fromJson(json['imageDTO'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bid'] = bid;
    data['pid'] = pid;
    data['pcategory'] = pcategory;
    data['pname'] = pname;
    data['pexplain'] = pexplain;
    data['pprice'] = pprice;
    data['del'] = del;
    data['mid'] = mid;
    data['regDate'] = regDate;
    data['modDate'] = modDate;
    if (image != null) {
      data['imageDTO'] = image!.toJson();
    }
    return data;
  }
}
