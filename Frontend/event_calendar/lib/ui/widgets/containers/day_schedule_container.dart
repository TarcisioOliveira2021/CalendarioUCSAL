import 'package:event_calendar/ui/styles/colors.dart';
import 'package:event_calendar/ui/styles/texts.dart';
import 'package:flutter/material.dart';

class DayScheduleContainer extends StatelessWidget {
  final List<Widget> events;
  final int index;
  final bool isFodderDay;
  final Color backgroundColor;
  const DayScheduleContainer(
      {super.key,
      this.events = const [],
      required this.index,
      required this.backgroundColor,
      required this.isFodderDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100, minWidth: 132),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$index",
            style: titleMedium,
          ),
          if (isFodderDay)
            const Icon(
              Icons.close_rounded,
              color: Colors.red,
            ),
          if (events.isNotEmpty) ...events
        ],
      ),
    );
  }
}
