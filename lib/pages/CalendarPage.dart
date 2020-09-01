import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:squash_portal_loma/model/CalendarModel.dart';
import 'package:squash_portal_loma/utils/strings/Strings.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarPage> {
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  List _selectedEvents;
  DateTime _selectedDay;

  final now = DateTime.now();

  Map<DateTime, List> _events;

  Future<Map> futureReservations;


  @override
  void initState() {
    super.initState();
    _selectedDay = now;
    futureReservations=_loadReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: futureReservations,
            initialData: true,
            builder: (context, dataSnapshot) {
            switch(dataSnapshot.connectionState){
            case ConnectionState.done:
              print(dataSnapshot.data.toString());
              if(dataSnapshot.data!=null){
                setState(() {
                  _events = dataSnapshot.data;
                  _selectedEvents = _events[_selectedDay] ?? [];
                });
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: Calendar(
                        initialDate: now,
                        hideTodayIcon: true,
                        hideBottomBar: true,
                        hideArrows: true,
                        startOnMonday: true,
                        locale: 'es_CO',
                        weekDays: ["Lun", "Mar", "Mie", "Jue", "Vie", "Sab", "Dom"],
                        events: _events,
                        onRangeSelected: (range) =>
                            print("Range is ${range.from}, ${range.to}"),
                        onDateSelected: (date) => _handleNewDate(date),
                        isExpandable: true,
                        eventDoneColor: Colors.green,
                        selectedColor: Colors.pink,
                        todayColor: Colors.yellow,
                        eventColor: Colors.grey,
                        dayOfWeekStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 11),
                      ),
                    ),
                    _buildEventList()
                  ],
                );
              }
              return SizedBox();
              break;

              default : return Center(
                child: CircularProgressIndicator(),
              );
            }

        },
      )),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index]['name'].toString()),
            onTap: () {
              Navigator.pop(
                  context, [_selectedDay, _selectedEvents[index]['name']]);
            },
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }

  Future<Map> _loadReservations() async {
    final response = await http.get(urlFetchReservations);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      print('server response: ' + response.body);
      List<dynamic> body = jsonDecode(response.body);

      List<CalendarModel> list = body
          .map(
            (dynamic item) => CalendarModel.fromJson(item),
          )
          .toList();
      print('new map' + jsonEncode(list));
      return Map.fromIterable(list,
          key: (r) => DateTime(r.key), value: (r) => r.value);
    } else {
      return null;
    }
  }
}
