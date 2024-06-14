import 'package:event_calendar/controllers/event_controller.dart';
import 'package:event_calendar/models/event_model.dart';
import 'package:event_calendar/ui/styles/colors.dart';
import 'package:event_calendar/ui/styles/texts.dart';
import 'package:event_calendar/ui/widgets/containers/background_container.dart';
import 'package:event_calendar/ui/widgets/containers/day_schedule_container.dart';
import 'package:event_calendar/ui/widgets/containers/month_container.dart';
import 'package:event_calendar/ui/widgets/events_tab.dart';
import 'package:event_calendar/ui/widgets/containers/event_container.dart';
import 'package:event_calendar/ui/widgets/month_schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then(
    (_) => runApp(const MainApp()),
  );
}

var eventamount = 0;

// void eventCounting(List<EventModel> events) {
//   for (var event in events) {
//     eventamount += 1;
//     if (event.recurrentEvents != null && event.recurrentEvents!.isNotEmpty) {
//       for (var recurrent in event.recurrentEvents!) {
//         eventamount += 1;
//       }
//     }
//   }
//   print("A: $eventamount");
// }

// List<EventModel> getCurrentMonthEvents(List<EventModel> allEvents) {
//   List<EventModel> currentMonthEvents = [];
//   for (var event in allEvents) {
//     if (event.date.month == DateTime.now().month) {
//       currentMonthEvents.add(event);
//     }
//   }
//   return currentMonthEvents;
// }

// TODO:
// const monthEvents = {
//   15: [evt],
// };

// void teste(List<EventModel> events) {
//   for (var evt in events) {
//     if(monthEvents[evt.date.day] != null) monthEvents[evt.date.day].add(value)
//     else monthEvents[evt.date.day] = [evt];
//   }
// }

// [evtpai1, evtpai2, evtpai3]

// [evtpai, evtpai.filho[0], evtpai.filho[1], evtpai.filho[2], evtpai2]

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<List<EventModel>> parentEvents;
  late Future<List<dynamic>> flatennedEvents;

  @override
  Widget build(BuildContext context) {
    parentEvents = fetchEvents();
    flatennedEvents = fetchFlatEvents();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar:
            AppBar(title: const Text("Calendário acadêmico Ucsal - 2024.1")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: parentEvents,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return BackgroundContainer(
                        child: SingleChildScrollView(
                          child: EventsTab(
                            events: snapshot.data ?? [],
                            eventsChangedCallback: () {
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              const SizedBox(width: 24),
              FutureBuilder(
                future: flatennedEvents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return BackgroundContainer(
                      child: SingleChildScrollView(
                        child: MonthContainer(
                          currentMonthEvents: snapshot.data ?? [],
                        ),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
