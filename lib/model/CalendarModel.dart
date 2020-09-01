class CalendarModel {
  String key;
  List<Value> value;

  CalendarModel({this.key, this.value});

  CalendarModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    if (json['value'] != null) {
      value = new List<Value>();
      json['value'].forEach((v) {
        value.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    if (this.value != null) {
      data['value'] = this.value.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String name;
  bool isDone;

  Value({this.name, this.isDone});

  Value.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isDone'] = this.isDone;
    return data;
  }
}
