import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String mensaje = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                title: Text('Mensajes o algo así'),
                backgroundColor: Color(0xff8C035C),
                elevation: 0.0,
              ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          Text(mensaje),
          RaisedButton(
            child: Text('Presiona'),
            onPressed: ()async{
              await Firestore.instance.collection('Aviso').document('aviso').get().then((DocumentSnapshot ds) {
                setState(() { mensaje = ds.data['texto'].toString(); });
                //mensaje = ds.data['texto'].toString();
                
                //return tok;
                });
            },
          ),
        ],
      ),
    );
  }
}