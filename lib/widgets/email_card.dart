import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/widgets/color_pallete.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailCard extends StatelessWidget {
  final String email;
  final String Name;
  final String description;

  void _launchEmailApp(String emailAddress) async {
    final uri = Uri.parse('mailto:$emailAddress');
    try {
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      } else {
        print('Could not launch $uri');
      }
    } catch (e) {
      print('Error launching email app: $e');
    }
  }

  EmailCard({
    required this.email,
    required this.Name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xffECF0F5),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xffD5E0FA),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.email, size: 40),
                      onPressed: () {
                        _launchEmailApp(email);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  Name,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  description,
                  style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.right,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
