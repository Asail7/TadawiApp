import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class abootTADAWI extends StatefulWidget {
  const abootTADAWI({super.key});

  @override
  State<abootTADAWI> createState() => _abootTADAWIState();
}

class _abootTADAWIState extends State<abootTADAWI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'عن تداوي ',
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
              " تـداوي هو تطبيق لحجز المواعيد الطبيه في الافلاج , نسعى جاهدين لكسب رضا المستخدمين والحفاظ على وقتهم ,تم تطوير التطبيق بواسطة طالبات جامعة الامير سطام بن عبد العزيز , قسم علوم الحاسب (أصايل ال عاتي , غادة الحجي , مها الوذيح) ",
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              """
للتواصل والاقتراحات : tadawiapp@outlook.com
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
