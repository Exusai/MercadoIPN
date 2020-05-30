import 'package:flutter/material.dart';
import 'package:mercado_ipn/models/user.dart';
import 'package:mercado_ipn/screens/home/mensagepasge.dart';
import 'package:mercado_ipn/services/auth.dart';
import 'package:mercado_ipn/shared/loading.dart';
import 'package:mercado_ipn/services/database.dart';
import 'package:provider/provider.dart';
import 'usrprodlist.dart';
import 'package:url_launcher/url_launcher.dart';


class Cuenta extends StatefulWidget {
  @override
  _CuentaState createState() => _CuentaState();
}

class _CuentaState extends State<Cuenta> {
  final AuthService _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return Scaffold(
              backgroundColor: Color(0xffF2F2F2),
              appBar: AppBar(
                title: Text('Cuenta'),
                centerTitle: false,
                backgroundColor: Color(0xff8C035C),
                elevation: 0.0,
                // actions: <Widget>[
                //   FlatButton.icon(
                //     icon: Icon(Icons.person,color: Colors.white,),
                //     label: Text('Log Out',style: TextStyle(color: Colors.white),),
                //     onPressed: () async{
                //     loading = true;
                //     await _auth.singOut();
                //   },
                //   ),
                // ],
                
            ),
            //body: Usuario(),
            body: ListView(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              children: <Widget>[
                SizedBox(height: 20,),
                //Image.asset('assets/avatar/avatar.png',height: 150,width: 150,),
                // CircleAvatar(
                //   radius: 30.0,
                //   backgroundImage: userData.img == 'hanna' ? Image.asset('assets/avatar/avatar.png',height: 150,width: 150,) : Image.network(
                //     userData.img
                //   ),
                //   backgroundColor: Colors.transparent,
                // ),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child:  ClipRRect(
                      borderRadius: new BorderRadius.circular(100.0),
                      child: userData.img == 'hanna' ? Image.asset('assets/avatar/avatar.png',height: 200,width: 200,) : Image.network('${userData.img}'+'?alt=media',height: 200,width: 200, fit:BoxFit.cover,
                      loadingBuilder: (context, child, progress){
                        return progress == null
                        ? child
                        :CircularProgressIndicator();
                      },
                      ),
                      ),
                ),
                SizedBox(height: 10,),
                Text(userData.nombre + ' ' + userData.apellido, style: TextStyle(fontSize: 25,), textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Text(userData.escuela, style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic), textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Divider(
                  color: Color(0xff707070),
                ),
                //SizedBox(height: 20,),
                FlatButton(
                  child: Text('Editar Cuenta',style: TextStyle(color: Colors.black,fontSize: 18)),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                  onPressed: () async{
                  },
                ),
                FlatButton(
                  child: Text('LogOut',style: TextStyle(color: Colors.black,fontSize: 18)),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                  onPressed: () async{
                    loading = true;
                    await _auth.singOut();
                  },
                ),
                FlatButton(
                  child: Text('About',style: TextStyle(color: Colors.black,fontSize: 18)),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildAboutDialog(context),
                    );
                  },
                ),
                FlatButton(
                  child: Text('Avisos',style: TextStyle(color: Colors.black,fontSize: 18)),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>MessagePage())
                    );
                  },
                ),
                FlatButton(
                  child: Text('Actualizar',style: TextStyle(color: Colors.black,fontSize: 18)),
                  onPressed: ()async{
                    const url = 'https://exusai.github.io/MercadoIPN/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                //SizedBox(height: 20,),
                Divider(
                  color: Color(0xff707070),
                ),
                //SizedBox(height: 20,),
                FlatButton(
                  child: Text('Administrar productos',style: TextStyle(color: Colors.black,fontSize: 18)),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>UsrProductList())
                    );
                  },
                ),
                // StreamBuilder(
                //    stream: DatabaseService().products,
                //    builder: (context, snapshot){
                //      return StreamProvider<List<Product>>.value(
                //        value: DatabaseService().products,
                //        child: UsuarioProd(),
                //      );
                //    },
                //  ),
                //StreamProvider<List<Product>>.value(value: DatabaseService().products,child: UsuarioProd()),
              ],
            ),
          ); 
        }else{
          return Loading();
        }
        
      },
    );
  }
}

Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('About...'),
      content: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          width: 200,
          height: 300,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              Image.asset('assets/avatar/avatar2.png',height: 150,width: 150,),
              SizedBox(height: 10,),
              Text('chicas.gato@gmail.com',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 18)),
              SizedBox(height: 10,),
              Divider(color: Color(0xff707070),),
              FlatButton(
                  child: Text('Github',style: TextStyle(color: Colors.black,fontSize: 18)),
                  onPressed: ()async{
                    const url = 'https://github.com/Exusai';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              FlatButton(
                  child: Text('Sitio',style: TextStyle(color: Colors.black,fontSize: 18)),
                  onPressed: ()async{
                    const url = 'https://exusai.github.io/MercadoIPN/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              
            ],
          ),
        ),
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        // children: <Widget>[
        //   Image.asset('assets/avatar/avatar2.png',height: 150,width: 150,),
        //   Text('ola'),
          
        // ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Ok'),
        ),
      ],
    );
}
