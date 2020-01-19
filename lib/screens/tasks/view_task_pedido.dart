import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/services/database.dart';

class PedidoCard extends StatelessWidget {
  final Pedido pedido;
  PedidoCard({this.pedido});
  @override
  Widget build(BuildContext context) {
    return Card(
          child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ListTile(
            title: Text(pedido.producto + ' (\$'  + pedido.costo + ')'),
            subtitle: Text(pedido.status),
            trailing: Icon(Icons.more_vert,),
            isThreeLine: true,
            selected: pedido.status == 'En camino' ? true : false,
            enabled: pedido.status == 'Declinado' ? false : true,
          ),
        ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  TaskCard({this.task});
  @override
  Widget build(BuildContext context) {
    return Card(
          child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ListTile(
              title: Text('Llevar ' + task.producto + ' a ' + task.comprador),
              subtitle: Text('///'+task.status+'///'+' ---'+ task.fecha.substring(8,10)+'/'+task.fecha.substring(5,7) + ' a las ' +task.fecha.substring(11,13)+':'+task.fecha.substring(14) + '--- '+'Llevar a: '+ task.punto),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
              selected: task.status == 'En camino' ? true : false,
              enabled: task.status == 'Declinado' ? false : true,
              onTap: () async{
                String tokV = await DatabaseService().usrTocken(task.idvendedor);
                String tokC = await DatabaseService().usrTocken(task.idcomp);
                if (task.status == 'En camino'){
                  await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'Entregado', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
                }
                if (task.status == 'Pendiente'){
                  await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'En camino', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
                }
                },
              onLongPress:()async{
                String tokV = await DatabaseService().usrTocken(task.idvendedor);
                String tokC = await DatabaseService().usrTocken(task.idcomp);
                await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'Declinado', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
              } ,
            ),
          ),
        );
  }
}


