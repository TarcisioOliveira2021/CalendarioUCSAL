import 'dart:convert';

class RecurrentEventModel {
  int id;
  String name;
  int fatherId;
  String? initialHour;
  String? finalHour;
  DateTime date;
  RecurrentEventModel({
    required this.id,
    required this.name,
    required this.fatherId,
    this.initialHour,
    this.finalHour,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'fatherId': fatherId,
      'initialHour': initialHour,
      'finalHour': finalHour,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory RecurrentEventModel.fromMap(Map<String, dynamic> map) {
    return RecurrentEventModel(
      id: map['id'] as int,
      name: map['nome'] as String,
      fatherId: map['idPai'] as int,
      initialHour:
          map['horaInicial'] != null ? map['horaInicial'] as String : null,
      finalHour: map['horaFinal'] != null ? map['horaFinal'] as String : null,
      date: DateTime.parse(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecurrentEventModel.fromJson(String source) =>
      RecurrentEventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
