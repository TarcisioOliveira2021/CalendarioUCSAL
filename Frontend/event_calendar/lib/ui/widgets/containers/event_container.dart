import 'package:event_calendar/ui/styles/colors.dart';
import 'package:event_calendar/ui/styles/texts.dart';
import 'package:flutter/material.dart';

class EventContainer extends StatelessWidget {
  final String title;
  final String description;
  final Color? outlineColor;
  const EventContainer({
    super.key,
    required this.title,
    required this.description,
    this.outlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: outlineColor ?? navyBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: bodyBold,
          ),
          Text(
            description,
            style: body,
          ),
        ],
      ),
    );
  }
}
