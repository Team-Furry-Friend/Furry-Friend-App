class Review {
  int rid = 0;
  int pid = 0;
  int mid = 0;
  String nickname = '';
  String email = '';
  String text = '';
  String regDate = '';
  String modDate = '';

  Review(
      {this.rid = 0,
      this.pid = 0,
      this.mid = 0,
      this.nickname = '',
      this.email = '',
      this.text = '',
      this.regDate = '',
      this.modDate = ''});

  Review.fromJson(Map<String, dynamic> json) {
    rid = json['rid'];
    pid = json['pid'];
    mid = json['mid'];
    nickname = json['nickname'] ?? '';
    email = json['email'] ?? '';
    text = json['text'];
    regDate = json['regDate'];
    modDate = json['modDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rid'] = rid;
    data['pid'] = pid;
    data['mid'] = mid;
    data['nickname'] = nickname;
    data['email'] = email;
    data['text'] = text;
    data['regDate'] = regDate;
    data['modDate'] = modDate;
    return data;
  }
}
