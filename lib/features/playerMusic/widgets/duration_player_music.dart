import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DurationPlayerMusic extends StatelessWidget {
  DurationPlayerMusic({super.key, required this.durationOutput});
  Stream<String> durationOutput;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: durationOutput,
      builder: (context, snapshot) {
        return Text(
          snapshot.data.toString() ?? "00:00",
          style: GoogleFonts.orbitron(
            textStyle: TextStyle(
              color: Color(0xffB1AFE9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
