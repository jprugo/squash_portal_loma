import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squash_portal_loma/utils/components/CircularClipWidget.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  DateTime selectedDate;
  TimeOfDay selectedTime;
  @override
  void initState() {
    super.initState();
    selectedDate=DateTime.now();
    selectedTime= new TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(width: width, height: height,),

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
                    width: width*0.80,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.all(10),
                          child: Text('Reservas', style: TextStyle( fontSize: 30),),),
                        Padding(padding: EdgeInsets.all(20),
                          child: Text('No tiene', style: TextStyle( fontSize: 30, fontStyle:FontStyle.italic), ),),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: width*0.80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(padding: EdgeInsets.all(5),
                          child: Text('Crear', style: TextStyle( fontSize: 30)),),
                        Padding(padding: EdgeInsets.all(5),
                          child: IconButton(icon: Icon(Icons.calendar_today, size: 30,), onPressed: () {
                          selectDate();
                          }),),
                        Padding(padding: EdgeInsets.all(5),
                          child: Text('<<Horario>>',style: TextStyle( fontSize: 30, fontStyle:FontStyle.italic)),),
                        Padding(padding: EdgeInsets.symmetric( horizontal: 20, vertical: 5),
                          child: RaisedButton(
                              color: const Color(0xff709BFF),
                              child: Padding(
                                  padding: EdgeInsets.all(2),
                                child: Center(
                                  child: Text('Guardar', style: TextStyle(color: Colors.black, fontSize: 30), textAlign: TextAlign.center,),
                                )
                              ),
                              onPressed: () {

                              }),),

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

  void selectDate() async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        locale: Locale('es', ''),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      {
        setState(() {
          selectedDate = picked;
        });
        selectTime();
      }

  }

  void selectTime() async{
    //Hasta las 3:30 reservas
    //desde las 8:00 reservas
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime
    );

    if(picked != null && picked != selectedTime) {
      print('Time selected: ${selectedTime.toString()}');
      setState((){
        selectedTime = picked;
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
  }
}
