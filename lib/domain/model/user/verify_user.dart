class VerifyUser {
  int memberId = 0;
  String memberName = '';

  VerifyUser({this.memberId = 0, this.memberName = ''});

  VerifyUser.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'] ?? 0;
    memberName = json['memberName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['memberName'] = memberName;
    return data;
  }
}
