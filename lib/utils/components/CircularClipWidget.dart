import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:squash_portal_loma/utils/CircularClipper.dart';


class CircularClipWidget extends StatelessWidget{

  final  title;
  final  subtitle;
  final Color color;
  final width;

  CircularClipWidget({@required this.title, @required this.color, @required this.subtitle, @required this.width});

  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      clipper: CircularClipper(),
      child: Container(
        width: width,
        color: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(padding: EdgeInsets.all(20),
            child: Text(title , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40), textAlign: TextAlign.center,),),
            Padding(padding: EdgeInsets.all(20),
              child: Text(subtitle, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40), textAlign: TextAlign.center,),),
          ],
        ),
      ),
    );

  }


}