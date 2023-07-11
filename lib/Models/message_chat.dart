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
