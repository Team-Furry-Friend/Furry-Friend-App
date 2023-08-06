class PostImage {
  String imgName = "";
  String path = "";

  PostImage({this.imgName = '', this.path = ''});

  PostImage.fromJson(Map<String, dynamic> json) {
    imgName = json['imgName'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgName'] = imgName;
    data['path'] = path;
    return data;
  }
}
