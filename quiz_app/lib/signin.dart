
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:quizapp/auth.dart';
import 'package:quizapp/constantd.dart';
import 'package:quizapp/home.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email="";
  String password="";
  String error="";
  final AuthServices _auth= AuthServices();
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        title: Text('QUIZ'),
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        elevation: 5,
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          },
              icon: Icon(Icons.person),
              label: Text("Sign Up",style: TextStyle(
                color: Colors.white
              ),))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),

        child: Form
          (
          key: _formkey,
            child: ListView(
          children: <Widget>[
            Image.asset("images/qu.png",height: 100,),

            SizedBox(height: 40.0,),
            TextFormField(
              decoration:textInputDecoration.copyWith(hintText: 'Email',icon: Icon(Icons.email,color: Colors.blueAccent,)),
              validator: (val)=>val.isEmpty?"Enter an Email":null,
              onChanged: (val){
                setState(() {
                  email=val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration:textInputDecoration.copyWith(hintText: 'Password',icon: Icon(Icons.lock,color: Colors.blueAccent)),
              validator: (val)=>val.length<6?"enter a 6+ character password":null,
              obscureText: true,
              onChanged: (val){
                setState(() {
                  password=val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
                color: Colors.black,
                child: Text("Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed:() async{
                  if(_formkey.currentState.validate()){
                    dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        error="could not sign in with those credential";
                      });
                    }
                  }

                }),
            SizedBox(height: 12.0,),
            Text(error,style: TextStyle(
                fontSize: 14.0,
                color: Colors.red
            ),
            ),
            SizedBox(height: 140.0,),

            RaisedButton(

              color: Colors.black,
              child: Text("Skip Login",style: TextStyle(color: Colors.white,fontSize: 20),),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
            )
          ],
        )),
      ),
    );
  }
}
