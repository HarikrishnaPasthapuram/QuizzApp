
import 'package:firebase_auth/firebase_auth.dart';

import 'package:quizapp/user.dart';

class AuthServices{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User _userfromFirebaseuser(FirebaseUser user){
   return user!= null ? User(uid:user.uid):null;
  }
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userfromFirebaseuser);
  }
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userfromFirebaseuser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
     AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser user=result.user;
     return _userfromFirebaseuser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }




  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    return null;
    }
  }
}


