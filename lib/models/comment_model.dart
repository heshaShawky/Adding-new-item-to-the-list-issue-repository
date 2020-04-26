import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  int id;
  String createdAt;
  String content;
  User user;

  Comment({this.id, this.createdAt, this.content, this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    content = json['content'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }

  @override
  List<Object> get props => [
    id, 
    createdAt,
    content,
    user
  ];
}

class User {
  int id;
  Null email;
  String registedAt;
  String username;
  String role;
  Null image;
  String password;
  String salt;

  User(
      {this.id,
      this.email,
      this.registedAt,
      this.username,
      this.role,
      this.image,
      this.password,
      this.salt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    registedAt = json['registedAt'];
    username = json['username'];
    role = json['role'];
    image = json['image'];
    password = json['password'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['registedAt'] = this.registedAt;
    data['username'] = this.username;
    data['role'] = this.role;
    data['image'] = this.image;
    data['password'] = this.password;
    data['salt'] = this.salt;
    return data;
  }
}