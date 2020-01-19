import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/models/user.dart';
import 'package:mercado_ipn/screens/cuenta/viewprodls.dart';
import 'package:provider/provider.dart';

class UsuarioProd extends StatefulWidget {
  @override
  _UsuarioProdState createState() => _UsuarioProdState();
}

class _UsuarioProdState extends State<UsuarioProd> {  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final products = Provider.of<List<Product>>(context) ?? [];
    List<Product> usrProd = [];
    //print(products[3].name);
    products.forEach((product){
      if(product.propietario == user.uid){
        //print(product.name);
        usrProd.add(product);
      }
    });
     return ListView.builder(
       itemCount: usrProd.length,
       itemBuilder: (context,index){
         return ViewProductls(product: usrProd[index]);
         //return Text(products[index].name);
       },
    );
  }
}