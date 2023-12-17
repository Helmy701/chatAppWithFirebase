import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/models/message.dart';

import '../constant.dart';
import '../widgets/chat_Widget.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final scrollController = ScrollController();

  TextEditingController textController = TextEditingController();

  // FirebaseFirestore firestore = FirebaseFirestore
  //     .instance; //that line not important because I use it again in the next line
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: messages.orderBy('time', descending: true).snapshots(),
      // snapshot is the thing thant contain data
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 50,
                  ),
                  const Text(
                    ' Chat',
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: textController,
                    onSubmitted: (data) {
                      messages.add({
                        'message': data,
                        'time': DateTime.now(),
                        'id': email,
                      });
                      textController.clear();
                      // jumpto not take time or take attributes of (duration or curve)
                      scrollController.animateTo(
                        // _controller.position.maxScrollExtent,
                        // I will make it 0 because i reversed the List view
                        0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text('loading...');
        }
      },
    );
  }
}
