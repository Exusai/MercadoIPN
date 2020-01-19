import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:mercado_ipn/screens/vender/Vender.dart';
//import 'package:mercado_ipn/screens/vender/Vender.dart';
import 'package:mercado_ipn/services/auth.dart';
import 'package:mercado_ipn/shared/loading.dart';
import 'package:mercado_ipn/services/database.dart';
//import 'package:mercado_ipn/models/user.dart';


File image;

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String escuela = '';
  String nombre = '';
  String email = '';
  String password = '';
  String error = '';
  String apellido = '';
  bool loading = false;
  
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
    return loading ? Loading() : Scaffold(
       backgroundColor: Color(0xffF2F2F2),
       appBar: AppBar(
         title: Text('Registro'),
         centerTitle: false,
         backgroundColor: Color(0xff8C035C),
         actions: <Widget>[
           FlatButton.icon(
             icon: Icon(Icons.person,color: Colors.white,),
             label: Text('Entrar con mi cuenta',style: TextStyle(color: Colors.white)),
             onPressed: (){
               widget.toggleView();
             },             
           ),
         ],
       ),
       body: Center(
         child: ListView(
           shrinkWrap: true,
           padding: EdgeInsets.only(left: 20.0, right: 20.0),
           children: <Widget>[
             //Image.asset('assets/avatar/avatar.png',height: 150,width: 150,),
             Text('Toca para seleccionar imagen',style: TextStyle(fontSize: 17)),
             SizedBox(height: 15,),
             FlatButton(
               onPressed: pickerGallery,
               padding: EdgeInsets.all(0.0),
               child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        child:  ClipRRect(
                            borderRadius: new BorderRadius.circular(100.0),
                            child: image == null ? Image.asset('assets/avatar/avatar.png',height: 200,width: 200,) : Image.file(image,height: 200,width: 200,fit: BoxFit.cover,),
                            ),
                      ),
             ),
             SizedBox(height: 15,),
             Form(
               key: _formkey,
               child: Column(
                 children: <Widget>[
                   TextFormField(
                     validator: (val) => val.isEmpty ? 'Ingresar un nombre' : null,
                     onChanged: (val){
                       setState(() => nombre = val.toUpperCase());
                     },
                     //keyboardType: TextInputType.emailAddress,
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Nombre',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Ingresar un apellido' : null,
                     onChanged: (val){
                       setState(() => apellido = val.toUpperCase());
                     },
                     //keyboardType: TextInputType.emailAddress,
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Apellido',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Ingresar una escuela' : null,
                     onChanged: (val){
                       setState(() => escuela = val.toUpperCase());
                     },
                     //keyboardType: TextInputType.emailAddress,
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Escuela',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                   TextFormField(
                     validator: (val) => val.isEmpty ? 'Ingresar un correo' : null,
                     onChanged: (val){
                       setState(() => email = val);
                     },
                     keyboardType: TextInputType.emailAddress,
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Correo',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (val) => val.length < 6 ? 'Ingresar contraseña de 6 o más carácteres' : null,
                     onChanged: (val){
                       setState(() => password = val);
                     },
                     obscureText: true,
                     autofocus: false,
                     initialValue: '',
                     decoration: InputDecoration(
                       hintText: 'Contraseña',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       ),
                    ),
                  SizedBox(height: 15,),
                 ],
               ),
             ),
             RaisedButton(
               child: Text('Registrar',style: TextStyle(color: Colors.black)),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
               onPressed: () async{
                 if (_formkey.currentState.validate()){
                   setState(() => loading = true);
                   dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                   if (result == null){
                     setState(() => loading = false);
                     setState(() => error = 'Ingrese un correo electronico válido');
                   }
                   String part1 = 'https://firebasestorage.googleapis.com/v0/b/mercado-ipn.appspot.com/o/usr%2F';
                   String now = formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd, '-',hh, '-',mm]);
                   String usrimg = part1 + nombre + apellido + escuela + now + '.jpg';
                   String namae = nombre + apellido + escuela + now + '.jpg';
                   image == null ? usrimg = 'hanna' : FirebaseStorage.instance.ref().child("usr/" + namae).putFile(image);
                   //ref.putFile(image);
                   await DatabaseService(uid: result.uid).updateUserData(nombre, apellido, escuela, usrimg);
                   
                 }
               },
             ),
            //  FlatButton(
            //    child: Text('Entrar sin cuenta',style: TextStyle(color: Colors.black)),
            //    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
            //    onPressed: () async{
            //      setState(() => loading = true);
            //      dynamic result = await _auth.singInAnon(); 
            //      if (result == null){
            //        setState(() => loading = false);
            //        print('error singing in');
            //      } else  {
            //        print('singed');
            //        print(result.uid);
                  
            //      }
            //    },
            //  ),
             SizedBox(height: 15,),
             Text(
               error,
               style: TextStyle(color: Colors.red, fontSize: 14.0),
               textAlign: TextAlign.center,
             ),
           ],
         ),
       ),
     );
  }
}

class StorageReference {
}