import 'package:event_calendar/controllers/event_controller.dart';
import 'package:event_calendar/models/event_model.dart';
import 'package:event_calendar/ui/pages/register_event_page.dart';
import 'package:event_calendar/ui/widgets/containers/event_schedule_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../styles/colors.dart';
import '../styles/texts.dart';

String parseEventRecurrence(EventModel event) {
  String durationString = "";
  switch (event.recurrence) {
    case 'NENHUMA':
      durationString =
          "Somente em ${DateFormat.Md('pt_BR').format(event.date)}";
      break;
    case 'DIARIAMENTE':
      durationString =
          "A partir do dia ${DateFormat.Md('pt_BR').format(event.date)}";
      break;
    case 'SEMANALMENTE':
      durationString = "Todo(a) ${DateFormat.EEEE('pt_BR').format(event.date)}";
      break;
    case 'MENSALMENTE':
      durationString =
          "Todo mês, dia ${DateFormat.d('pt_BR').format(event.date)}";
      break;
    case 'ANUALMENTE':
      durationString =
          "Em ${event.date.year} no dia ${DateFormat.Md('pt_BR').format(event.date)}";
      break;
    default:
      "Erro na busca de recorrência";
  }

  return durationString;
}

class EventsTab extends StatefulWidget {
  final List<EventModel> events;
  final Function() eventsChangedCallback;
  const EventsTab(
      {super.key, required this.events, required this.eventsChangedCallback});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Eventos",
          style: headlineSmall,
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => const RegisterEventPage(),
                  ),
                )
                .then((value) => widget.eventsChangedCallback.call());
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: navyBlue, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              "Adicionar Evento",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 220,
          child: ListView.builder(
            itemCount: widget.events.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              EventModel currentEvent = widget.events[index];
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: EventScheduleContainer(
                  onDelete: () {
                    deleteEvent(currentEvent.id, currentEvent.date)
                        .then((value) => widget.eventsChangedCallback.call());
                  },
                  eventName: currentEvent.name,
                  recurrence: parseEventRecurrence(currentEvent),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
