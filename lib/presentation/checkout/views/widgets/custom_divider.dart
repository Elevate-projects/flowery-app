import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 24,
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xffEAEAEA)
        ),
      ),
    );
  }
}
