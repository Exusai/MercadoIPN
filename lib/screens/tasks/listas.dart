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
    final ped = Provider.of<List<Pedido>>(context) ?? [];
    final task = Provider.of<List<Task>>(context) ?? [];

    List<Pedido> pedidos = [];
    List<Task> tasks = [];

    ped.forEach((encargo){
      if(encargo.status == 'En camino'){
          pedidos.add(encargo);
      }
      if(encargo.status == 'Pendiente'){
          pedidos.add(encargo);
      }
    });

    ped.reversed.forEach((enc){
      if(enc.status == 'Entregado'){
        if (pedidos.length < 5){
          pedidos.add(enc);
        }
          
      }
      if(enc.status == 'Declinado'){
        if (pedidos.length < 5){
          pedidos.add(enc);
        }
      }
    });
    
    task.forEach((tarea){
      if(tarea.status == 'Pendiente'){
        tasks.add(tarea);
      }
      if(tarea.status == 'En camino'){
        tasks.add(tarea);
      }
    });

    task.reversed.forEach((tar){
      if(tar.status == 'Declinado'){
        if (tasks.length < 5){
          tasks.add(tar);
        }
      }
      if(tar.status == 'Entregado'){
        if (tasks.length < 5){
          tasks.add(tar);
        }
      }
    });

    List<Widget> pages = [
    pedidoW(pedidos),
    taskW(tasks),
  ];

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Theme(
        data: ThemeData(
          canvasColor: Color(0xffF2F2F2),
          //brightness: Brightness.dark
          //backgroundColor: Color(0xffE1DEE3)
        ),
      child: Scaffold(
        body: TabBarView(
          children: pages,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Color(0xffD9ADCA),
              borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
                )
            ),
            margin: EdgeInsets.only(),
            child: new TabBar(
              tabs: [
                Tab(text: 'Pedidos',icon: Icon(Icons.shopping_cart,)),
                Tab(text: 'Entregas',icon: Icon(Icons.schedule,)),
              ],
              unselectedLabelColor: Color(0xff000000),
              labelColor: Color(0xff8C035C),
              indicatorColor: Color(0xff8C035C),
            ), 
          ),
          )
    )
    );
    // return ListView(
    //   padding: EdgeInsets.symmetric(horizontal: 10),
    //   children: <Widget>[
    //     SizedBox(height: 10,),
    //     Text('Tus pedidos:',style: TextStyle(fontSize: 18)),
    //     Container(
    //       height: 200,
    //               child: ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: pedidos.length,
    //         itemBuilder: (context, index) {
    //         return PedidoCard(pedido: pedidos[index]);
    //         },
    //       ),
    //     ),

    //     Divider(color: Color(0xff707070),),

    //     SizedBox(height: 10,),
    //     Text('Tus productos por vender:',style: TextStyle(fontSize: 18),),
    //     Text('Toca para aceptar, manten presionado para declinar. Una vez aceptado, vuelve a tocar para marcar como entregado (esperando a ser recogido)'),
    //     Container(
    //       height: 200,
    //               child: ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: tasks.length,
    //         itemBuilder: (context, index) {
    //         return TaskCard(task: tasks[index]);
    //         },
    //       ),
    //     ),
    //     Divider(color: Color(0xff707070),),
    //   ],
    // );
  }
}

Widget pedidoW(pedidos) {
  // return ListView(
  //   padding: EdgeInsets.symmetric(horizontal: 10),
  //   children: <Widget>[
  //     SizedBox(height: 10,),
  //       Text('Tus pedidos:',style: TextStyle(fontSize: 18)),
  //       Text('Toca para más información'),
 return ListView.builder(
            shrinkWrap: true,
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
            return PedidoCard(pedido: pedidos[index]);
            },
          );
        
  //     ],
  // );
}

Widget taskW(tasks) {
  // return ListView(
  //   padding: EdgeInsets.symmetric(horizontal: 10),
  //   children: <Widget>[
  //     Text('Tus productos por vender:',style: TextStyle(fontSize: 18),),
  //       //Text('Toca para aceptar, manten presionado para declinar. Una vez aceptado, vuelve a tocar para marcar como entregado (esperando a ser recogido)'),
  //       Text('Toca para más información, al tocar Entregar, se envia una notificación al comprador'),
        return ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
            return TaskCard(task: tasks[index]);
            },
        );
        
      //],
  //);
}