import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  String userEmail = '';
  String TextMessage = '';
  DateTime dataMessage = DateTime.now();

  MessageChat(this.userEmail, this.TextMessage, this.dataMessage);

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'TextMessage': TextMessage,
      'dataMessage': dataMessage
    };
  }

  factory MessageChat.fromDocSnapshot(DocumentSnapshot ds) {
    String userEmail = ds['userEmail'];
    String TextMessage = ds['TextMessage'];
    Timestamp timestamp = ds['dataMessage'] as Timestamp;
    DateTime dataMessage =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

    return MessageChat(userEmail, TextMessage, dataMessage);
  }

  factory MessageChat.fromMap(Map<String, dynamic> map) {
    return MessageChat(
        map['userEmail'], map['TextMessage'], map['dataMessage']);
  }

  MessageChat.empty() {
    userEmail = '';
    TextMessage = '';
    dataMessage = DateTime.now();
  }

  @override
  String toString() {
    return 'userEmail = $userEmail, TextMessage = $TextMessage, dataMessage = $dataMessage ';
  }
}
