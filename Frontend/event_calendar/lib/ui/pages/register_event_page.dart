import 'package:event_calendar/controllers/event_controller.dart';
import 'package:event_calendar/ui/styles/colors.dart';
import 'package:event_calendar/ui/styles/texts.dart';
import 'package:event_calendar/ui/widgets/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../../enums/recurrence_enum.dart';
import 'package:flutter/material.dart';

class RegisterEventPage extends StatefulWidget {
  const RegisterEventPage({super.key});

  @override
  State<RegisterEventPage> createState() => _RegisterEventPageState();
}

class _RegisterEventPageState extends State<RegisterEventPage> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController dataController =
      MaskedTextController(mask: '0000-00-00');
  TextEditingController recurrenceController = TextEditingController();
  TextEditingController initialHourController =
      MaskedTextController(mask: '00:00');
  TextEditingController finalHourController =
      MaskedTextController(mask: '00:00');
  bool entireDay = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Adicionar Evento")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Container(
            decoration: BoxDecoration(
              color: lightGray,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.fromLTRB(45, 64, 76, 0),
            child: SizedBox(
              width: 426,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nome do evento", style: titleMedium),
                  MainTextField(controller: eventNameController),
                  const SizedBox(height: 24),
                  const Text("Data", style: titleMedium),
                  MainTextField(
                    controller: dataController,
                    hintText: "2024-06-14",
                  ),
                  const SizedBox(height: 24),
                  const Text("Recorrência", style: titleMedium),
                  DropdownMenu<Recurrence>(
                    initialSelection: Recurrence.nenhuma,
                    controller: recurrenceController,
                    dropdownMenuEntries: Recurrence.values
                        .map<DropdownMenuEntry<Recurrence>>(
                          (Recurrence rec) => DropdownMenuEntry<Recurrence>(
                            value: rec,
                            label: rec.label,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text("Dia inteiro", style: titleMedium),
                  Switch(
                      value: entireDay,
                      onChanged: (bool) {
                        setState(() {
                          entireDay = !entireDay;
                        });
                      }),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Horário inicial", style: titleMedium),
                          SizedBox(
                              width: 205,
                              child: MainTextField(
                                controller: initialHourController,
                                hintText: "12:00",
                              )),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Horário final", style: titleMedium),
                          SizedBox(
                              width: 205,
                              child: MainTextField(
                                controller: finalHourController,
                                hintText: "14:00",
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      final Map<String, dynamic> newEvent = {
                        "nome": eventNameController.text,
                        "recorrencia": recurrenceController.text,
                        "horaInicial": initialHourController.text,
                        "horaFinal": finalHourController.text,
                        "ehDiaInteiro": entireDay,
                        "data": DateTime.parse(dataController.text)
                            .toIso8601String(),
                      };
                      sendEvent(newEvent);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                surfaceTintColor: gray,
                                title: const Text("Evento adicionado"),
                                actions: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Center(
                                        child: Container(
                                      width: 65,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: navyBlue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Entendi",
                                        style: titleSmall.copyWith(
                                            color: Colors.white),
                                      ),
                                    )),
                                  ),
                                ],
                              ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: navyBlue,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "Salvar",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
