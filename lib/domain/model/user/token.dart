class Token {
  String refreshToken = '';
  String accessToken = '';

  Token({
    this.refreshToken = '',
    this.accessToken = '',
  });

  Token.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    data['accessToken'] = accessToken;
    return data;
  }
}
