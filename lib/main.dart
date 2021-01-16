import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:sample_chat_app/screens/auth_screen.dart';
import 'package:sample_chat_app/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatFero',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Colors.indigo,
        accentColor: Colors.amberAccent,
        primaryColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.indigo,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
