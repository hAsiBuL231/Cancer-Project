import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/BottomNavigator.dart';
import 'package:cancer_project/Pages/Adiitional%20pages/appointmentDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../All Functions Page/datetime_converted.dart';
import 'Adiitional pages/registeredDoctorList.dart';

class AppointmentsPageWidget extends StatefulWidget {
  const AppointmentsPageWidget({super.key});

  @override
  State<AppointmentsPageWidget> createState() => _AppointmentsPageWidgetState();
}

class _AppointmentsPageWidgetState extends State<AppointmentsPageWidget> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => newPage(const BottomNavigatorWidget(), context),
        ),
        title: RichText(
            softWrap: true,
            text: const TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'My', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'Appointments',
                  style: TextStyle(fontSize: 24, color: Color(0xFF016DF7), fontWeight: FontWeight.bold))
            ])),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => nextPage(const RegisteredDoctorsPageWidget(), context), child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user_list")
                .doc(userEmail)
                .collection("Appointments")
                .orderBy('Date')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: Text('No Appointments!', style: TextStyle(fontSize: 20))));
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    String id = snapshot.data!.docs[index].id;
                    String email = snapshot.data!.docs[index]['Email'];
                    String name = snapshot.data!.docs[index]['Name'];
                    String type = snapshot.data!.docs[index]['Type'];
                    String getTime = snapshot.data!.docs[index]['Date'];
                    DateTime parsedDate1 = parseDateString(getTime);

                    if (parsedDate1.isBefore(DateTime.now())) return const SizedBox.shrink();

                    return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(type, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                IconButton(
                                    onPressed: () =>
                                        nextPage(AppointmentDetailsWidget(id: id, email: email), context),
                                    icon: const Icon(Icons.navigate_next, size: 40))
                              ]),
                              Text("for $name", style: const TextStyle(color: Colors.orange, fontSize: 16)),
                              const SizedBox(height: 6),
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                    const Icon(Icons.calendar_today, color: Colors.white, size: 15),
                                    const SizedBox(width: 5),
                                    Text('${data['Day']}, ${data['Date']}',
                                        style: const TextStyle(color: Colors.white)),
                                    const SizedBox(width: 20),
                                    const Icon(Icons.access_alarm, color: Colors.white, size: 17),
                                    const SizedBox(width: 5),
                                    Flexible(
                                        child: Text(data['Time'], style: const TextStyle(color: Colors.white)))
                                  ])),
                              //Text('$time'),
                            ])));
                  },
                );
              }
              return const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
            },
          ),
        ),
      ),
    );
  }
}
