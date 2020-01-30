//import 'dart:js';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:date_format/date_format.dart';
//import 'package:mercado_ipn/models/user.dart';
//import 'package:mercado_ipn/screens/tasks/taskstat.dart';
//import 'package:mercado_ipn/services/database.dart';
import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
//import 'package:mercado_ipn/shared/loading.dart';
//import 'package:provider/provider.dart';
import 'buyform.dart';

String loc = '';

class ViewProduct extends StatelessWidget {
  final Product product;
  ViewProduct({this.product});
  @override
  Widget build(BuildContext context) {
    
    void _showDescPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          //color: Color.fromRGBO(0, 0, 0, 0.25),
          child: ListView(
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                child: Image.network('${product.image}'+'?alt=media',fit: BoxFit.cover,
                loadingBuilder: (context, child, progress){
                  return progress == null
                  ? child
                  :CircularProgressIndicator();//LinearProgressIndicator();
                },
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(product.name, style: TextStyle(letterSpacing: 3, fontSize: 20)),
                  //SizedBox(width: 40,),
                  Text('\$'+product.price, style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20), textAlign: TextAlign.right, ),
                ],
              ),
              //SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(product.categoria,style: TextStyle(fontSize: 18)),
                  FlatButton(
                        onPressed: (){
                          if (product.stock == 'no'){
                            print('que no hay');
                          }else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>BuyForm(product: product,)));
                          }
                        },
                        padding: EdgeInsets.all(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: product.stock == 'no' ? Colors.red : Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20.0)),
                              child: Text(product.stock == 'no' ? 'Agotado' : 'Ordenar', //Poner el precio del producto como en la appstore
                              style: TextStyle(color: Colors.white)
                              ),
                            ),
                      ),
                ],
              ),   
              //SizedBox(height: 10,),
              Text(product.descrip, style: TextStyle(fontSize: 15)),
              
              
            ],
          )
        );
      });
    }
    return Padding(
      //borderRadius: BorderRadius.circular(16.0),
      padding: EdgeInsets.all(3),
      child: FlatButton(
        padding: EdgeInsets.all(2),
        onPressed: (){
          _showDescPanel();
        },
              child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network('${product.image}'+'?alt=media', fit: BoxFit.cover,),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Wrap(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4.0,),),
                      //Text(product.name,//Seleccionar el vector que corresponde
                      //style: TextStyle(color: Colors.white, fontSize: 20.0)),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.0, bottom: 5.0, right: 5.0, top: 5.0),
                      //   child: FlatButton(
                      //     onPressed: (){
                      //       _showDescPanel();
                      //     },
                      //     child: Container(
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: 12.0, vertical: 6.0),
                      //         decoration: BoxDecoration(
                      //           color: Color(0xff8C035C),
                      //           borderRadius: BorderRadius.circular(20.0)),
                      //           child: Text('Ver', //Poner el precio del producto como en la appstore
                      //           style: TextStyle(color: Colors.white)
                      //           ),
                      //         ),
                      //   ),
                      //   )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _buyForm(BuildContext context, Product product) {
//   final _formkey = GlobalKey<FormState>();
//   final user = Provider.of<User>(context);
//   bool loading = false;
//   //bool swi = false;
//     return loading ? Loading():AlertDialog(
//       title: Text('Comprar: ' + product.name),
//       content: new Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // Container(
//           //   height: 150,
//           //   width: 150,
//           //   child: Image.network('${product.image}'+'?alt=media',fit: BoxFit.cover,),
//           // ),
//           Text('Precio: ' + '\$' + product.price,),
//           Text('Vendedor: '),
//           Text('Método de pago: efectivo (por ahora)'),
//           //Text(' usar tarjeta(?)^^^^^^^^'),
//           // Switch(
            
//           //   onChanged: (val) => !swi,
//           //   value: swi,
//           // ),
//           Text('Indica a donde quieres que se lleve tu producto: '),
//           Form(
//             key: _formkey,
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                      validator: (val) => val.isEmpty ? 'Ingresa a donde quieres que se lleve tu producto' : null,
//                      onChanged: (val){loc = val;},
//                      //keyboardType: TextInputType.emailAddress,
//                      autofocus: false,
//                      initialValue: '',
//                      decoration: InputDecoration(
//                        hintText: 'Se especifico',
//                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//                        ),
//                     ),
//               ],
//             ),
//           ),
          
//         ],
//       ),
//       actions: <Widget>[
//         new FlatButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           textColor: Colors.red,
//           child: const Text('Cancelar'),
//         ),
//         new FlatButton(
//           onPressed: () async{
//             loading = true;
//             if(_formkey.currentState.validate()){
//               //print(loc);
              
//               String now = formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd, '-',hh, '-',mm]);
//               String comp = await DatabaseService().usrData(user.uid);
//               String vend = await DatabaseService().usrData(product.propietario);
//               String tokV = await DatabaseService().usrTocken(product.propietario);
//               String tokC = await DatabaseService().usrTocken(user.uid);
//               //print(comp);
//               //print(vend);
//               await DatabaseService(uid: user.uid).uploadPedido(now, product.name, product.price, comp, vend, product.propietario, loc,tokV,tokC);
//               Navigator.of(context).pop();
//               Navigator.of(context).pop();
//               Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context)=>TaskStatus())
//                     );
//             }
//           },
//           child: Text('Comprar'),
//           textColor: Colors.green,
//         ),
//       ],
//     );
// }
