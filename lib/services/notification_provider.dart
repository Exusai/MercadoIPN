import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mercado_ipn/services/database.dart';

class PushNotificationProvider{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  
  Future initNotifications()async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token){
      // print('===FirebasemessToken===');
      // print(token);
      DatabaseService(uid: uid).upLoadToken(token);
    });

    _firebaseMessaging.configure(
      onMessage: (info){
        //  print('===Onmesage===');
        //  print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
        return null;
      },
      onLaunch: (info){
        //  print('===Onlaunch===');
        //  print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
        return null;
      },
      onResume: (info){
        //  print('===Onresume===');
        //  print(info);
        // print(info);
        // print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
        return null;
        // final noti = info['data']['comida']; 
        // print(noti);
      },
    );
  }

  dispose(){
    _mensajesStreamController.close();
  }
  

}