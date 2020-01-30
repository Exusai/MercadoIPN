//import 'package:mercado_ipn/screens/cuenta/viewprodls.dart';

import 'viewproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mercado_ipn/models/product.dart';
//import 'package:mercado_ipn/shared/loading.dart';

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
    List<Product> comida = [];
    avProds.forEach((prod){
      if(prod.categoria == 'Comida'){
          comida.add(prod);
      }
    });

    List<Product> dulces = [];
    avProds.forEach((prod){
      if(prod.categoria == 'Dulces'){
          dulces.add(prod);
      }
    });

    List<Product> electronicos = [];
    avProds.forEach((prod){
      if(prod.categoria == 'Electronicos'){
          electronicos.add(prod);
      }
    });

    List<Product> weas = [];
    avProds.forEach((prod){
      if(prod.categoria == 'Weas'){
          weas.add(prod);
      }
    });


    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: <Widget>[
        SizedBox(height: 20,),
        Row(
          children: <Widget>[
            SizedBox(width: 5,),
            Text('Comida',style: TextStyle(fontSize: 23),),
          ],
        ),
        //SizedBox(height: 10,),
        Container(
          height: 150,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: comida.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context, index) {
            return ViewProduct(product: comida[index]);
            },
          ),
        ),
        SizedBox(height: 10,),
        
        Row(
          children: <Widget>[
            SizedBox(width: 5,),
            Text('Dulces',style: TextStyle(fontSize: 23),),
          ],
        ),
        //SizedBox(height: 10,),
        Container(
          height: 150,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: dulces.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context, index) {
            return ViewProduct(product: dulces[index]);
            },
          ),
        ),
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            SizedBox(width: 5,),
            Text('Electronicos',style: TextStyle(fontSize: 23),),
          ],
        ),
        //SizedBox(height: 10,),
        Container(
          height: 150,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: electronicos.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context, index) {
            return ViewProduct(product: electronicos[index]);
            },
          ),
        ),
        SizedBox(height: 10,),

        Row(
          children: <Widget>[
            SizedBox(width: 5,),
            Text('Todo',style: TextStyle(fontSize: 23),),
          ],
        ),
        //SizedBox(height: 10),
         Container(
           height: 300,
                    child: GridView.builder(
      itemCount: avProds.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context,index){
        return ViewProduct(product: avProds[index]);
      },
    ),
         ),
      ],
    );

    // return products.length == null ? Loading() : GridView.builder(
    //   itemCount: avProds.length,
    //   shrinkWrap: true,
    //   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //   itemBuilder: (context,index){
    //     return ViewProduct(product: avProds[index]);
    //   },
    // );
  }
}