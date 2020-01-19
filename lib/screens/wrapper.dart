import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/user.dart';
import 'package:mercado_ipn/screens/Mainpag.dart';
import 'package:mercado_ipn/screens/auth/authenticate.dart';
import 'package:provider/provider.dart';
//import 'package:mercado_ipn/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //print(user);
    //return home or auth
    if (user == null){
      return Authenticate();
    } else {
      return MyHomePage();
    }
  }
}