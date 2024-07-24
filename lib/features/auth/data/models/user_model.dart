import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String email,
    required String password,
    required bool verify,
    required String token,
  }) : super(
          id: id,
          email: email,
          password: password,
          verify: verify,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      verify: json['verify'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'password': password,
      'verify': verify,
      'token': token,
    };
  }
}
