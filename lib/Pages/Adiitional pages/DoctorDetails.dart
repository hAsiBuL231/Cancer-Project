import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/Pages/Adiitional%20pages/bookAppoinment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../ChatApp/ConversationPage.dart';

class DoctorDetailsWidget extends StatefulWidget {
  const DoctorDetailsWidget({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _DoctorDetailsWidgetState createState() => _DoctorDetailsWidgetState();
}

class _DoctorDetailsWidgetState extends State<DoctorDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          //backgroundColor: const Color(0xFFF1F4F8),
          title: const Text('Details'),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('user_list').doc(widget.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              String email = snapshot.data.id;
              String image = snapshot.data['imageUrl'];
              String name = snapshot.data['User Name'];
              String expertise = snapshot.data['Expertise Field'];
              String hospital = snapshot.data['Hospital'];
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        imageBuilder: (context, imageProvider) => Image.network(image,
                            //'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZG9jb3RyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                            width: double.infinity,
                            //height: 200,
                            fit: BoxFit.cover),
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.network(
                            "https://www.freepik.com/free-vector/doctors-concept-illustration_7191136.htm#query=doctor&position=14&from_view=search&track=sph",
                            width: double.infinity,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(expertise),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                              child: Text(name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            ),
                            Text(hospital),
                            /*Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  if (index == 4)
                                    return const SizedBox(height: 10,
                                        width: 10, child: Icon(Icons.star_rounded, color: Colors.grey));
                                  return const SizedBox(height: 10,
                                      width: 10, child: Icon(Icons.star_rounded, color: Color(0xFFF3A743)));
                                },
                                shrinkWrap: true,
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),*/
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE0E3E7),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () =>
                                            nextPage(ConversationPage(email: email, imageUrl: image), context),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                              child: Icon(
                                                Icons.chat_bubble_rounded,
                                                color: Color(0xFF4B39EF),
                                                size: 24,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
                                              child: Text('Chat'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 100,
                                      child: VerticalDivider(
                                        thickness: 1,
                                        indent: 12,
                                        endIndent: 12,
                                        color: Color(0xFFE0E3E7),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                            child: Icon(
                                              Icons.call_rounded,
                                              color: Color(0xFF4B39EF),
                                              size: 24,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
                                            child: Text('Call'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Align(
                              alignment: AlignmentDirectional(-1.00, 0.00),
                              child: Text('Doctor Bio', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.00, 0.00),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                                child: Text(
                                  '$name is a board-certified internal medicine specialist with over 15 years of experience treating patients in both hospital and private practice settings. She is passionate about preventive care and dedicated to providing her patients with the highest level of personalized medical attention, while staying updated on the latest advancements in her field.',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: FloatingActionButton.extended(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    barrierColor: const Color(0x00000000),
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: MediaQuery.viewInsetsOf(context),
                                          child: SizedBox(
                                            height: MediaQuery.sizeOf(context).height * 1,
                                            child: BookAppointmentWidget(email: email, name: name),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => setState(() {}));
                                },

                                //{
                                //   nextPage(BookAppointmentWidget(email: email, name: name), context);
                                // },
                                backgroundColor: const Color(0xFF4B39EF),
                                label: const Text('Book Appointment'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
