import 'dart:convert';

class User {
  final String username;
  final String name;
  final String picUrl;
  final String contact;
  final String email;
  final String about;
  final int gender; // 0 -> Male, 1 -> Female, 2 -> Other

  User(
      {this.username,
      this.picUrl,
      this.email,
      this.about,
      this.name,
      this.gender,
      this.contact}) {
    assert(username != null);
    assert(name != null);
  }

  String toJsonString() {
    Map<String, dynamic> userMap = {
      'u': username,
      'n': name,
      'picUrl': picUrl,
      'email': email,
      'about': about
    };
    return jsonEncode(userMap);
  }

  static User fromJson(String json) {
    Map<String, dynamic> userMap = jsonDecode(json);
    return User(
        name: userMap['n'],
        username: userMap['u'],
        email: userMap['email'],
        about: 'Test about...', //userMap['about'],
        picUrl: userMap['picUrl']);
  }
}
