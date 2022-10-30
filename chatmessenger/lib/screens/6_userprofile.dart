import 'package:chatmessenger/Utility/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 50,
              ),
              child: CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('images/chat_app.png'),
              ),
            ),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                    Text(
                      "Rishu",
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 0.8,
              indent: 45,
              endIndent: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                    Text(
                      "Software Engineer",
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 0.8,
              indent: 45,
              endIndent: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "phone",
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                    Text(
                      "1234567890",
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 0.8,
              indent: 45,
              endIndent: 10,
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
