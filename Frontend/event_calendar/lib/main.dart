import 'package:event_calendar/controllers/event_controller.dart';
import 'package:event_calendar/models/event_model.dart';
import 'package:event_calendar/ui/widgets/containers/background_container.dart';
import 'package:event_calendar/ui/widgets/containers/month_container.dart';
import 'package:event_calendar/ui/widgets/events_tab.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then(
    (_) => runApp(const MainApp()),
  );
}

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
