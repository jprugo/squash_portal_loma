import 'package:flutter/cupertino.dart';

class Splash extends StatefulWidget {
  @override
  _splashState createState() {
    // TODO: implement createState
    return _splashState();
  }

}

class _splashState  extends State<Splash>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(

    children: [
      Container(
        height: height,
        width: width,
      ),
      
    ],
    );
  }

}