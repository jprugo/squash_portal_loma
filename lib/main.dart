import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squash_portal_loma/model/Session.dart';
import 'package:squash_portal_loma/pages/LoginPage.dart';
import 'package:squash_portal_loma/pages/MainPage.dart';
import 'package:squash_portal_loma/pages/Splash.dart';

Future<Session> futureSession;
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<MyApp> {
  Future<Session> futureSession;

  @override
  void initState() {
    super.initState();
    futureSession = getSessionUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('es'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'Segoe UI',
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: futureSession,
        initialData: true,
        builder: (context, dataSnapshot) {
          switch (dataSnapshot.connectionState) {
            case ConnectionState.done:
              print(dataSnapshot.data.toString());
              if(dataSnapshot.data!=null){
                return MainPage(
                  u: dataSnapshot.data,
                );
              }else{
                return LoginPage();
              }

              break;

            default:
              return  Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Future<Session> getSessionUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String stringValue = prefs.getString('session');
    Session usuario;
    try {
      Session.fromJson(jsonDecode(stringValue));
    } catch (e) {
      print(e);
      //throw(e);
    }

    return usuario;
  }
}

/*
FutureBuilder(
        future: getSessionUser(),
        builder: (context, dataSnapshot) {
          if(dataSnapshot.connectionState== ConnectionState.done && dataSnapshot.hasData){
            return MainPage(u: dataSnapshot.data,);
          }else{
            print('no terminado');
            return LoginPage();
          }
        },
      ),
*/
