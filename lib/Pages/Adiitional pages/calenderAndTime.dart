import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/Pages/AppointmentsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../All Functions Page/datetime_converted.dart';

class CalendarAndTimeWidget extends StatefulWidget {
  const CalendarAndTimeWidget(
      {Key? key, required this.email, required this.name, required this.type, required this.problem})
      : super(key: key);
  final String email;
  final String name;
  final String type;
  final String problem;

  @override
  State<CalendarAndTimeWidget> createState() => _CalendarAndTimeWidgetState();
}

class _CalendarAndTimeWidgetState extends State<CalendarAndTimeWidget> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  bool isLoading = false;

  bookAppointment(date, day, index) async {
    var user = FirebaseFirestore.instance.collection('user_list').doc(userEmail).collection('Appointments');
    var doctor = FirebaseFirestore.instance.collection('user_list').doc(widget.email).collection('Appointments');

    int hour = (4 + (index / 12)).toInt();
    int minuit = ((index % 12) * 5);

    String id = '';
    await user.add({
      "Email": widget.email,
      "Name": widget.name,
      "Type": widget.type,
      "Problem": widget.problem,
      "Date": date,
      "Day": day,
      "Time": '$hour:$minuit PM',
      //"DateTime": currentDay,
    }).then((value) => id = value.id);

    await doctor.doc(id).set({
      'Email': userEmail,
      "Name": widget.name,
      "Type": widget.type,
      "Problem": widget.problem,
      "Date": date,
      "Day": day,
      "Time": '$hour:$minuit PM',
      //"DateTime": currentDay,
    });
  }

  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  //bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    //final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          _tableCalendar(),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Center(
                  child: Text('Select Consultation Date',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))),
          if (_isWeekend)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              alignment: Alignment.center,
              child: const Text('Weekend is not available, please select another date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          if (!isLoading)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: FloatingActionButton.extended(
                label: const Text('Make Appointment'),
                onPressed: _dateSelected
                    ? () async {
                        setState(() => isLoading = true);

                        //convert date/day/time into string first
                        final getDate = DateConverted.getDate(_currentDay);
                        final getDay = DateConverted.getDay(_currentDay.weekday);
                        //final getTime = DateConverted.getTime(_currentIndex!);

                        int index = 0;
                        await FirebaseFirestore.instance
                            .collection('user_list')
                            .doc(widget.email)
                            .collection('Appointments')
                            .where("Date", isEqualTo: getDate)
                            .count()
                            .get()
                            .then((value) {
                          setState(() {
                            index = value.count;
                          });
                        });
                        if (index > 48) {
                          snackBar('Appointment for this day is full. Try for the next day.', context);
                          setState(() => isLoading = false);
                          return;
                        }

                        await bookAppointment(getDate, getDay, index);
                        snackBar('Appointment booking successful.', context);
                        setState(() => isLoading = false);
                        nextPage(const AppointmentsPageWidget(), context);
                      }
                    : () {
                        snackBar('Please Select a Date', context);
                      },
                //disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
        ]),
      ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      //DateTime.now().add(const Duration(days: 50)),
      //DateTime(2023, 12, 31),
      lastDay: DateTime.now().add(const Duration(days: 7)),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == 5 || selectedDay.weekday == 6) {
            _isWeekend = true;
            //_timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}
