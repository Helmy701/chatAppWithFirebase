// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:test/constant.dart';

class Users {
  final String email;
  final String name;
  final String photo;
  Users(
    this.email,
    this.name,
    this.photo,
  );

  //I will recieve a jasonData map and return list of key message
  factory Users.fromJson(jsonData) {
    return Users(jsonData['email'], jsonData['name'], jsonData['photo']);
  }
}
