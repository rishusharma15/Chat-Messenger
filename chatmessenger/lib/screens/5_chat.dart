import 'package:chatmessenger/Utility/components.dart';
import 'package:chatmessenger/Utility/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _receiver = '';
  final _auth = FirebaseAuth.instance;
  late User currentUser;
  final _firestore = FirebaseFirestore.instance;
  String typedText = '';
  TextEditingController msgController = TextEditingController();

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          currentUser = user;
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    if (arg != null) {
      setState(() {
        _receiver = arg['receiver'];
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ChatterBox",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        elevation: 10,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          MessageStream(
            sender: currentUser.email as String,
            receiver: _receiver,
          ),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: TextEntry(
                      hinttext: 'Type your messege here',
                      controller: msgController,
                      keepLeft: true,
                      onchanged: (val) {
                        setState(() {
                          typedText = val;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: ButtonRound(
                      onpressed: () {
                        _firestore.collection('messages').add({
                          'receiver': _receiver,
                          'text': typedText,
                          'sender': currentUser.email,
                          'createdAt': Timestamp.now(),
                        });
                        msgController.clear();
                      },
                      title: '>',
                      isIcon: true,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required this.sender,
    required this.receiver,
  }) : super(key: key);

  final String sender;
  final String receiver;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').orderBy('createdAt').snapshots(),
      builder: ((context, snapshot) {
        List<Map> messageData = [];

        if (snapshot.hasData) {
          for (var data in snapshot.data!.docs) {
            var cData = data.data() as Map;
            String texter = cData['sender'];
            String rec = cData['receiver'];
            if (((texter == sender) && (rec == receiver)) ||
                ((sender == receiver) && (rec == sender))) {
              messageData.add({
                'isMe': texter == sender,
                'username': texter == receiver ? texter.split('@')[0] : 'you',
                'message': cData['text'],
              });
            }
          }
        }

        final allMessages = snapshot.data;

        return Expanded(
          child: messageData.isEmpty
              ? const Center(
                  child: Text('No Chats Found'),
                )
              : ListView(
                  children: <MessageBubble>[
                    for (var msgData in messageData)
                      MessageBubble(
                        username: msgData['username'],
                        isMe: msgData['isMe'],
                        message: msgData['message'],
                      ),
                  ],
                ),
        );
      }),
    );
  }
}
