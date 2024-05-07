import 'package:event_calendar/styles/colors.dart';
import 'package:event_calendar/styles/texts.dart';
import 'package:event_calendar/widgets/main_text_field.dart';
import 'package:flutter/material.dart';

class RegisterEventPage extends StatelessWidget {
  const RegisterEventPage({super.key});

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
                  const MainTextField(),
                  const SizedBox(height: 24),
                  const Text("Data", style: titleMedium),
                  const MainTextField(),
                  const SizedBox(height: 24),
                  const Text("Recorrência", style: titleMedium),
                  const DropdownMenu(
                    dropdownMenuEntries: [],
                  ),
                  const SizedBox(height: 24),
                  const Text("Dia inteiro", style: titleMedium),
                  Switch(value: true, onChanged: (bool) {}),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Horário inicial", style: titleMedium),
                          SizedBox(width: 205, child: MainTextField()),
                        ],
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Horário final", style: titleMedium),
                          SizedBox(width: 205, child: MainTextField()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
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
