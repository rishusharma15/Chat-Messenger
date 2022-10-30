import 'package:chatmessenger/Utility/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ButtonRound extends StatelessWidget {
  const ButtonRound({
    Key? key,
    required this.onpressed,
    required this.title,
    required this.color,
    this.isIcon = false,
  }) : super(key: key);
  final onpressed;
  final String title;
  final Color color;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30),
        elevation: 8,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          height: 60,
          minWidth: 200,
          onPressed: onpressed,
          child: isIcon
              ? Icon(Icons.send)
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class TextEntry extends StatelessWidget {
  const TextEntry({
    Key? key,
    this.onchanged,
    this.keyboardtype,
    this.obscuretext = false,
    this.hinttext = '',
    this.icon,
    this.controller,
    this.keepLeft = false,
  }) : super(key: key);
  final onchanged;
  final keyboardtype;
  final bool obscuretext;
  final String hinttext;
  final icon;
  final controller;

  final bool keepLeft;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: TextField(
        controller: controller,
        onChanged: onchanged,
        textAlign: keepLeft ? TextAlign.left : TextAlign.center,
        keyboardType: keyboardtype,
        obscureText: obscuretext,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          hintText: hinttext,
          prefixIcon: Icon(
            icon,
            color: AppColors.primaryColor,
          ),
        ),
        cursorColor: AppColors.primaryColor,
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    this.onTap,
    this.username = '',
  }) : super(key: key);
  final onTap;
  final String username;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, Random().nextInt(255),
                      Random().nextInt(255), Random().nextInt(255)),
                  child: Icon(Icons.person),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(username),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.1,
            indent: 10,
            endIndent: 10,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    this.username = '',
    this.isMe = false,
    this.message = '',
  }) : super(key: key);

  final String username;
  final bool isMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
              left: 60,
            )
          : const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 60,
              left: 10,
            ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 12,
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? AppColors.primaryColor : Colors.white60,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
