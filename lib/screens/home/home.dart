import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/screens/tasks/taskstat.dart';
import 'package:mercado_ipn/services/database.dart';
import 'package:mercado_ipn/services/notification_provider.dart';
//import 'package:mercado_ipn/shared/loading.dart';
import 'package:provider/provider.dart';
//import 'package:mercado_ipn/services/database.dart';
import 'package:mercado_ipn/screens/home/productlist.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercado_ipn/services/auth.dart';


class Home extends StatefulWidget {
  //final AuthService auth = AuthService();
  final uid;
  Home({this.uid});
  @override
  _HomeState createState() => _HomeState(uid: uid);
}

class _HomeState extends State<Home> {
  final uid;
  _HomeState({this.uid});
  final AuthService auth = AuthService();
  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    pushProvider.mensajes.listen((argumento){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>TaskStatus())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    
    return StreamProvider<List<Product>>.value(
      value: DatabaseService().products,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          title: Text('Mercado IPN'),
          centerTitle: false,
          backgroundColor: Color(0xff8C035C),
          elevation: 0.0,
          actions: <Widget>[
            // FlatButton.icon(
            //   icon: Icon(Icons.search,color: Colors.white,),
            //   label: Text('Buscar',style: TextStyle(color: Colors.white),),
            //   onPressed: (){},
            // ),
            // FlatButton.icon(
            //         icon: Icon(Icons.person,color: Colors.white,),
            //         label: Text('Log Out',style: TextStyle(color: Colors.white),),
            //         onPressed: () async{
            //         //loading = true;
            //         await _auth.singOut();
            //       },
            //       ),
            FlatButton.icon(
              icon: Icon(Icons.notifications, color: Colors.redAccent),
              label: Text(''),
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>TaskStatus())
                    );
              },
            ),
          ],
        ),
        body: ProductList(),
      ),
    );
  }
}