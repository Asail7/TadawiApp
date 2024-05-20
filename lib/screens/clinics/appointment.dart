/*import 'package:flutter/material.dart';
import 'package:ta/widgets/time_slot.dart';
class Appointment extends StatelessWidget {
  final String clinicName;
  final String doctorName;
  final TimeSlot selectedTimeSlot;

  Appointment({
    required this.clinicName,
    required this.doctorName,
    required this.selectedTimeSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Confirmation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Clinic: $clinicName"),
            Text("Doctor: $doctorName"),
            Text("Date: ${selectedTimeSlot.date}"),
            Text("Time: ${selectedTimeSlot.time}"),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}*/