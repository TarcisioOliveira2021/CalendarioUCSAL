import 'dart:convert';

import 'package:event_calendar/models/event_model.dart';
import 'package:event_calendar/models/recurrent_event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<EventModel>> fetchEvents() async {
  try {
    var res = await http
        .get(Uri.parse("http://localhost:5070/api/Evento/eventos-pai"));
    var jsonResBody = jsonDecode(res.body);
    List<EventModel> events = List.generate(
      jsonResBody.length,
      (index) => EventModel.fromMap(jsonResBody[index]),
    );
    return events ?? [];
  } catch (err) {
    print(err);
    throw ErrorDescription("Ocorreu o erro: ${err.toString()}");
  }
}

Future<List<dynamic>> fetchFlatEvents() async {
  try {
    var res = await http.get(Uri.parse("http://localhost:5070/api/Evento"));
    var jsonResBody = jsonDecode(res.body);
    List<dynamic> events = List.generate(
      jsonResBody.length,
      (index) {
        if (jsonResBody[index]['idPai'] != null) {
          return RecurrentEventModel.fromMap(jsonResBody[index]);
        } else {
          return EventModel.fromMap(jsonResBody[index]);
        }
      },
    );
    return events ?? [];
  } catch (err) {
    print(err);
    throw ErrorDescription("Ocorreu o erro: ${err.toString()}");
  }
}

Future<void> deleteEvent(int id, DateTime data) async {
  try {
    await http.delete(Uri.parse(
        "http://localhost:5070/api/Evento/${id}&${data.toIso8601String()}"));
  } catch (err) {
    print(err);
    throw ErrorDescription("Ocorreu o erro: ${err.toString()}");
  }
}

Future<void> sendEvent(Map<String, dynamic> body) async {
  try {
    await http.post(Uri.parse("http://localhost:5070/api/Evento"),
        body: jsonEncode(body),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
  } catch (err) {
    print(err);
    throw ErrorDescription("Ocorreu o erro: ${err.toString()}");
  }
}
