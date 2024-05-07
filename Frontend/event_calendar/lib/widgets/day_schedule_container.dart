import 'package:event_calendar/styles/colors.dart';
import 'package:event_calendar/styles/texts.dart';
import 'package:flutter/material.dart';

class DayScheduleContainer extends StatelessWidget {
  final List<Widget> events;
  final int weekDayIndex;
  const DayScheduleContainer(
      {super.key, this.events = const [], required this.weekDayIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: weekDayIndex % 2 == 0 ? gray : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$weekDayIndex",
            style: titleMedium,
          ),
          if (events.isNotEmpty)
            ...events
          else
            const SizedBox(height: 56, width: 116),
        ],
      ),
    );
  }
}
