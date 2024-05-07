import 'package:flutter/material.dart';

import 'day_schedule_container.dart';
import 'event_container.dart';

class MonthSchedule extends StatelessWidget {
  const MonthSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            7,
            (index) {
              return Padding(
                padding: index != 6
                    ? const EdgeInsets.only(right: 15)
                    : EdgeInsets.zero,
                child: DayScheduleContainer(
                    weekDayIndex: index + 1,
                    events: const [
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                    ]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(
            7,
            (index) {
              return Padding(
                padding: index != 6
                    ? const EdgeInsets.only(right: 15)
                    : EdgeInsets.zero,
                child: DayScheduleContainer(
                    weekDayIndex: index + 1,
                    events: const [
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                    ]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(
            7,
            (index) {
              return Padding(
                padding: index != 6
                    ? const EdgeInsets.only(right: 15)
                    : EdgeInsets.zero,
                child: DayScheduleContainer(
                    weekDayIndex: index + 1,
                    events: const [
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                    ]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(
            7,
            (index) {
              return Padding(
                padding: index != 6
                    ? const EdgeInsets.only(right: 15)
                    : EdgeInsets.zero,
                child: DayScheduleContainer(
                    weekDayIndex: index + 1,
                    events: const [
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                      EventContainer(
                          title: "7h - 10:30", description: "Evento"),
                    ]),
              );
            },
          ),
        ),
        // const SizedBox(height: 16),
        // const Row(
        //   children: [
        //     DayScheduleContainer(
        //       weekDayIndex: 1,
        //       events: [
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //       ],
        //     ),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //   ],
        // ),
        // const SizedBox(height: 16),
        // const Row(
        //   children: [
        //     DayScheduleContainer(
        //       weekDayIndex: 1,
        //       events: [
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //       ],
        //     ),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //   ],
        // ),
        // const SizedBox(height: 16),
        // const Row(
        //   children: [
        //     DayScheduleContainer(
        //       weekDayIndex: 1,
        //       events: [
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //         EventContainer(title: "7h - 10:30", description: "Vo me matar"),
        //       ],
        //     ),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //     DayScheduleContainer(weekDayIndex: 1),
        //   ],
        // ),
      ],
    );
  }
}
