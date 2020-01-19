import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/models/user.dart';
import 'package:provider/provider.dart';
import 'package:mercado_ipn/services/database.dart';

class ViewProductls extends StatelessWidget {
  final Product product;
  
  ViewProductls({this.product});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String disp = '';
    //print(product.id);
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Card(
        child: ListTile(
          leading: ClipOval(
              child: Image.network(
                '${product.image}'+'?alt=media',
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                //fit: BoxFit.cover,
              ),
            ),
            title: Text(product.name),
            subtitle: product.blocked == 'yes' ? Text('Bloquedo') : product.stock == 'yes' ? Text('Toca para deshabilitar') : Text('Toca para habilitar'),
            selected: product.stock == 'yes' ? true : false,
            enabled: product.blocked == 'yes' ? false : true,
            //selected: true,
            trailing: Icon(Icons.more_vert), 
            onTap: ()async{
              if(product.stock == 'yes'){
                disp = 'no';
              }else{
                disp = 'yes';
              }
              await DatabaseService(uid: user.uid).changeProductStock(
                product.name,
                product.price,
                product.descrip,
                product.image,
                product.categoria,
                product.id,
                disp,
                product.blocked,
              );
            },
          ),
      ),
    );
  }
}