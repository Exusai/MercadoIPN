import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF2F2F2),
      child: Center(
        child: SpinKitDoubleBounce(
          color: Color(0xff8C035C),
          size: 50.0,
        ),
      ),
    );
  }
}