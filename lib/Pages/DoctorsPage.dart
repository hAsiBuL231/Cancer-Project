import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/Pages/Adiitional%20pages/DoctorDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorsPageWidget extends StatefulWidget {
  const DoctorsPageWidget({super.key});

  @override
  State<DoctorsPageWidget> createState() => _DoctorsPageWidgetState();
}

class _DoctorsPageWidgetState extends State<DoctorsPageWidget> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String searchText = '';
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            foregroundColor: Colors.black,
            title: RichText(
                softWrap: true,
                text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Doctors',
                      style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'List',
                      style: TextStyle(fontSize: 24, color: Color(0xFF016DF7), fontWeight: FontWeight.bold))
                ]))),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            child: Column(
              children: [
                /// Search Bar
                Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey.shade100))))),
                /// If data searched
                if (searchText != '')
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('user_list')
                        .where('User Name', isGreaterThanOrEqualTo: searchText)
                        .where('User Name', isLessThan: '${searchText}z')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No results found.'));
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 16),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            //var data = snapshot.data!.data();
                            //String image = data!['imageUrl'];
                            //String name = data['User Name'];
                            String email = snapshot.data!.docs[index].id;
                            String image = snapshot.data!.docs[index]['imageUrl'];
                            String name = snapshot.data!.docs[index]['User Name'];
                            String expertise = snapshot.data!.docs[index]['Expertise Field'];
                            String registered = snapshot.data!.docs[index]['Registered'];

                            //String hospital = snapshot.data.docs[index]['Hospital'];

                            if (image == '' || name == '' || expertise == '') return const SizedBox.shrink();
                            if (email == userEmail) return const SizedBox.shrink();
                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 5,
                              margin: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: image,
                                      imageBuilder: (context, imageProvider) => CircleAvatar(
                                          backgroundImage: imageProvider,
                                          maxRadius: 25,
                                          backgroundColor: Colors.blue),
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const CircleAvatar(
                                          maxRadius: 25,
                                          backgroundColor: Colors.blue,
                                          child: Icon(Icons.account_circle, size: 50)),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Row(
                                              children: [
                                                Text(name,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w500, fontSize: 20)),
                                                if (registered == 'true')
                                                  const Icon(Icons.verified, color: Colors.blue)
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Text("Expertise: $expertise"),
                                          ]),
                                          IconButton(
                                              onPressed: () =>
                                                  nextPage(DoctorDetailsWidget(email: email), context),
                                              icon: const Icon(Icons.navigate_next_outlined))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                /// if search is empty
                if (searchText == '')
                  StreamBuilder(
                      //.orderBy('Age', descending: true)
                      stream: FirebaseFirestore.instance
                          .collection('user_list')
                          .where("User", isEqualTo: "Doctor")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.length < 1) {
                            return const Padding(
                                padding: EdgeInsets.all(40),
                                child: Center(child: Text('No User!', style: TextStyle(fontSize: 20))));
                          }
                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 16),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                //var data = snapshot.data!.data();
                                //String image = data!['imageUrl'];
                                //String name = data['User Name'];
                                String email = snapshot.data.docs[index].id;
                                String image = snapshot.data.docs[index]['imageUrl'];
                                String name = snapshot.data.docs[index]['User Name'];
                                String expertise = snapshot.data.docs[index]['Expertise Field'];
                                String registered = snapshot.data.docs[index]['Registered'];

                                //String hospital = snapshot.data.docs[index]['Hospital'];

                                if (image == '' || name == '' || expertise == '') return const SizedBox.shrink();
                                if (email == userEmail) return const SizedBox.shrink();
                                return Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  elevation: 5,
                                  margin: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: image,
                                          imageBuilder: (context, imageProvider) => CircleAvatar(
                                              backgroundImage: imageProvider,
                                              maxRadius: 25,
                                              backgroundColor: Colors.blue),
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => const CircleAvatar(
                                              maxRadius: 25,
                                              backgroundColor: Colors.blue,
                                              child: Icon(Icons.account_circle, size: 50)),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Row(
                                                  children: [
                                                    Text(name,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w500, fontSize: 20)),
                                                    if (registered == 'true')
                                                      const Icon(Icons.verified, color: Colors.blue)
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Text("Expertise: $expertise"),
                                              ]),
                                              IconButton(
                                                  onPressed: () =>
                                                      nextPage(DoctorDetailsWidget(email: email), context),
                                                  icon: const Icon(Icons.navigate_next_outlined))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        return const Padding(
                            padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
