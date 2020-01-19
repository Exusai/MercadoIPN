import 'package:flutter/material.dart';
import 'package:mercado_ipn/services/auth.dart';
import 'package:mercado_ipn/shared/loading.dart';
//import 'package:mercado_ipn/models/user.dart';

 class SingIn extends StatefulWidget {
   final Function toggleView;
   SingIn({this.toggleView});
   @override
   _SingInState createState() => _SingInState();
 }
 
 class _SingInState extends State<SingIn> {

   final AuthService _auth = AuthService();
   final _formkey = GlobalKey<FormState>();
   String email = '';
   String password = '';
   String error = '';
   String uID = '';
   bool loading = false;


   @override
   Widget build(BuildContext context) {
     return loading ? Loading() : Scaffold(
       backgroundColor: Color(0xffF2F2F2),
       body: Center(
         child: ListView(
           shrinkWrap: true,
           padding: EdgeInsets.only(left: 20.0, right: 20.0,top: 20.0),
           children: <Widget>[
             //Logo
             Image.asset('assets/logo/Mercado-IPN.png',height: 230,width: 230,),
             Form(
               key: _formkey,
               child: Column(
                 children: <Widget>[
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
               child: Text('Entrar',style: TextStyle(color: Colors.black)),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
               onPressed: () async{
                 if (_formkey.currentState.validate()){
                   setState(() => loading = true);
                   dynamic result = await _auth.singInWithEmailAndPassword(email, password);
                   if (result == null){
                     setState(() => loading = false);
                     setState(() => error = 'Ha ocurrido alguna clase de error');
                   }
                   //LogedUser().uID = result.uid;
                 }        
               },
             ),
             SizedBox(height: 15,),
             FlatButton(
               child: Text('Registrarse',style: TextStyle(color: Colors.black)),
               //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
               onPressed: (){
                 widget.toggleView();
               }
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
            //        //LogedUser().uID = result.uid;
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