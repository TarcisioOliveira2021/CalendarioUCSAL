import 'dart:convert';

import 'recurrent_event_model.dart';

class EventModel {
  int id;
  String name;
  bool entireDay;
  String? initialHour;
  String? finalHour;
  DateTime date;
  String recurrence;
  List<RecurrentEventModel>? recurrentEvents;
  EventModel({
    required this.id,
    required this.name,
    required this.entireDay,
    this.initialHour,
    this.finalHour,
    required this.date,
    required this.recurrence,
    this.recurrentEvents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'entireDay': entireDay,
      'initialHour': initialHour,
      'finalHour': finalHour,
      'date': date.millisecondsSinceEpoch,
      'recurrence': recurrence,
      'recurrentEvents': recurrentEvents?.map((x) => x?.toMap()).toList(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as int,
      name: map['nome'] as String,
      entireDay: map['ehDiaInteiro'] as bool,
      initialHour:
          map['horaInicial'] != null ? map['horaInicial'] as String : null,
      finalHour: map['horaFinal'] != null ? map['horaFinal'] as String : null,
      date: DateTime.parse(map['data']),
      recurrence: map['tipoRecorrencia'] as String,
      recurrentEvents: map['eventosRecorrentes'] != null
          ? List<RecurrentEventModel>.from(
              (map['eventosRecorrentes'] as List<dynamic>)
                  .map<RecurrentEventModel>(
              (x) => RecurrentEventModel.fromMap(x as Map<String, dynamic>),
            ))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
