import 'package:cloud_firestore/cloud_firestore.dart';

// Define TimeSlot class
class TimeSlot {
  final String date;
  final String month;
  final String time;

  TimeSlot({
    required this.date,
    required this.month,
    required this.time,
  });
}

// Define FirestoreService class
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<TimeSlot>> getTimeSlotsForClinic(String clinicId) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('time_slots')
          .where('clinicId', isEqualTo: clinicId)
          .get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TimeSlot(
          date: data['date'],
          month: data['month'],
          time: data['time'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching time slots: $e');
      return [];
    }
  }
}
