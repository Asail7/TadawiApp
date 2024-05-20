import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/screens/doctor/dnavbar.dart';
import 'package:ta/widgets/color_pallete.dart';

class tClinic1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ibmPlexSansArabic',
      ),
      home: TClinic1(),
    );
  }
}

class TClinic1 extends StatefulWidget {
  @override
  _TClinic1State createState() => _TClinic1State();
}

class _TClinic1State extends State<TClinic1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xff54D579), Color(0xff00AABF)],
            begin: Alignment(0, -1.15),
            end: Alignment(0, 0.1),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Image.asset('images/Healthprofessionalteam.png'),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color(0xffF9F9F9),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "عن العيادة",
                                style: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "يرجى كتابة وصف الطبيب هنا. هذا سيكون معلومات مفصلة عن العيادة",
                                style: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "الفترات الزمنية المتاحة",
                                style: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              timeSlotWidget("13", "مايو", "موعد",
                                  "الأحد 9 صباحاً إلى 11.30 صباحاً"),
                              timeSlotWidget("14", "مايو", "موعد",
                                  "الاثنين 10 صباحاً إلى 12.30 مساءً"),
                              timeSlotWidget("1", "يونيو", "موعد",
                                  "الأربعاء 8 صباحاً إلى 12.30 مساءً"),
                              timeSlotWidget("3", "يونيو", "موعد",
                                  "الجمعة 8 صباحاً إلى 1 مساءً"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            iconSize: 28,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, DNavBarRoots.sr);
            },
          ),
        ),
      ]),
    );
  }

  Container timeSlotWidget(
      String date, String month, String slotType, String time) {
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
                  Text(
                    "$date",
                    style: GoogleFonts.ibmPlexSansArabic(
                        color: ColorPallete.secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "$month",
                    style: GoogleFonts.ibmPlexSansArabic(
                        color: ColorPallete.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$slotType",
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  "$time",
                  style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 17, fontWeight: FontWeight.w600),
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
