import 'package:chatmessenger/Utility/components.dart';
import 'package:chatmessenger/Utility/constant.dart';
import 'package:chatmessenger/screens/6_userprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ChatSelectScreen extends StatefulWidget {
  const ChatSelectScreen({Key? key}) : super(key: key);

  @override
  State<ChatSelectScreen> createState() => _ChatSelectScreenState();
}

class _ChatSelectScreenState extends State<ChatSelectScreen> {
  List<String> users = [];

  int currentIndex = 0;

  final _auth = FirebaseAuth.instance;

  late User currentUser;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        var data = await _firestore
            .collection('chatusers')
            .where('email', isNotEqualTo: currentUser.email)
            .orderBy('email')
            .get();
        setState(() {
          currentUser = user;
          for (var d in data.docs) {
            users.add(d.data()['email']);
          }
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteTable.welcome, (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text(
          "ChatterBox",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: SizedBox(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        elevation: 10,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (String username in users)
              ChatCard(
                username: username,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteTable.chat,
                    arguments: {'receiver': username},
                  );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: currentIndex,
        onTap: (ind) {
          if (ind != currentIndex) {
            if (ind == 0) {
              Navigator.pushNamed(context, RouteTable.chatselect);
            } else if (ind == 1) {
              Navigator.pushNamed(context, RouteTable.userprofile);
            }
          }
        },
      ),
    );
  }
}
