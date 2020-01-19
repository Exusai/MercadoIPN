//import 'dart:js';

import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/screens/tasks/view_task_pedido.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher_macos/url_launcher_macos.dart';

class ListaPedidos extends StatefulWidget {
  @override
  _ListaPedidosState createState() => _ListaPedidosState();
}

class _ListaPedidosState extends State<ListaPedidos> {
  @override
  Widget build(BuildContext context) {
    final pedidos = Provider.of<List<Pedido>>(context) ?? [];
    final tasks = Provider.of<List<Task>>(context) ?? [];
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: <Widget>[
        SizedBox(height: 10,),
        Text('Tus pedidos:',style: TextStyle(fontSize: 18)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: pedidos.length,
          itemBuilder: (context, index) {
          return PedidoCard(pedido: pedidos[index]);
          },
        ),

        Divider(color: Color(0xff707070),),

        SizedBox(height: 10,),
        Text('Tus productos por vender:',style: TextStyle(fontSize: 18),),
        Text('Toca para aceptar, manten presionado para declinar. Una vez aceptado, vuelve a tocar para marcar como entregado (esperando a ser recogido)'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
          return TaskCard(task: tasks[index]);
          },
        ),
        Divider(color: Color(0xff707070),),
      ],
    );
  }
}