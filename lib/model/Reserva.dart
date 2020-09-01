class ReservaClass {
  bool hasData;
  Reseva reseva;

  ReservaClass({this.hasData, this.reseva});

  ReservaClass.fromJson(Map<String, dynamic> json) {
    hasData = json['hasData'];
    reseva =
        json['reseva'] != null ? new Reseva.fromJson(json['reseva']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasData'] = this.hasData;
    if (this.reseva != null) {
      data['reseva'] = this.reseva.toJson();
    }
    return data;
  }
}

class Reseva {
  String idReserva;
  String fecha;
  String usuarioIdUsuario;
  String franjaHorariaIdFranjaHoraria;
  String franja;

  Reseva(
      {this.idReserva,
      this.fecha,
      this.usuarioIdUsuario,
      this.franjaHorariaIdFranjaHoraria,
      this.franja});

  Reseva.fromJson(Map<String, dynamic> json) {
    idReserva = json['idReserva'];
    fecha = json['fecha'];
    usuarioIdUsuario = json['Usuario_idUsuario'];
    franjaHorariaIdFranjaHoraria = json['FranjaHoraria_idFranjaHoraria'];
    franja = json['franja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idReserva'] = this.idReserva;
    data['fecha'] = this.fecha;
    data['Usuario_idUsuario'] = this.usuarioIdUsuario;
    data['FranjaHoraria_idFranjaHoraria'] = this.franjaHorariaIdFranjaHoraria;
    data['franja'] = this.franja;
    return data;
  }
}