
import 'package:flutter/material.dart';

import 'package:quizapp/auth.dart';
import 'package:quizapp/constantd.dart';
import 'package:quizapp/signin.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        title: Text('Sign In'),
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        elevation: 5,
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
          },
              icon: Icon(Icons.person),
              label: Text("Sign In",style: TextStyle(color: Colors.white)))
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
                onPressed:()async{
                  if(_formkey.currentState.validate()){
                    dynamic result= await _auth.registerWithEmailAndPassword(email, password);
                  if(result==null){
                    setState(() {
                      error="Please Enter a Valid Email";
                    });
                  }
                  }

                }),
            SizedBox(height: 12.0,),
            Text(error,style: TextStyle(
              fontSize: 14.0,
              color: Colors.red
            ),
            )
          ],
        )),
      ),
    );
  }
}
