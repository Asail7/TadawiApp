import 'package:flutter/material.dart';
/*
class TimeSlot {
  final DateTime date;
  final String time;

  TimeSlot(this.date, this.time);
}

class TimeSlotsWidget extends StatelessWidget {
  final List<TimeSlot> timeSlots;
  final Function(TimeSlot?) onTimeSlotSelected;
  TimeSlot? selectedTimeSlot;

  TimeSlotsWidget({
    required this.timeSlots,
    required this.onTimeSlotSelected,
    this.selectedTimeSlot,
  }) : super(key: ValueKey('TimeSlotsWidget'));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
          onTap: () {
  // Toggle the selection of the time slot
  if (selectedTimeSlot == timeSlots[index]) {
    // Deselect the time slot if it's already selected
    onTimeSlotSelected(null);
  } else {
    // Select the time slot if it's not selected
    onTimeSlotSelected(timeSlots[index]);
  }
},

            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: selectedTimeSlot == timeSlots[index] ? Colors.green : Colors.white,
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
                width: MediaQuery.of(context).size.width / 1.4,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Date: ${timeSlots[index].date.day}/${timeSlots[index].date.month}/${timeSlots[index].date.year} - Time: ${timeSlots[index].time}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      child: Text(
                        timeSlots[index].time,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (selectedTimeSlot == timeSlots[index])
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Selected:${timeSlots[index].date.toString()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}*/