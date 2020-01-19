import 'package:flutter/material.dart';
import 'package:mercado_ipn/screens/cuenta/Cuenta.dart';
import 'package:mercado_ipn/screens/home/home.dart';
import 'package:mercado_ipn/screens/vender/Vender.dart';

class MyHomePage extends StatefulWidget {
  static String tag = 'home-page';
  MyHomePage({Key key, this.title,}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //_MyHomePageState({this.uid});
  //final uid;
  
  List<Widget> pages = [
    Home(),
    Vender(),
    Cuenta(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                Tab(icon: Icon(Icons.store_mall_directory,)),
                Tab(icon: Icon(Icons.monetization_on,)),
                Tab(icon: Icon(Icons.account_circle,)),
              ],
              unselectedLabelColor: Color(0xff000000),
              labelColor: Color(0xff8C035C),
              indicatorColor: Color(0xff8C035C),
            ), 
          ),
          )
    )
    );
  }
}
