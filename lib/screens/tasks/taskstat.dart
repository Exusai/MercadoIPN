//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/models/user.dart';
//import 'package:mercado_ipn/screens/tasks/view_task_pedido.dart';
import 'package:mercado_ipn/services/database.dart';
import 'package:provider/provider.dart';

import 'listas.dart';

class TaskStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
          return MultiProvider(
            providers: [
              StreamProvider<List<Pedido>>.value(value: DatabaseService(uid: user.uid).pedidoData,),
              StreamProvider<List<Task>>.value(value: DatabaseService(uid: user.uid).taskData,),
            ],
            child: Scaffold(
              backgroundColor: Color(0xffF2F2F2),
              appBar: AppBar(
                title: Text('Tus pedidos/entregas'),
                backgroundColor: Color(0xff8C035C),
                elevation: 0.0,
              ),
              body: ListaPedidos()
            ),
          );
  }
}