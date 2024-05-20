import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta/screens/patient/pnavbar.dart';
import 'package:ta/screens/patient/schedule_screen.dart';
import 'package:ta/widgets/color_pallete.dart';

class UpcomingSchedule extends StatelessWidget {
  final String doctorName;
  final String clinicName;
  final String selectedTimeSlot;
  final String appointmentId;
  final Function(List<Map<String, dynamic>>) getUpcomingAppointments;
  final bool showConfirmationButton; // New parameter

  UpcomingSchedule({
    required this.doctorName,
    required this.clinicName,
    required this.selectedTimeSlot,
    required this.appointmentId,
    required this.getUpcomingAppointments,
    this.showConfirmationButton = true, required String month, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المواعيد القادمة'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text(
                        doctorName,
                        style: GoogleFonts.ibmPlexSansArabic(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 20,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        clinicName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        "عيادة تداوي في شارع الملك عبدالله",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "وقت الموعد",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        selectedTimeSlot,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "تاريخ الموعد",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      
                      subtitle: Text(
                        " $selectedTimeSlot",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            cancelAppointment(context, appointmentId);
                          },
                          child: Text('الغاء'),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF4F6FA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        if (showConfirmationButton) // Conditionally render confirmation button
                          ElevatedButton(
                            onPressed: () {
                              confirmAppointment(context);
                            },
                            child: Text('حسنا'),
                            style: ElevatedButton.styleFrom(
                              primary: ColorPallete.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirmAppointment(BuildContext context) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the user's email
      String? email = user.email;

      if (email != null) {
        // Add appointment details to Firestore with the user's email
        FirebaseFirestore.instance.collection('appointments').add({
          'userEmail': email, // Add user's email
          'doctorName': doctorName,
          'clinicName': clinicName,
          'selectedTimeSlot': selectedTimeSlot,
          // Add more fields as needed
        }).then((value) {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('تنبيه'),
                content: Text('تم تأكيد الموعد بنجاح'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      // Navigate to the schedule screen
                      navigateToScheduleScreen(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          ).then((_) {
            // Fetch upcoming appointments after confirmation and navigation
            fetchUpcomingAppointments();
          });
        }).catchError((error) {
          // Handle error
          print("فشل: $error");
          // Show error message or retry logic
        });
      } else {
        // Email is null, handle this case
      }
    } else {
      // User is not authenticated, handle this case
      // You might want to show a message or redirect to the login screen
    }
  }

void fetchUpcomingAppointments() async {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Get the user's email
    String? email = user.email;

    if (email != null) {
      FirebaseFirestore.instance
          .collection('appointments')
          .where('userEmail', isEqualTo: email) // Query appointments by user's email
          .get()
          .then((querySnapshot) {
        List<Map<String, dynamic>> upcomingAppointments = [];
        querySnapshot.docs.forEach((doc) {
          upcomingAppointments.add(doc.data());
        });
        print('Upcoming Appointments: $upcomingAppointments'); // Add this line for logging
        // Pass the upcoming appointments to the callback function
        getUpcomingAppointments(upcomingAppointments);
      }).catchError((error) {
        print("Failed to fetch upcoming appointments: $error");
      });
    } else {
      // Email is null, handle this case
      print('User email is null');
    }
  } else {
    // User is not authenticated, handle this case
    print('User is not authenticated');
  }
}


  void navigateToScheduleScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PNavBarRoots(
          clinicName: clinicName,
          doctorName: doctorName,
          selectedTimeSlot: selectedTimeSlot,
          appointmentId: 'appointmentId', firstName: '', // You might need to pass the appointment ID here
        ),
      ),
    );
  }

  void cancelAppointment(BuildContext context, String appointmentId) {
    // Delete the appointment from Firestore
    FirebaseFirestore.instance.collection('appointments').doc(appointmentId).delete()
        .then((value) {
      // Show cancellation confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تم إلغاء الموعد'),
            content: Text('تم إلغاء الموعد بنجاح.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    })
        .catchError((error) {
      // Handle error
      print("Failed to cancel appointment: $error");
      // Show error message or retry logic
    });
  }
}
