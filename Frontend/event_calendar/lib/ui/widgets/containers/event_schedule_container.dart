import 'package:event_calendar/ui/styles/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../styles/colors.dart';

class EventScheduleContainer extends StatelessWidget {
  const EventScheduleContainer(
      {super.key,
      required this.eventName,
      required this.recurrence,
      required this.onDelete});
  final String eventName;
  final String recurrence;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: navyBlue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eventName, style: bodyTitle),
                Text(recurrence, style: body),
              ],
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
              onTap: () => onDelete(),
              child: const Icon(Icons.delete_outline_rounded)),
        ],
      ),
    );
  }
}
