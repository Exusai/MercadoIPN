//import 'dart:ffi';

class Product {
  final String name;
  final String stock;
  final String categoria;
  final String image;
  final String price;
  final String propietario;
  final String descrip;
  final String id;
  final String blocked;

  Product({this.name,this.stock,this.categoria,this.image,this.price,this.propietario,this.descrip,this.id,this.blocked});
}

class Pedido{
  final String clave;
  final String comprador;
  final String costo;
  final String fecha;
  final String producto;
  final String punto;
  final String status;
  final String vendedor;
  final String idcomp;
  final String idvendedor;

  Pedido({
    this.clave,
    this.comprador,
    this.costo,
    this.fecha,
    this.idvendedor,
    this.producto,
    this.punto,
    this.status,
    this.idcomp,
    this.vendedor,
  });
}

class Task{
  final String clave;
  final String comprador;
  final String costo;
  final String fecha;
  final String producto;
  final String punto;
  final String status;
  final String vendedor;
  final String idcomp;
  final String idvendedor;

  Task({
    this.clave,
    this.comprador,
    this.costo,
    this.fecha,
    this.idvendedor,
    this.producto,
    this.punto,
    this.status,
    this.idcomp,
    this.vendedor,
  });
}