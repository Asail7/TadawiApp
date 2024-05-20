import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/widgets/color_pallete.dart';
import 'package:ta/widgets/upcoming_schedule.dart';
import 'package:ta/widgets/time_slot.dart';

class ScheduleScreen extends StatefulWidget {
  final String clinicName;
  final String PatiantName;
  final String selectedTimeSlot;

  ScheduleScreen({
    required this.clinicName,
    required this.PatiantName,
    required this.selectedTimeSlot,
  });

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState(
        clinicName: clinicName,
        PatiantName: PatiantName,
        selectedTimeSlot: selectedTimeSlot,
      );
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _buttonIndex = 0;

  final String clinicName;
  final String PatiantName;
  final String selectedTimeSlot;

  _ScheduleScreenState({
    required this.clinicName,
    required this.PatiantName,
    required this.selectedTimeSlot,
  });

  @override
  Widget build(BuildContext context) {
    final _scheduleWidgets = [
      UpcomingSchedule(
        clinicName: clinicName,
        doctorName: PatiantName,
        selectedTimeSlot: selectedTimeSlot, appointmentId: '',  getUpcomingAppointments: (appointmentList) {  }, month: '',
      ),
      Container(),
      Container(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'مواعيدي',
            style: GoogleFonts.ibmPlexSansArabic(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF4F6FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _buttonIndex = 0;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                      decoration: BoxDecoration(
                        color: _buttonIndex == 0
                            ? ColorPallete.mainColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "القادمة",
                        style: GoogleFonts.ibmPlexSansArabic(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              _buttonIndex == 0 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _buttonIndex = 1;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                      decoration: BoxDecoration(
                        color: _buttonIndex == 1
                            ? ColorPallete.mainColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "المكتملة",
                        style: GoogleFonts.ibmPlexSansArabic(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              _buttonIndex == 1 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Widgets According to buttons
            _scheduleWidgets[_buttonIndex]
          ],
        ),
      )),
    );
  }
}
