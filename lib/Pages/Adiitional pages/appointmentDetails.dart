import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/Pages/Adiitional%20pages/Payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DoctorDetails.dart';

class AppointmentDetailsWidget extends StatefulWidget {
  const AppointmentDetailsWidget({super.key, required this.id, required this.email});
  final String email;
  final String id;
  @override
  State<AppointmentDetailsWidget> createState() => _AppointmentDetailsWidgetState();
}

class _AppointmentDetailsWidgetState extends State<AppointmentDetailsWidget> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: RichText(
            softWrap: true,
            text: const TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Appointments',
                  style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'Details',
                  style: TextStyle(fontSize: 24, color: Color(0xFF016DF7), fontWeight: FontWeight.bold))
            ])),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user_list')
              .doc(userEmail)
              .collection('Appointments')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data;
            String email = snapshot.data!['Email'];
            String name = snapshot.data!['Name'];
            String type = snapshot.data!['Type'];
            String problem = snapshot.data!['Problem'];
            //Timestamp getTime = snapshot.data!['Time'];
            //DateTime time = getTime.toDate();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                  child: Text('Type of Appointment', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
                  child: Text(type, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Text('What’s the problem?', style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
                  child: Text(problem, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 26, 20, 0),
                  child: Text('with', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('user_list').doc(widget.email).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      String email = snapshot.data.id;
                      String image = snapshot.data['imageUrl'];
                      String name = snapshot.data['User Name'];
                      return InkWell(
                        onTap: () => nextPage(DoctorDetailsWidget(email: email), context),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.86,
                            //height: 60,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 60,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(shape: BoxShape.circle),
                                      child: CachedNetworkImage(imageUrl: image, fit: BoxFit.cover)),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(name,
                                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 3),
                                        Text(email,
                                            style: const TextStyle(
                                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                  child: Text('Time', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 20, 30),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                        const Icon(Icons.calendar_today, color: Colors.white, size: 15),
                        const SizedBox(width: 5),
                        Text('${data!['Day']}, ${data['Date']}', style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 20),
                        const Icon(Icons.access_alarm, color: Colors.white, size: 17),
                        const SizedBox(width: 5),
                        Flexible(child: Text(data['Time'], style: const TextStyle(color: Colors.white)))
                      ])),
                  //child: Text('$time', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: () => nextPage(const PaymentWidget(), context),
                    label: const Text("Make Payment"),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context);
                      FirebaseFirestore.instance
                          .collection('user_list')
                          .doc(userEmail)
                          .collection('Appointments')
                          .doc(widget.id)
                          .delete();
                      FirebaseFirestore.instance
                          .collection('user_list')
                          .doc(widget.email)
                          .collection('Appointments')
                          .doc(widget.id)
                          .delete();
                    },
                    label: const Text("Cancel Appointment"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
