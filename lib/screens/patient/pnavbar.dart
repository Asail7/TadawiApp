import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ta/screens/patient/pcommunication.dart';
import 'package:ta/screens/patient/phome.dart';
import 'package:ta/screens/patient/schedule_screen.dart';
import 'package:ta/screens/patient/settings_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta/widgets/color_pallete.dart';
import 'package:ta/widgets/upcoming_schedule.dart';

class PNavBarRoots extends StatefulWidget {
  static const String sr = 'pnavpar';
  final String firstName;
  final String clinicName;
  final String doctorName;
  final String selectedTimeSlot;
    final String appointmentId;

  PNavBarRoots({
    required this.firstName,
    required this.clinicName,
    required this.doctorName,
    required this.selectedTimeSlot, 
    required this.appointmentId,
  });

  @override
  State<PNavBarRoots> createState() => _PNavBarRootsState();
}

class _PNavBarRootsState extends State<PNavBarRoots> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      PHomeScreen(),
      CommuPat(),
      PScheduleScreen(
        clinicName: widget.clinicName,
        doctorName: widget.doctorName,
        selectedTimeSlot: widget.selectedTimeSlot, 
         appointmentId: widget.appointmentId,

      ),
      PSettingScreen(userId: FirebaseAuth.instance.currentUser!.uid),
    
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserFirstName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: _screens[_selectedIndex],
            bottomNavigationBar: Container(
              height: 80,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: ColorPallete.secondaryColor,
                unselectedItemColor: Colors.black26,
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: "الرئيسية"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.email,
                      ),
                      label: "تواصل"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month_outlined),
                      label: "المواعيد"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "الاعدادات"),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> _getUserFirstName() async {
    String firstName = '';
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('patient').doc(uid).get();

      if (userSnapshot.exists) {
        // Explicitly cast data() to Map<String, dynamic>
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        // Check if the field exists before accessing it
        if (userData != null && userData.containsKey('first name')) {
          firstName = userData['first name'] as String;
        } else {
          print('Field "first name" does not exist in the document.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }

    return firstName;
  }
}
