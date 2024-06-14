// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../styles/colors.dart';
// import 'containers/day_schedule_container.dart';
// import 'containers/event_container.dart';

// class MonthSchedule extends StatelessWidget {
//   const MonthSchedule({super.key, required this.daysInMonth});
//   final int daysInMonth;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: List.generate(
//             7,
//             (index) {
//               return Padding(
//                 padding: index != 6
//                     ? const EdgeInsets.only(right: 15)
//                     : EdgeInsets.zero,
//                 child: DayScheduleContainer(
//                     backgroundColor: index % 2 == 0 ? gray : Colors.white,
//                     index: index + 1,
//                     events: const [
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 8),
//                         child: EventContainer(
//                             title: "7h - 10:30", description: "Evento"),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 8),
//                         child: EventContainer(
//                             title: "7h - 10:30", description: "Evento"),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 8),
//                         child: EventContainer(
//                             title: "7h - 10:30", description: "Evento"),
//                       ),
//                     ]),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: List.generate(
//             7,
//             (index) {
//               return Padding(
//                 padding: index != 6
//                     ? const EdgeInsets.only(right: 15)
//                     : EdgeInsets.zero,
//                 child: DayScheduleContainer(
//                     index: index + 1,
//                     events: const [
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                     ]),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: List.generate(
//             7,
//             (index) {
//               return Padding(
//                 padding: index != 6
//                     ? const EdgeInsets.only(right: 15)
//                     : EdgeInsets.zero,
//                 child: DayScheduleContainer(
//                     weekDayIndex: index + 1,
//                     events: const [
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                     ]),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: List.generate(
//             7,
//             (index) {
//               return Padding(
//                 padding: index != 6
//                     ? const EdgeInsets.only(right: 15)
//                     : EdgeInsets.zero,
//                 child: DayScheduleContainer(
//                     weekDayIndex: index + 1,
//                     events: const [
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                       EventContainer(
//                           title: "7h - 10:30", description: "Evento"),
//                     ]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
