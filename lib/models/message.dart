import 'package:test/constant.dart';

class Message {
  final String message;
  final String id;
  Message(
    this.message,
    this.id,
  );

  //I will recieve a jasonData map and return list of key message
  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}
