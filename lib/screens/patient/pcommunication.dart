import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/widgets/email_card.dart';
import 'package:ta/widgets/color_pallete.dart';
import 'package:url_launcher/url_launcher.dart';

class CommuPat extends StatefulWidget {
  static const String sr = 'pcommuniacation';
  @override
  _CommuPatState createState() => _CommuPatState();
}

class _CommuPatState extends State<CommuPat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تواصل',
            style: GoogleFonts.ibmPlexSansArabic(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.right,
              onChanged: (value) {},
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'بحث',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            EmailCard(
              email: 'a@gmail.com',
              Name: 'د.سوزان',
              description: 'يمكنك التواصل مع طبيبك عبر البريد الالكتروني',
            ),
            SizedBox(
              height: 10,
            ),
            EmailCard(
              email: 'f@gmail.com',
              Name: 'د.فيصل ',
              description: 'يمكنك التواصل مع طبيبك عبر البريد الالكتروني',
            ),
            EmailCard(
              email: 'n@gmail.com',
              Name: 'د.نورة ',
              description: 'يمكنك التواصل مع طبيبك عبر البريد الالكتروني',
            ),
            EmailCard(
              email: 's@gmail.com',
              Name: 'د.سارة ',
              description: 'يمكنك التواصل مع طبيبك عبر البريد الالكتروني',
            )
          ],
        ),
      ),
    );
  }
}
