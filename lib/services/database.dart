import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercado_ipn/models/product.dart';
import 'package:mercado_ipn/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  
  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('Usuarios');
  

  Future updateUserData(String nombre, String apellido, String escuela, String usrimg) async{
    return await userCollection.document(uid).setData({
      'nombre': nombre,
      'apellido': apellido,
      'escuela': escuela,
      'imagen' : usrimg
    });
  }

  Future upLoadToken(String tock)async{
    return await userCollection.document(uid).collection('Token').document('Token').setData({
      'token':tock,
    });
  }

  final CollectionReference productCollection = Firestore.instance.collection('Productos');
  Future uploadProduct(String nombre, String precio, String descrip,String categoria,String prodimg) async{
    dynamic kore = productCollection.document();
    return await kore.setData({
      'nombre': nombre,
      'precio': precio,
      'descripción': descrip,
      'imagen': prodimg,
      'propietario': uid,
      'categoria': categoria,
      'id' : kore.documentID.toString(),
      'disponible': 'yes',
      'blocked' : 'no',
    });
  }

  //final CollectionReference pedidoCollection = Firestore.instance.collection('Usuarios').document(uid).collection('Pedido');
  Future uploadPedido(String fecha,String prod, String costo,String comp,String vend,String idvend,String loc,String tokV,String tokC) async{
    dynamic pedido = userCollection.document(uid).collection('Pedido').document();
    await pedido.setData({
      'Status' : 'Pendiente',
      'Clave' : pedido.documentID.toString(),
      'Producto': prod,
      'Fecha' : fecha,
      'Costo' : costo,
      'Comprador' : comp,
      'idComp': uid,
      'Vendedor' : vend,
      'idVendedor' : idvend, 
      'Punto de encuentro' : loc,
      'VendToken':tokV,
    });
    dynamic task = userCollection.document(idvend).collection('Task').document(pedido.documentID.toString());
    await task.setData({
      'Status' : 'Pendiente',
      'Clave' : pedido.documentID.toString(),
      'Producto': prod,
      'Fecha' : fecha,
      'Costo' : costo,
      'Comprador' : comp,
      'idComp':uid,
      'Vendedor' : vend,
      'idVendedor' : idvend, 
      'Punto de encuentro' : loc,
      'CompToken':tokC, 
    });
  }

  Future changeProductStock(String nombre,String precio, String descrip, String prodimg, String categoria,String productId, String stock, String blocked) async{
    return await productCollection.document(productId).setData({
      'nombre': nombre,
      'precio': precio,
      'descripción': descrip,
      'imagen': prodimg,
      'propietario': uid,
      'categoria': categoria,
      'id' : productId,
      'disponible' : stock,
      'blocked' : blocked,
    });
  }

  Future changeTaskPedidoStatus(String idvend, String idcomp,String clave,String stat,String prod,String fecha,String costo,String comp,String vend,String loc,String tokV,String tokC)async{
    await userCollection.document(idcomp).collection('Pedido').document(clave).setData({
      'Status' : stat,
      'Clave' : clave,
      'Producto': prod,
      'Fecha' : fecha,
      'Costo' : costo,
      'Comprador' : comp,
      'idComp': idcomp,
      'Vendedor' : vend,
      'idVendedor' : idvend, 
      'Punto de encuentro' : loc,
      'VendToken':tokV,
      
    });
    await userCollection.document(idvend).collection('Task').document(clave).setData({
      'Status' : stat,
      'Clave' : clave,
      'Producto': prod,
      'Fecha' : fecha,
      'Costo' : costo,
      'Comprador' : comp,
      'idComp': idcomp,
      'Vendedor' : vend,
      'idVendedor' : idvend, 
      'Punto de encuentro' : loc,
      'CompToken':tokC, 
  
    });
  }

  Future checkUserInfo()async{
    return await userCollection.document(uid).get();
  }
  
  

  //prod list from snapshot
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Product(
        name: doc.data['nombre'] ?? '',
        descrip: doc.data['descripción'] ?? '',
        stock: doc.data['disponible'] ?? '',
        categoria: doc.data['categoria'] ?? '',
        price: doc.data['precio'] ?? '',
        image: doc.data['imagen'] ?? '',
        propietario: doc.data['propietario'] ?? '',
        id: doc.data['id'] ?? '',
        blocked: doc.data['blocked'] ?? '',
      );
    }).toList();
  }

  //usr data from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      nombre: snapshot.data['nombre'],
      apellido: snapshot.data['apellido'],
      escuela: snapshot.data['escuela'],
      img: snapshot.data['imagen'],
    );
  }

  //task data from snapshot
  List<Task> _taskFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
    return Task(
      clave: doc.data['Clave'],
      comprador: doc.data['Comprador'],
      costo: doc.data['Costo'],
      fecha: doc.data['Fecha'],
      producto: doc.data['Producto'],
      punto: doc.data['Punto de encuentro'],
      status: doc.data['Status'],
      vendedor: doc.data['Vendedor'],
      idcomp: doc.data['idComp'],
      idvendedor: doc.data['idVendedor'],
    );
    }).toList();
  }

  //pedido data from snapshot
  List<Pedido> _pedidoFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
    return Pedido(
      clave: doc.data['Clave'],
      comprador: doc.data['Comprador'],
      costo: doc.data['Costo'],
      fecha: doc.data['Fecha'],
      producto: doc.data['Producto'],
      punto: doc.data['Punto de encuentro'],
      status: doc.data['Status'],
      vendedor: doc.data['Vendedor'],
      idcomp: doc.data['idComp'],
      idvendedor: doc.data['idVendedor'],
    );
    }).toList();
  }

  Future usrData(ident)async{
    //String namae;
    return await userCollection.document(ident).get().then((DocumentSnapshot ds) {
      // use ds as a snapshot
      var namae = ds.data['nombre']; //+ ' ' + ds.data['apellido']; 
      return namae;
      //print(ds.data['nombre']);
    });
    //return namae;
  }

  Future usrTocken(id)async{
    return await userCollection.document(id).collection('Token').document('Token').get().then((DocumentSnapshot ds) {
      var tok = ds.data['token'].toString();
      return tok;
    });
  }

  //get user docstream
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

  //get Task docstream
  Stream<List<Task>> get taskData{
    return userCollection.document(uid).collection('Task').snapshots().map(_taskFromSnapShot);
  }

  //get Pedido docstream
  Stream<List<Pedido>> get pedidoData{
    return userCollection.document(uid).collection('Pedido').snapshots().map(_pedidoFromSnapShot);
  }

  // get stream 
  Stream<List<Product>> get products{
    return productCollection.snapshots().map(_productListFromSnapshot); 
  }

  Stream<QuerySnapshot> get userChanges{
    return userCollection.snapshots();
  }
}