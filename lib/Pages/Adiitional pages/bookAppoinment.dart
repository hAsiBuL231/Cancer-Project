/// OLD CODE

import 'dart:ui';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/Pages/Adiitional%20pages/calenderAndTime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BookAppointmentWidget extends StatefulWidget {
  const BookAppointmentWidget({super.key, required this.email, required this.name});
  final String email;
  final String name;
  @override
  State<BookAppointmentWidget> createState() => _BookAppointmentWidgetState();
}

class _BookAppointmentWidgetState extends State<BookAppointmentWidget> {
  TextEditingController nameController = TextEditingController();
  String appointmentType = "Doctors Visit";
  TextEditingController problemController = TextEditingController();
  //DateTime? pickedTime = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: Color(0xD60E151B)),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //const SizedBox(height: 300),
                //Container(height: MediaQuery.of(context).size.height - 580),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  //height: 570,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 3,
                          indent: 150,
                          endIndent: 150,
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text('Book Appointment',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(
                              'Fill out the information below in order to book your appointment with our office.',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Text('Emails will be sent to:'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                          child:
                              Text(widget.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Text('Appointment Time:'),
                        ),
                        const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                            child: Text('4:00 PM to 8:00 PM',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),

                        /// Form
                        Form(
                          key: _formKey,
                          child: Column(children: [
                            /// Booking for
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                controller: nameController,
                                obscureText: false,
                                decoration: const InputDecoration(
                                    labelText: 'Booking For',
                                    hintText: "Insert a name",
                                    filled: true,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                                    //contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                                    ),
                                validator: (value) {
                                  if (value == '') {
                                    return 'Insert name';
                                  }
                                  return null;
                                },
                              ).animate(autoPlay: true, effects: [
                                FadeEffect(
                                    curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: 0, end: 1),
                                MoveEffect(
                                    curve: Curves.easeInOut,
                                    delay: 0.ms,
                                    duration: 600.ms,
                                    begin: const Offset(0, 9),
                                    end: const Offset(0, 0)),
                                ScaleEffect(
                                    curve: Curves.easeInOut,
                                    delay: 0.ms,
                                    duration: 600.ms,
                                    begin: const Offset(1, 0),
                                    end: const Offset(1, 1))
                              ]),
                            ),

                            /// Types of appointment
                            Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(6, 16, 6, 6),
                                child: DropdownButton(
                                  value: appointmentType,
                                  items: const [
                                    DropdownMenuItem(value: 'Doctors Visit', child: Text('Doctors Visit')),
                                    DropdownMenuItem(value: 'Routine Checkup', child: Text('Routine Checkup')),
                                    DropdownMenuItem(value: 'Scan/Update', child: Text('Scan/Update')),
                                  ],
                                  onChanged: (value) => setState(() => appointmentType = value!),
                                  hint: const Text('Type of Appointment'),
                                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 15),
                                  isExpanded: true,
                                  focusColor: Colors.grey,
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(20),
                                ).animate(autoPlay: true, effects: [
                                  FadeEffect(
                                      curve: Curves.easeInOut, delay: 40.ms, duration: 600.ms, begin: 0, end: 1),
                                  MoveEffect(
                                      curve: Curves.easeInOut,
                                      delay: 40.ms,
                                      duration: 600.ms,
                                      begin: const Offset(0, 20),
                                      end: const Offset(0, 0)),
                                  ScaleEffect(
                                      curve: Curves.easeInOut,
                                      delay: 40.ms,
                                      duration: 600.ms,
                                      begin: const Offset(1, 0),
                                      end: const Offset(1, 1))
                                ])),

                            /// Problem box
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                controller: problemController,
                                obscureText: false,
                                decoration: const InputDecoration(
                                    labelText: 'What\'s the problem?',
                                    hintText: "Inert the problem",
                                    filled: true,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                                    //contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                                    ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Insert problem';
                                  }
                                  return null;
                                },
                              ).animate(autoPlay: true, effects: [
                                FadeEffect(
                                    curve: Curves.easeInOut, delay: 60.ms, duration: 600.ms, begin: 0, end: 1),
                                MoveEffect(
                                    curve: Curves.easeInOut,
                                    delay: 60.ms,
                                    duration: 600.ms,
                                    begin: const Offset(0, 30),
                                    end: const Offset(0, 0)),
                                ScaleEffect(
                                    curve: Curves.easeInOut,
                                    delay: 60.ms,
                                    duration: 600.ms,
                                    begin: const Offset(1, 0),
                                    end: const Offset(1, 1))
                              ]),
                            ),

                            /// Date
                            /*
                            Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    DateTime? date = await DatePicker.showDateTimePicker(
                                      context,
                                      currentTime: DateTime.now(),
                                      maxTime: DateTime(2050, 6, 7),
                                      minTime: DateTime(2023, 3, 5),
                                    );
                                    setState(() {
                                      pickedTime = date;
                                    });
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.9,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                                  child: Text('Choose Date & Time'),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 0, 0),
                                                  child: Text('$pickedTime'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                            child: Icon(Icons.date_range_outlined, size: 20),
                                            /*IconButton(
                                                  icon: const Icon(Icons.date_range_outlined, size: 20),
                                                  onPressed: () {
                                                    print('IconButton pressed ...');
                                                  }),*/
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).animate(autoPlay: true, effects: [
                                  FadeEffect(
                                      curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: 0, end: 1),
                                  MoveEffect(
                                      curve: Curves.easeInOut,
                                      delay: 0.ms,
                                      duration: 600.ms,
                                      begin: const Offset(0, 90),
                                      end: const Offset(0, 0)),
                                  ScaleEffect(
                                      curve: Curves.easeInOut,
                                      delay: 0.ms,
                                      duration: 600.ms,
                                      begin: const Offset(1, 0),
                                      end: const Offset(1, 1))
                                ])),
                      */
                          ]),
                        ),

                        /// Buttons
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FloatingActionButton.extended(
                                  onPressed: () => Navigator.pop(context),
                                  label: const Text("Cancel"),
                                ).animate(autoPlay: true, effects: [
                                  FadeEffect(
                                      curve: Curves.bounceOut, delay: 150.ms, duration: 600.ms, begin: 0, end: 1),
                                  MoveEffect(
                                      curve: Curves.bounceOut,
                                      delay: 150.ms,
                                      duration: 600.ms,
                                      begin: const Offset(0, 20),
                                      end: const Offset(0, 0)),
                                  ScaleEffect(
                                      curve: Curves.bounceOut,
                                      delay: 150.ms,
                                      duration: 600.ms,
                                      begin: const Offset(1, 0),
                                      end: const Offset(1, 1))
                                ]),
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      //Navigator.pop(context);
                                      nextPage(
                                          CalendarAndTimeWidget(
                                              email: widget.email,
                                              name: widget.name,
                                              type: appointmentType,
                                              problem: problemController.text),
                                          context);
                                    }
                                  },
                                  label: const Text("Next"),
                                ).animate(autoPlay: true, effects: [
                                  FadeEffect(
                                      curve: Curves.bounceOut, delay: 150.ms, duration: 600.ms, begin: 0, end: 1),
                                  MoveEffect(
                                      curve: Curves.bounceOut,
                                      delay: 150.ms,
                                      duration: 600.ms,
                                      begin: const Offset(0, 20),
                                      end: const Offset(0, 0)),
                                  ScaleEffect(
                                      curve: Curves.bounceOut,
                                      delay: 150.ms,
                                      duration: 600.ms,
                                      begin: const Offset(1, 0),
                                      end: const Offset(1, 1))
                                ]),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
