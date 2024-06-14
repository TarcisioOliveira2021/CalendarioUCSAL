import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: child,
    );
  }
}
