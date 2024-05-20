import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PandS extends StatefulWidget {
  const PandS({super.key});

  @override
  State<PandS> createState() => _PandSState();
}

class _PandSState extends State<PandS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الخصوصية ',
            style: GoogleFonts.ibmPlexSansArabic(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " في تداوي نعمل بجد لضمان خصوصية المستخدمين والحفاظ على سرية معلوماتهم، ونحرص بشكل كامل على المحافظة على أمان حساباتهم. يمكنك الثقة الكاملة في أن معلوماتك الشخصية تعتبر سرية ولا يطلع عليها اي طرف آخر",
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              """
              Tadawiتداوي
              @2024 
              """,
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
