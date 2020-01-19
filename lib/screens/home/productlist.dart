import 'viewproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/shared/loading.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];
    //products.contains();

    //products.forEach((product){
    //  print(product.name);
    //});

    List<Product> avProds = [];
    //print(products[3].name);
    products.forEach((product){
      if(product.stock == 'yes'){
        //print(product.name);
        if (product.blocked != 'yes'){
          avProds.add(product);
        }
      }
    });

    return products.length == null ? Loading() : GridView.builder(
      itemCount: avProds.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context,index){
        return ViewProduct(product: avProds[index]);
      },
    );
  }
}