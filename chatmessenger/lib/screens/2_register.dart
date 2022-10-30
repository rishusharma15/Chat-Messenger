import 'package:chatmessenger/Utility/components.dart';
import 'package:chatmessenger/Utility/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
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
                // debugPrint(_email);
                // debugPrint(_password);
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                  if (newUser != null) {
                    _firestore.collection('chatusers').add(
                      {
                        'email': _email,
                        'username': ' ',
                      },
                    );
                    Navigator.pushNamed(context, RouteTable.chatselect);
                  }
                } catch (err) {
                  debugPrint(err.toString());
                }
              },
              title: 'Register',
              color: AppColors.primaryColor,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('already registered?'),
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
