import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/screens/patient/pnavbar.dart';
import 'package:ta/widgets/color_pallete.dart';
import 'package:ta/widgets/my_bottun.dart';
import 'package:ta/widgets/upcoming_schedule.dart';

import 'time_slot.dart'; // Import TimeSlot class

class earclinic1 extends StatefulWidget {
  @override
  _earclinic1State createState() => _earclinic1State();
   final String month;

  earclinic1({required this.month});
  
}

class _earclinic1State extends State<earclinic1> {
  final firestoreService = FirestoreService();
  String selectedTimeSlot = "";

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
            ),
          ),
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
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('earclinic')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            // Check if there are any documents in the collection
                            if (snapshot.data!.docs.isEmpty) {
                              return Text('No clinics found');
                            }

                            // Display information about each clinic
                            return Column(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                final clinicData =
                                    document.data() as Map<String, dynamic>;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      clinicData['doctorName'],
                                      style: GoogleFonts.ibmPlexSansArabic(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      '''
         ${clinicData['clinicName']} - 
          معنا هنا تجد الاهتمام الشامل بصحة الأذن والسمع، حيث يوفر فريق من الأطباء المتخصصين بيئة مريحة وتجربة طبية ممتازة باستخدام أحدث التقنيات الطبية، مما يضمن تقديم العلاج المناسب والشخصي لكل مريض.
          ''',
                                      style: GoogleFonts.ibmPlexSansArabic(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),

                                    SizedBox(height: 10),
                                    // Fetch and display time slots for this clinic
                                    FutureBuilder<List<TimeSlot>>(
                                      future: firestoreService
                                          .getTimeSlotsForClinic(
                                              '3'), // Specify the clinic name here
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        }
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        if (snapshot.data!.isEmpty) {
                                          return Text(
                                              'No time slots available');
                                        }
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "الفترات الزمنية المتاحة",
                                              style:
                                                  GoogleFonts.ibmPlexSansArabic(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                            SizedBox(height: 10),
                                            Column(
                                              children: snapshot.data!
                                                  .map((timeSlot) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedTimeSlot =
                                                          timeSlot.time;
                                                    });
                                                  },
                                                  child: timeSlotWidget(
                                                      timeSlot.date.toString(),
                                                      timeSlot.month.toString(),
                                                      "موعد",
                                                      timeSlot.time,
                                                      selectedTimeSlot ==
                                                          timeSlot.time),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    MyBottun(
                                      color: Colors.black,
                                      title: 'حجز الموعد ',
                                      onPressed: () {
                                        // Proceed with booking logic
                                        if (selectedTimeSlot.isNotEmpty) {
                                          // Here you can add logic to book the selected time slot
                                          // For now, let's print the selected time slot
                                          print(
                                              "Selected time slot: $selectedTimeSlot");

                                          // Find the index of the selected clinic
                                          int selectedClinicIndex = snapshot
                                              .data!.docs
                                              .indexWhere((document) =>
                                                  document['doctorName'] ==
                                                      clinicData[
                                                          'doctorName'] &&
                                                  document['clinicName'] ==
                                                      clinicData['clinicName']);

                                          // Ensure the clinic is found
                                          if (selectedClinicIndex != -1) {
                                            // Get the selected clinic data
                                            Map<String, dynamic>
                                                selectedClinicData = snapshot
                                                        .data!
                                                        .docs[selectedClinicIndex]
                                                        .data()
                                                    as Map<String, dynamic>;

                                            // Navigate to the UpcomingSchedule screen with the selected clinic data
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpcomingSchedule(
                                                  doctorName:
                                                      selectedClinicData[
                                                          'doctorName'],
                                                  clinicName:
                                                      selectedClinicData[
                                                          'clinicName'],
                                                           month: widget.month,
                                                  selectedTimeSlot:
                                                      selectedTimeSlot, appointmentId: '',  getUpcomingAppointments: (appointmentList) {  }, 
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          // No time slot selected, provide a message
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'يرجى اختيار فترة زمنية أولاً'),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                        ),
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
              Navigator.pushNamed(context, PNavBarRoots.sr);
            },
          ),
        ),
      ]),
    );
  }

  Container timeSlotWidget(String date, String month, String slotType,
      String time, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: isSelected ? Color(0xffECF0F5) : Colors.transparent,
        border: isSelected
            ? Border.all(
                color: Color(0xffD5E0FA),
                width: 2,
              )
            : null,
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Aligning the row to the right
          children: <Widget>[
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
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: isSelected ? Color(0xffD5E0FA) : Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$date",
                    style: GoogleFonts.ibmPlexSansArabic(
                        color: isSelected
                            ? ColorPallete.secondaryColor
                            : Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "$month",
                    style: GoogleFonts.ibmPlexSansArabic(
                        color: isSelected
                            ? ColorPallete.secondaryColor
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
