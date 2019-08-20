import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Animation<Color> _animationColor =
      AlwaysStoppedAnimation<Color>(Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xff2658B9),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("FIND MY BUS",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top:200.0),
              child: CircularProgressIndicator(valueColor: _animationColor,),
            )
          ],
        ),
      ),
    ));
  }
}

