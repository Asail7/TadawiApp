import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ta/screens/doctor/login_doctor.dart';
import 'package:ta/screens/patient/login_patient.dart';
import 'package:ta/screens/recep/login_recep.dart';
import 'package:ta/screens/recep/registeration_recep.dart';
import 'package:ta/widgets/my_bottun.dart';
import 'package:ta/screens/patient/phome.dart';
import 'package:ta/screens/patient/registeration_patient.dart';


class welcome extends StatefulWidget {
  static const String sr = 'welcome';

  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  child: Image.asset('images/Passing.png'),
                ),
                Text(
                  'من أنت؟',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MyBottun(
              color: Colors.black,
              title: 'مريض',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: LoginPatient(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            MyBottun(
              color: Colors.black,
              title: 'دكتور',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: LoginDoctor(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            MyBottun(
              color: Colors.black,
              title: 'موظف الاستقبال',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: LoginRecep(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
