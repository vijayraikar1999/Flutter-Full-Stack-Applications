import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pool_chat_flutter/data/constants.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  late String messageText;

  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4d4653),
      appBar: AppBar(
        backgroundColor: const Color(0xFF9B2F23),
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
        title: const Text(
          'Chat',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MessagesStream(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 5.0,
                      right: 2.5,
                      bottom: 5.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.teal,
                        width: 1.0,
                      ),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: messageTextController,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 2.5,
                      right: 5.0,
                      bottom: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.teal,
                        width: 1.0,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        _firestore.collection('pool_chat_messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'date': DateTime.now().toIso8601String(),
                        });
                        messageTextController.clear();
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('pool_chat_messages')
          .orderBy('date')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = (snapshot.data)!.docs;
        List<Widget> messageWidgets = [];
        for (var message in messages) {
          final messageMap = (message.data())! as Map;
          final messageText = messageMap['text'];
          final messageSender = messageMap['sender'];

          final currentUser = loggedInUser.email;

          final messageWidget = MessageBubble(
            messageText: messageText,
            messageSender: messageSender,
            isSender: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            // reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.messageText,
    required this.messageSender,
    required this.isSender,
  }) : super(key: key);

  final dynamic messageText;
  final dynamic messageSender;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$messageSender',
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: !isSender
                  ? const Radius.circular(0.0)
                  : const Radius.circular(30.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0),
              topRight: isSender
                  ? const Radius.circular(0.0)
                  : const Radius.circular(30.0),
            ),
            // color: Colors.lightBlueAccent,
            color: isSender ? Colors.teal : Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '$messageText',
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
