import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/services/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
            subtitle: Text(pedido.status, style: TextStyle(color: pedido.status == 'Entregado'? Colors.greenAccent: 
            pedido.status == 'Declinado'?Colors.red:Colors.grey),),
            trailing: Icon(Icons.more_vert,),
            //isThreeLine: true,
            selected: pedido.status == 'En camino' ? true : false,
            //enabled: pedido.status == 'Declinado' ? false : true,
            onTap: (){
               showDialog(
                    context: context,
                    builder: (BuildContext context) => statusPedido(context, pedido));
              
            },
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
              subtitle: Text('///'+task.status+'///'+' ---'+ task.fecha.substring(8,10)+'/'+task.fecha.substring(5,7) + ' a las ' +task.fecha.substring(11,13)+':'+task.fecha.substring(14) + '--- '+'Llevar a: '+task.punto.toString(),
              style: TextStyle(color: task.status == 'Entregado'? Colors.greenAccent: Colors.grey)
              ),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
              selected: task.status == 'En camino' ? true : false,
              enabled: task.status == 'Declinado' ? false : task.status == 'Entregado' ? false : true,
              onTap: ()async{
                showDialog(
                    context: context,
                    builder: (BuildContext context) => statusTask(context, task));
              },
              // onTap: () async{
              //   String tokV = await DatabaseService().usrTocken(task.idvendedor);
              //   String tokC = await DatabaseService().usrTocken(task.idcomp);
              //   if (task.status == 'En camino'){
              //     await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'Entregado', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
              //   }
              //   if (task.status == 'Pendiente'){
              //     await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'En camino', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
              //   }
              //   },
              // onLongPress:()async{
              //   String tokV = await DatabaseService().usrTocken(task.idvendedor);
              //   String tokC = await DatabaseService().usrTocken(task.idcomp);
              //   await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'Declinado', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
              // } ,
            ),
          ),
        );
  }
}


Widget statusPedido(BuildContext context, Pedido pedido) {
    return AlertDialog(
      title: Text(pedido.producto),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Precio: ' + '\$' + pedido.costo),
          Text('Vendedor: ' + pedido.vendedor),
          Text('Punto de entrega: '+pedido.punto),
          Text(pedido.fecha.substring(8,10)+'/'+pedido.fecha.substring(5,7)+'/'+pedido.fecha.substring(0,4) + ' a las ' +pedido.fecha.substring(11,13)+':'+pedido.fecha.substring(14),),
          Text('Status: '+pedido.status),
        ],
      ),
    );
}

Widget statusTask(BuildContext context, Task task) {
    return FlutterEasyLoading(
      child: AlertDialog(
        title: Text(task.producto),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Precio: ' + '\$' + task.costo),
            Text('Comprador: ' + task.comprador),
            Text(task.fecha.substring(8,10)+'/'+task.fecha.substring(5,7)+'/'+task.fecha.substring(0,4) + ' a las ' +task.fecha.substring(11,13)+':'+task.fecha.substring(14),),
            Text('Entregar en: '+task.punto.toString()),
            Text('Status: '+task.status),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: ()async{
              EasyLoading.show(status: 'Cargando...');
              String tokV = await DatabaseService().usrTocken(task.idvendedor);
              String tokC = await DatabaseService().usrTocken(task.idcomp);
              await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'Declinado', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
              EasyLoading.showSuccess('Listo');
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20.0)),
                  child: Text('Declinar', //Poner el precio del producto como en la appstore
                  style: TextStyle(color: Colors.white)
                  ),
              ),
          ),
          FlatButton(
            onPressed: ()async{
              EasyLoading.show(status: 'Cargando...');
              String tokV = await DatabaseService().usrTocken(task.idvendedor);
              String tokC = await DatabaseService().usrTocken(task.idcomp);
              await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'En camino', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
              EasyLoading.showSuccess('Listo');
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(20.0)),
                  child: Text('Aceptar', //Poner el precio del producto como en la appstore
                  style: TextStyle(color: Colors.white)
                  ),
              ),
          ),
          FlatButton(
            onPressed: ()async{
              EasyLoading.show(status: 'Cargando...');
              String tokV = await DatabaseService().usrTocken(task.idvendedor);
              String tokC = await DatabaseService().usrTocken(task.idcomp);
              await DatabaseService().changeTaskPedidoStatus(task.idvendedor, task.idcomp, task.clave, 'Entregado', task.producto, task.fecha, task.costo, task.comprador, task.vendedor, task.punto,tokV,tokC);
              EasyLoading.showSuccess('Listo');
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20.0)),
                  child: Text('Entregar', //Poner el precio del producto como en la appstore
                  style: TextStyle(color: Colors.white)
                  ),
              ),
          ),
          // FlatButton(
          //   onPressed: (){},
          //   padding: EdgeInsets.all(0),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 12.0, vertical: 6.0),
          //       decoration: BoxDecoration(
          //         color: Colors.greenAccent,
          //         borderRadius: BorderRadius.circular(20.0)),
          //         child: Text('Entregado', //Poner el precio del producto como en la appstore
          //         style: TextStyle(color: Colors.white)
          //         ),
          //     ),
          // ),
        ],
      ),
    );
}