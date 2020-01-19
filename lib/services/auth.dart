import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercado_ipn/models/user.dart';
//import 'package:mercado_ipn/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uID;

  //crete user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream 
  Stream<User> get user{
    //return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
  Future getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    //uID = user.uid;
    //return print(user.uid);
    }
  //sing in annon
  Future singInAnon() async{
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);   

    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //email and ps
  Future singInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password); 
      FirebaseUser user = result.user;
      //documento for the user using uid
      //await DatabaseService(uid: user.uid).updateUserData(nombre, apellido, escuela);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //google

  //register email and ps
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sing out
  Future singOut() async{
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}