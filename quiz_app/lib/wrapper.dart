
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/authenticate.dart';
import 'package:quizapp/home.dart';
import 'package:quizapp/user.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    if(user==null){
      return Authenticate();
    }else
      return Home();
  }
}
