import 'package:event_calendar/styles/colors.dart';
import 'package:event_calendar/styles/texts.dart';
import 'package:event_calendar/widgets/background_container.dart';
import 'package:event_calendar/widgets/day_schedule_container.dart';
import 'package:event_calendar/widgets/events_tab.dart';
import 'package:event_calendar/widgets/event_container.dart';
import 'package:event_calendar/widgets/month_schedule.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar:
            AppBar(title: const Text("Calendário acadêmico Ucsal - 2024.1")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Row(
            children: [
              const EventsTab(),
              const SizedBox(width: 24),
              Container(
                decoration: BoxDecoration(
                  color: lightGray,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Abril, 2024",
                        style: headlineSmall,
                      ),
                      SizedBox(height: 23),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: Text("Segunda", style: titleSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: Text("Terça", style: titleSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: Text("Quarta", style: titleSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: Text("Quinta", style: titleSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: Text("Sexta", style: titleSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: Text("Sabado", style: titleSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: Text("Domingo", style: titleSmall),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      MonthSchedule(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
