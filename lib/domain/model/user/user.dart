class User {
  double mid = 0;
  String name = '';
  String address = '';
  String phone = '';
  String email = '';
  String mpw = '';
  String social = '';
  bool del = false;

  User(
      {this.mid = 0,
      this.name = '',
      this.address = '',
      this.phone = '',
      this.email = '',
      this.mpw = '',
      this.social = '',
      this.del = false});

  User.fromJson(Map<String, dynamic> json) {
    mid = json['mid'] ?? 0;
    name = json['name'] ?? '';
    address = json['address'] ?? '';
    phone = json['phone'] ?? '';
    email = json['email'] ?? '';
    mpw = json['mpw'] ?? '';
    social = json['social'] ?? '';
    del = json['del'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mid'] = mid;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['mpw'] = mpw;
    data['social'] = social;
    data['del'] = del;
    return data;
  }
}
