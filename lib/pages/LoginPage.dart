import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squash_portal_loma/model/Session.dart';

import 'package:squash_portal_loma/utils/components/CustomButton.dart';
import 'package:squash_portal_loma/pages/MainPage.dart';
import 'package:squash_portal_loma/utils/strings/Strings.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerName=TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    //programese asi https://colorlib.com/wp/wp-content/uploads/sites/2/html5-css-login-forms.jpg
    //233d4d azul oscuro
    //fcca46 amber
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
          ),
          Container(
            width: width * 0.8,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: _controllerName,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: _controllerPassword,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Clave',
                        labelText: 'Clave',
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: CustomButton(
                      text: 'Ingresar',
                      onClick: () {
                        _validateInformation();
                      },
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text('Olvido la clave?'),
                ),
                _divider(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('Tienes problemas para entrar?'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            child: Text(
                              'Comunicate con nosotros',
                              style: TextStyle(color: const Color(0xfffe7f2d)),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(' '),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  void _validateInformation() async {
    final response = await http.get(urlLogin +
        'nombre=${_controllerName.text}&clave=${_controllerPassword.text}');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      var body = jsonDecode(response.body);
      SessionClass u = SessionClass.fromJson(body);
      if (u.hasData) {
        addStringToSF(u.session);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(
                    u: u.session,
                  )),
        );
      }else{
        Toast.show("Datos incorrectos", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      Toast.show("Hubo un error, intenta nuevamente", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      throw Exception('Failed to get reservations');
    }
  }

  addStringToSF(Session u) async {
    print('Saving in prefs');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session', jsonEncode(u));
  }
}
