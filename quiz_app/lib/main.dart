

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import 'package:quizapp/auth.dart';
import 'package:quizapp/splash.dart';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
