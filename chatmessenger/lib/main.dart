import 'package:chatmessenger/Utility/constant.dart';
import 'package:chatmessenger/screens/1_welcome.dart';
import 'package:chatmessenger/screens/2_register.dart';
import 'package:chatmessenger/screens/3_login.dart';
import 'package:chatmessenger/screens/4_chatselect.dart';
import 'package:chatmessenger/screens/5_chat.dart';
import 'package:chatmessenger/screens/6_userprofile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteTable.welcome,
      debugShowCheckedModeBanner: false,
      routes: {
        RouteTable.welcome: (context) => const WelcomeScreen(),
        RouteTable.register: (context) => const RegisterScreen(),
        RouteTable.login: (context) => const LoginScreen(),
        RouteTable.chatselect: (context) => const ChatSelectScreen(),
        RouteTable.chat: (context) => const ChatScreen(),
        RouteTable.userprofile: (context) => const UserProfile(),
      },
    );
  }
}
