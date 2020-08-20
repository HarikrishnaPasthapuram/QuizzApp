
import 'package:flutter/material.dart';

import 'package:quizapp/auth.dart';

class HomeIcon extends StatelessWidget {
  final AuthServices _auth=AuthServices();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(

        backgroundColor: Colors.brown[400],
        title: Text('QUIZ'),
        elevation: 2.0,
        actions: <Widget>[
         IconButton(icon: Icon(Icons.chat), onPressed: null),
          FlatButton.icon(onPressed:()async{
            await _auth.signOut();
          },
              icon: Icon(Icons.person),

              label: Text("lOGOUt")),


        ],
      ),

    );
  }
}


