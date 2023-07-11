import 'package:fire_chat/Models/message_chat.dart';
import 'package:fire_chat/Models/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';

class KeeperChat {
  String userEmail = '';
  String password = '';
  String displayName = '';
  bool rememberMe = true;

  Users users = Users.empty();
  List<MessageChat> mesages = [];
}

class DataCubitChat extends Cubit<KeeperChat> {
  String get getUserEmail => state.userEmail;

  setUserEmail(String newUserEmail) {
    state.userEmail = newUserEmail;
  }

  String get getPassword => state.password;

  setPassword(String newPassword) {
    state.password = newPassword;
  }

  String get getDisplayName => state.displayName;

  setDiasplayName(String newDisplayName) {
    state.displayName = newDisplayName;
  }

  bool get getRememberMe => state.rememberMe;

  setRememberMe(bool newRememberMe) {
    state.rememberMe = newRememberMe;
  }

  Users get getUser => state.users;

  setCurrentUser(Users NewUser) {
    state.users = NewUser;
    print('NewUser = $NewUser');
  }

  List<MessageChat> get getMessageChat => state.mesages;

  setMessageChatList(List<MessageChat> newList) {
    state.mesages = newList;
  }

  addNewMessage(MessageChat NewMessage) {
    state.mesages.add(NewMessage);
  }

  DataCubitChat(KeeperChat initState) : super(initState);
}
