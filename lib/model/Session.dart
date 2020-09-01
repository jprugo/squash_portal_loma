class SessionClass {
  bool hasData;
  Session session;

  SessionClass({this.hasData, this.session});

  SessionClass.fromJson(Map<String, dynamic> json) {
    hasData = json['hasData'];
    session =
        json['session'] != null ? new Session.fromJson(json['session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasData'] = this.hasData;
    if (this.session != null) {
      data['session'] = this.session.toJson();
    }
    return data;
  }
}

class Session {
  String idUsuario;
  String nombre;
  String clave;

  Session({this.idUsuario, this.nombre, this.clave});

  Session.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    nombre = json['nombre'];
    clave = json['clave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUsuario'] = this.idUsuario;
    data['nombre'] = this.nombre;
    data['clave'] = this.clave;
    return data;
  }
}