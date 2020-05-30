import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/models/user.dart';
import 'package:mercado_ipn/screens/tasks/taskstat.dart';
import 'package:mercado_ipn/services/database.dart';
import 'package:mercado_ipn/shared/loading.dart';
import 'package:provider/provider.dart';

class BuyForm extends StatefulWidget {
  final Product product;
  BuyForm({this.product});
  @override
  _BuyFormState createState() => _BuyFormState(product: product);
}

class _BuyFormState extends State<BuyForm> {
  bool loading = false;
  final Product product;
  final _formkey = GlobalKey<FormState>();
  String loc;
  _BuyFormState({this.product});
  String msg='';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(product.propietario == user.uid){
      msg = 'Por la integridad de mi base de datos, no debes comprarte tus productos';
    }
    return loading ? Loading(): Scaffold(
      backgroundColor: Color(0xffF2F2F2),
              appBar: AppBar(
                title: Text('Comprar'),
                backgroundColor: Color(0xff8C035C),
                elevation: 0.0,
              ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          SizedBox(height: 20,),
          Text('Comprar:'+' '+product.name,textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),
          CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child:  ClipRRect(
                      borderRadius: new BorderRadius.circular(100.0),
                      child: Image.network('${product.image}'+'?alt=media',height: 200,width: 200, fit:BoxFit.cover,
                      loadingBuilder: (context, child, progress){
                        return progress == null
                        ? child
                        :CircularProgressIndicator();
                      },
                      ),
                      ),
                ),
          Text('Precio: ' + '\$' + product.price,style: TextStyle(fontSize: 18)),
          Text('Vendedor: ',style: TextStyle(fontSize: 18)),
          Text('Método de pago: efectivo (por ahora)',style: TextStyle(fontSize: 18)),
          Text('Indica a donde quieres que se lleve tu producto: ',style: TextStyle(fontSize: 18)),
          Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                     validator: (val) => val.isEmpty ? 'Ingresa a donde quieres que se lleve tu producto' : null,
                     onChanged: (val){loc = val;},
                     //keyboardType: TextInputType.emailAddress,
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Se especifico',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                textColor: Colors.red,
                child: const Text('Cancelar'),
              ),
              FlatButton(
                        onPressed: ()async{
                          if (_formkey.currentState.validate()){
                        setState(() => loading = true);
                        String now = formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd, '-',hh, '-',mm]);
                        String comp = await DatabaseService().usrData(user.uid);
                        String vend = await DatabaseService().usrData(product.propietario);
                        String tokV = await DatabaseService().usrTocken(product.propietario);
                        String tokC = await DatabaseService().usrTocken(user.uid);
                        //print(comp);
                        //print(vend);
                        await DatabaseService(uid: user.uid).uploadPedido(now, product.name, product.price, comp, vend, product.propietario, loc,tokV,tokC);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>TaskStatus())
                              );
                          }
                        },
                        padding: EdgeInsets.all(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: product.propietario == user.uid ? Colors.red : Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20.0)),
                              child: Text(product.propietario == user.uid ? 'No te puedes comprar solo' : 'Comprar', //Poner el precio del producto como en la appstore
                              style: TextStyle(color: Colors.white)
                              ),
                            ),
                      ),
                      
            ],
          ),
          SizedBox(height: 20,),
          Text(msg,style: TextStyle(color: Colors.red),textAlign: TextAlign.center,)
        ],
        
      ),
    );
  }
}