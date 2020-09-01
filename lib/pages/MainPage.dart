import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:squash_portal_loma/model/Reserva.dart';
import 'package:squash_portal_loma/model/Session.dart';
import 'package:squash_portal_loma/pages/CalendarPage.dart';
import 'package:squash_portal_loma/utils/components/CircularClipWidget.dart';
import 'package:http/http.dart' as http;
import 'package:squash_portal_loma/utils/strings/Strings.dart';
import 'package:toast/toast.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key, @required this.u}) : super(key: key);
  final Session u;
  @override
  State createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  DateTime selectedDate;

  static final HOUR = 'Seleccione horario';
  static final NOT_RESERVATION = 'No tiene reservas';

  String hora = '';
  var formatter;
  bool isReserved = false;
  bool hasReservesFor2Day = false;
  ReservaClass reservation;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    formatter = DateFormat('yyyy-MM-dd');
    _validateIfHasReservation();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: width,
            height: height,
          ),
          CircularClipWidget(
            title: 'Portal de la Loma',
            color: const Color(0xfff8cb87),
            subtitle: 'Squash',
            width: width,
          ),
          Positioned(
            bottom: 20,
            left: 5,
            right: 5,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    width: width * 0.80,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Reservas',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: _textReservation(
                                text: hasReservesFor2Day
                                    ? 'A las y pico'
                                    : NOT_RESERVATION)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: width * 0.80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('Crear', style: TextStyle(fontSize: 30)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                size: 30,
                              ),
                              onPressed: () {
                                _navigateAndRetrieveData(context);
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: _textReservation(
                              text: isReserved
                                  ? formatter.format(selectedDate) + '\n' + hora
                                  : HOUR),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: RaisedButton(
                              color: const Color(0xff709BFF),
                              child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Center(
                                    child: Text(
                                      'Guardar',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onPressed: () {_saveReservation();}),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textReservation({text}) {
    return Text(
      text,
      style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
    );
  }

  _navigateAndRetrieveData(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarPage()),
    ).then((val) {
      setState(() {
        if(val!=null){
          if (!val.isEmpty) {
            isReserved = true;
            selectedDate = val.first;
            hora = val.last;
          }
        }

      });
    });
  }

  void _validateIfHasReservation() async {
    final response = await http
        .get(urlFetchValidarReservas + 'idUser=${widget.u.idUsuario}');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      var body = jsonDecode(response.body);
      SessionClass u = SessionClass.fromJson(body);
      if (u.hasData) {
      } else {

      }
    } else {
      Toast.show("Hubo un error, recuperando tus datos", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      throw Exception('Failed to get reservations');
    }
  }

  void _saveReservation() async {
    final response = await http.post(urlReservar, body: {
      'idUser': widget.u.idUsuario,
      'idFranja': reservation.reseva.franjaHorariaIdFranjaHoraria,
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      if (response.body.contains("OK")) {
        setState(() {
          isReserved = false;
          hora = '';
        });
        Toast.show("Registro guardado", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }else{
        Toast.show("No se pudo guardar", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      throw Exception('Failed to get reservations');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
