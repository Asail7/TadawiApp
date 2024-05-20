import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/screens/patient/phome.dart';
import 'package:ta/screens/patient/pnavbar.dart';
import 'package:ta/widgets/color_pallete.dart';
import 'package:ta/widgets/upcoming_schedule.dart';

class PScheduleScreen extends StatefulWidget {
  final String clinicName;
  final String doctorName;
  final String selectedTimeSlot;
  final String appointmentId;

  PScheduleScreen({
    required this.clinicName,
    required this.doctorName,
    required this.selectedTimeSlot,
    required this.appointmentId,
  });

  @override
  _PScheduleScreenState createState() => _PScheduleScreenState();
}

class _PScheduleScreenState extends State<PScheduleScreen> {
  int _buttonIndex = 0;
  List<Map<String, dynamic>> _upcomingAppointments = [];

  @override
  void initState() {
    super.initState();
    fetchUpcomingAppointments();
  }

  void fetchUpcomingAppointments() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? email = user.email;

      if (email != null) {
        FirebaseFirestore.instance
            .collection('appointments')
            .where('userEmail', isEqualTo: email)
            .get()
            .then((querySnapshot) {
          List<Map<String, dynamic>> upcomingAppointments = [];
          querySnapshot.docs.forEach((doc) {
            Map<String, dynamic> appointmentData = doc.data();
            if (appointmentData.containsKey('cancelled') &&
                appointmentData['cancelled']) {
              upcomingAppointments.add(appointmentData);
            } else {
              upcomingAppointments.add(appointmentData);
            }
          });
          setState(() {
            _upcomingAppointments = upcomingAppointments;
          });
        }).catchError((error) {
          print("Failed to fetch upcoming appointments: $error");
        });
      } else {
        // Handle case when email is null
      }
    } else {
      // Handle case when user is not authenticated
    }
  }

  @override
  Widget build(BuildContext context) {
    final _scheduleWidgets = [
      _upcomingAppointments.isEmpty
          ? CircularProgressIndicator()
          : Container(
              height: 400,
              child: UpcomingSchedule(
                clinicName: widget.clinicName,
                doctorName: widget.doctorName,
                selectedTimeSlot: widget.selectedTimeSlot,
                appointmentId: widget.appointmentId,
                getUpcomingAppointments: (appointments) {
                  setState(() {
                    _upcomingAppointments = appointments;
                  });
                },
                showConfirmationButton: false, month: '',
              ),
            ),
      _buttonIndex == 0 ? Container() : _buildCancelledAppointments(),
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
        leading: Container(),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 80),
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
                            color: _buttonIndex == 0
                                ? Colors.white
                                : Colors.black38,
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
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 80),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 1
                              ? ColorPallete.mainColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "الملغاة",
                          style: GoogleFonts.ibmPlexSansArabic(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _buttonIndex == 1
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _scheduleWidgets[_buttonIndex],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCancelledAppointments() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _upcomingAppointments.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_upcomingAppointments[index]['doctorName']),
          subtitle: Text(_upcomingAppointments[index]['clinicName']),
          trailing: Text('ملغاة'),
        );
      },
    );
  }
}
