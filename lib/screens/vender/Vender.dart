import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mercado_ipn/services/database.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mercado_ipn/shared/loading.dart';

File image;
String filename;

class Vender extends StatefulWidget {
  @override
  _VenderState createState() => _VenderState();
}

class _VenderState extends State<Vender> {
  //final AuthService _auth = AuthService();
  //final user = Provider.of<User>();
  final _formkey = GlobalKey<FormState>();
  final List<String> categories = ['Comida','Dulces','Electronicos','Weas'];
  String productImage;
  String nombre;
  String descrip;
  //String uid = _auth.getCurrentUser();
  String error = '';
  String categoria;
  String precio;
  bool loading = false;

  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }
  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xff8C035C),
        title: Text('Vender'),
      ),
      backgroundColor: Color(0xffF2F2F2),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          children: <Widget>[
            Row(
                  children: <Widget>[
                    new Container(
                      height: 150.0,
                      width: 150.0,
                      //decoration: new BoxDecoration(
                          //border: new Border.all(color: Color(0xff8C035C))),
                      padding: new EdgeInsets.all(5.0),
                      child: image == null ? Text('Añadir imagen') : Image.file(image,fit: BoxFit.cover,),                      
                    ),
                    
                    // Divider(),
                    // //nuevo para llamar imagen de la galeria o capturarla con la camara
                    // new IconButton(
                    //     icon: new Icon(Icons.camera_alt), onPressed: pickerCam),
                    Divider(),
                    new IconButton(
                        icon: new Icon(Icons.image), onPressed: pickerGallery),
                  ],
                ),
                SizedBox(height: 15,),
             Form(
               key: _formkey,
               child: Column(
                 children: <Widget>[
                   TextFormField(
                     validator: (val) => val.isEmpty ? 'Nombre del producto' : null,
                     onChanged: (val){
                       setState(() => nombre = val);
                     },
                     
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Producto',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Ingresar descripción' : null,
                     onChanged: (val){
                       setState(() => descrip = val);
                     },
                     
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Descripción',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Ingresar una cantidad' : null,
                    
                     onChanged: (val){
                       setState(() => precio = val);
                     },
                     keyboardType: TextInputType.numberWithOptions(decimal: true),
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Precio',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                  // TextFormField(
                  //   validator: (val) => val.isEmpty ? 'Ingresar una categoría' : null,
                  //    onChanged: (val){
                  //      setState(() => categoria = val.toUpperCase());
                  //    },
                  //    autofocus: false,
                  //    initialValue: '',
                  //    decoration: InputDecoration(
                  //      hintText: 'Categoría',
                  //      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  //      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  //      ),
                  //   ),
                  DropdownButtonFormField(
                    onChanged: (val) => setState(()=>categoria = val.toString()),
                    value: categoria,
                    decoration: InputDecoration(
                      hintText: 'Categoría',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    items: categories.map((cate){
                      return DropdownMenuItem(
                        value: cate,
                        child: Text(cate),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 15,),
          ],
        ),
      ),
      RaisedButton(
               child: Text('Publicar',style: TextStyle(color: Colors.black)),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
               onPressed: () async{
                 if (_formkey.currentState.validate()){
                   setState(() => loading = true);
                   dynamic result = await FirebaseAuth.instance.currentUser();
                   String part1 = 'https://firebasestorage.googleapis.com/v0/b/mercado-ipn.appspot.com/o/';
                   String now = formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd, '-',hh, '-',mm]);
                   String prodimg = part1 + nombre + now + '.jpg';
                   String namae = nombre + now + '.jpg';
                   final StorageReference ref = FirebaseStorage.instance.ref().child(namae);
                   //final StorageUploadTask task = ref.putFile(image);
                   ref.putFile(image);
                   await DatabaseService(uid: result.uid).uploadProduct(nombre, precio, descrip,categoria,prodimg);
                   if (result.uid == null){
                     setState(() => loading = false);
                     setState(() => error = 'Algo ha pasado, intente más tarde');
                   }
                   setState(() => loading = false);
                   image = null;
                 }
               },
             ),
             SizedBox(height: 15,),
             Text(
               error,
               style: TextStyle(color: Colors.red, fontSize: 14.0),
               textAlign: TextAlign.center,
             )
          ]
        )
      )
    );
  }
}