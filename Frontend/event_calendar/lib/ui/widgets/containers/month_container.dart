import 'package:event_calendar/controllers/event_controller.dart';
import 'package:event_calendar/enums/recurrence_enum.dart';
import 'package:event_calendar/models/event_model.dart';
import 'package:event_calendar/models/recurrent_event_model.dart';
import 'package:event_calendar/ui/styles/colors.dart';
import 'package:event_calendar/ui/widgets/containers/day_schedule_container.dart';
import 'package:event_calendar/ui/widgets/containers/event_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../styles/texts.dart';
import '../month_schedule.dart';
import 'dart:collection';

const months = {
  1: 'Janeiro',
  2: 'Fevereiro',
  3: 'Março',
  4: 'Abril',
  5: 'Maio',
  6: 'Junho',
  7: 'Julho',
  8: 'Agosto',
  9: 'Setembro',
  10: 'Outubro',
  11: 'Novembro',
  12: 'Dezembro',
};

const weekDays = {
  0: 'Domingo',
  1: 'Segunda',
  2: 'Terça',
  3: 'Quarta',
  4: 'Quinta',
  5: 'Sexta',
  6: 'Sabado',
};

// void teste(Map<int, List> eventsInDays, List<EventModel> events) {
//   for (var event in events) {
//     eventsInDays[event.date.day]?.add(event);
//     if (event.recurrence == Recurrence.diariamente.label ||
//         event.recurrence == Recurrence.semanalmente.label) {
//       for (var current in event.recurrentEvents!) {
//         eventsInDays[current.date.day]?.add(current);
//       }
//     }
//   }
//   // return eventsInDays;
// }

// void gen() {
//   var x = {};
//   for (var i = 1;
//       i <= DateUtils.getDaysInMonth(2024, DateTime.now().month);
//       i++) {
//     x[i] = [];
//   }
//   print(x);
// }

// var weekQueue = Queue<String>.from(weekDays.values);

// List<String> weekOrderedByOffset(int offset) {
//   for (var i = 0; i < offset; i++) {
//     var currentFirst = weekQueue.first;
//     weekQueue.removeFirst();
//     weekQueue.add(currentFirst);
//   }
//   return weekQueue.toList();
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

Map<int, List<Widget>> mapSchedule(
    List<dynamic> events, DateTime currentDateTime) {
  Map<int, List<Widget>> scheduleMap = {};
  for (var evt in events) {
    if ((evt.date as DateTime).month == currentDateTime.month &&
        (evt.date as DateTime).year == currentDateTime.year) {
      if (scheduleMap[(evt.date as DateTime).day] == null) {
        scheduleMap[(evt.date as DateTime).day] = [];
        scheduleMap[(evt.date as DateTime).day]?.add(
          EventContainer(
            title: evt.name,
            description: evt.initialHour ?? "DIA INTEIRO",
          ),
        );
      } else {
        scheduleMap[(evt.date as DateTime).day]?.add(
          EventContainer(
            title: evt.name,
            description: evt.initialHour ?? "DIA INTEIRO",
          ),
        );
      }
    }
  }
  return scheduleMap;
}

class MonthContainer extends StatefulWidget {
  final List<dynamic> currentMonthEvents;
  MonthContainer({super.key, required this.currentMonthEvents});

  @override
  State<MonthContainer> createState() => _MonthContainerState();
}

class _MonthContainerState extends State<MonthContainer> {
  TextEditingController currentMonthController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selectedSchedule = mapSchedule(widget.currentMonthEvents, selectedDate);
    var firstDayOffset = DateUtils.firstDayOffset(
      selectedDate.year,
      selectedDate.month,
      MaterialLocalizations.of(context),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            DropdownMenu<int>(
              textStyle: headlineSmall,
              label: const Text("Mês atual", style: titleMedium),
              onSelected: (value) {
                setState(() {
                  selectedDate = DateTime.utc(selectedDate.year, value!);
                });
              },
              initialSelection: selectedDate.month,
              controller: currentMonthController,
              dropdownMenuEntries: List.generate(
                12,
                (index) => DropdownMenuEntry<int>(
                  value: index + 1,
                  label: "${months[index + 1]}",
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => setState(() {
                selectedDate = DateTime.utc(
                  selectedDate.year - 1,
                  selectedDate.month,
                );
              }),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text("${selectedDate.year}", style: headlineSmall),
            ),
            GestureDetector(
              onTap: () => setState(() {
                selectedDate = DateTime.utc(
                  selectedDate.year + 1,
                  selectedDate.month,
                );
              }),
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 23),
        Row(
          children: List.generate(
            7,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                weekDays[index] as String,
                style: titleSmall,
              ),
            ),
          ),
        ),
        const SizedBox(height: 9),
        LayoutGrid(
            columnSizes: const [auto, auto, auto, auto, auto, auto, auto],
            rowSizes: const [auto, auto, auto, auto, auto, auto],
            columnGap: 15,
            rowGap: 16,
            children: [
              ...List.generate(
                  firstDayOffset,
                  (fodderIndex) => DayScheduleContainer(
                        isFodderDay: true,
                        index: DateUtils.getDaysInMonth(
                                selectedDate.year,
                                selectedDate.month == 1
                                    ? 12
                                    : selectedDate.month - 1) -
                            fodderIndex,
                        backgroundColor:
                            fodderIndex % 2 == 0 ? gray : Colors.white,
                      )).reversed,
              ...List.generate(
                DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month),
                (i) => DayScheduleContainer(
                    isFodderDay: false,
                    index: i + 1,
                    backgroundColor: i % 2 == 0 ? Colors.white : gray,
                    events: selectedSchedule[i + 1] ?? []),
              ),
            ]),
      ],
    );
  }
}
