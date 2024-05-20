import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBottun extends StatelessWidget {
  MyBottun({required this.color, required this.title, required this.onPressed});

  final Color color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
          elevation: 5,
          color: color,
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            onPressed: onPressed,
            minWidth: 200,
            height: 60,
            child: Text(
              title,
              style: GoogleFonts.ibmPlexSansArabic(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
