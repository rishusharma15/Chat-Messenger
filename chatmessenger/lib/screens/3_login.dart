import 'package:chatmessenger/Utility/components.dart';
import 'package:chatmessenger/Utility/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 150,
                  child: Image.asset("images/output-onlinepngtools.png"),
                ),
              ),
            ),
            TextEntry(
              icon: Icons.email,
              hinttext: 'Enter Your Email',
              keyboardtype: TextInputType.emailAddress,
              obscuretext: false,
              onchanged: (val) {
                setState(() {
                  _email = val;
                });
              },
            ),
            TextEntry(
              icon: Icons.key,
              hinttext: 'Enter Password',
              keyboardtype: TextInputType.text,
              obscuretext: true,
              onchanged: (val) {
                setState(() {
                  _password = val;
                });
              },
            ),
            ButtonRound(
              onpressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  );
                  if (user != null) {
                    Navigator.pushNamed(context, RouteTable.chatselect);
                  }
                } catch (err) {
                  debugPrint(err.toString());
                }
              },
              title: 'Login',
              color: AppColors.primaryColor,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Not Registered?'),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
