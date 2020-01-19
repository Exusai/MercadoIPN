import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/screens/cuenta/usrprods.dart';
import 'package:mercado_ipn/services/database.dart';
import 'package:provider/provider.dart';

class UsrProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
      value: DatabaseService().products,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          title: Text('Tus productos'),
          centerTitle: true,
          backgroundColor: Color(0xff8C035C),
          elevation: 0.0,
        ),
        body: UsuarioProd(),
        
      ),
    );
  }
}