import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/Models/message_chat.dart';
import 'package:fire_chat/Models/users.dart';
import 'package:fire_chat/block/user_chat_block.dart';
import 'package:fire_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatForms extends StatefulWidget {
  const ChatForms({Key? key}) : super(key: key);

  @override
  _ChatFormsState createState() => _ChatFormsState();
}

class _ChatFormsState extends State<ChatForms> {
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Fire Chat',
            style: txt30,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                print('Log Out');
                try {
                  setState(() {
                    context.read<DataCubitChat>().setCurrentUser(Users.empty());
                  });
                  Navigator.pushNamed(context, '/');
                } catch (e) {
                  print(e);
                }
              },
              icon: const Icon(Icons.door_back_door_rounded),
              tooltip: 'Log Out',
            )
          ],
          automaticallyImplyLeading: false),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('MessageChat')
            .orderBy('dataMessage')
            .snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // var items = snapshot.data?.docs ?? [];
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      bool IsMay = false;

                      if (index == 0) {
                        try {
                          _scrollController
                              .jumpTo(snapshot.data!.docs.length * highMessage);
                        } catch (e) {
                          print('index = $index');
                          print('Error = $e');
                        }
                      }

                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      MessageChat messageChat = MessageChat.fromDocSnapshot(ds);

                      if (ds['userEmail'] ==
                          context.read<DataCubitChat>().getUser.email) {
                        IsMay = true;
                      } else if (ds['displayName'] ==
                          context.read<DataCubitChat>().getUser.displayName) {
                        IsMay = true;
                      }

                      if (IsMay) {
                        return Container(
                            margin: const EdgeInsets.only(
                                top: kDefaultPadding, left: 50),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding * 0.75,
                                vertical: kDefaultPadding / 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  messageChat.TextMessage,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      longDateFormatter
                                          .format(messageChat.dataMessage),
                                      style: txt15,
                                    ),
                                  ],
                                ),
                              ],
                            ));
                      } else {
                        return Container(
                          margin: const EdgeInsets.only(
                              top: kDefaultPadding, right: 50),
                          decoration: BoxDecoration(
                              color: Colors.lightBlue.shade100,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 0.75,
                              vertical: kDefaultPadding / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messageChat.userEmail,
                                style: txt15,
                              ),
                              Text(
                                messageChat.TextMessage,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    longDateFormatter
                                        .format(messageChat.dataMessage),
                                    style: txt15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 10,
                      child: Form(
                        child: TextFormField(
                          controller: controller,
                          onEditingComplete: sendMessage,

                          //  () {
                          //   try {
                          //     String text = controller.text;
                          //     DateTime time = DateTime.now();

                          //     String userName = context
                          //             .read<DataCubitChat>()
                          //             .getUser
                          //             .displayName
                          //             .isNotEmpty
                          //         ? context
                          //             .read<DataCubitChat>()
                          //             .getUser
                          //             .displayName
                          //         : context.read<DataCubitChat>().getUser.email;

                          //     MessageChat messageChat = MessageChat(
                          //       userName,
                          //       text,
                          //       time,
                          //     );

                          //     try {
                          //       Map<String, dynamic> chatMap = {
                          //         'userEmail': messageChat.userEmail,
                          //         'TextMessage': messageChat.TextMessage,
                          //         'dataMessage': messageChat.dataMessage
                          //       };

                          //       FirebaseFirestore.instance
                          //           .collection('MessageChat')
                          //           .add(chatMap);

                          //       _scrollController.jumpTo(
                          //           _scrollController.position.maxScrollExtent +
                          //               100);
                          //     } catch (e) {
                          //       print(e);
                          //     }
                          //   } catch (e) {
                          //     print(e);
                          //   }
                          //   controller.clear();
                          // },
                          decoration: const InputDecoration(
                              labelText: 'Send a message'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        iconSize: 24,
                        color: Colors.blue,
                        onPressed: sendMessage,
                        icon: const Icon(
                          Icons.telegram_sharp,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }

  void sendMessage() async {
    try {
      String text = controller.text;
      DateTime time = DateTime.now();

      String strDisplayName = '';

      if (FirebaseAuth.instance.currentUser!.displayName != null) {
        strDisplayName = FirebaseAuth.instance.currentUser!.displayName!;
      } else if (FirebaseAuth.instance.currentUser!.email != null) {
        strDisplayName = FirebaseAuth.instance.currentUser!.email!;
      }

      MessageChat messageChat = MessageChat(strDisplayName, text, time);

      FirebaseFirestore.instance.collection('MessageChat').add({
        'userEmail': messageChat.userEmail,
        'TextMessage': messageChat.TextMessage,
        'dataMessage': messageChat.dataMessage
      }).then((value) {
        print('succcess!');

        _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent + 100);
        setState(() {});
      }).catchError((error) {
        print("Failed to add message: $error");
      });
    } catch (e) {
      print('Error: $e');
    }

    print(controller.text);
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
  }
}
