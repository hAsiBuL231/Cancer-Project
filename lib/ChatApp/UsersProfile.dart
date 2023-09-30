import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersProfile extends StatelessWidget {
  const UsersProfile(this.email, {super.key});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user_list').doc(email).snapshots(),
        builder: (context, snapshot) {
          String name = 'Name';
          String image = 'image';
          Map map = Map();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            name = data!['User Name'];
            image = data['imageUrl'];
            //data['imageUrl'] = 'image';
            //if(data['User']=='Doctor')
            map = data;
            //map.remove("Hospital");
            map.removeWhere((key, value) {
              return key == "User" || key == "User Name" || key == "imageUrl";
            });
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: CachedNetworkImage(
                            fadeInDuration: const Duration(milliseconds: 500),
                            fadeOutDuration: const Duration(milliseconds: 500),
                            imageUrl: image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                                backgroundImage: imageProvider, maxRadius: 25, backgroundColor: Colors.blue),
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.account_circle, size: 50)),
                          ),
                        ),

                        //child: ClipRRect(
                        //    borderRadius: BorderRadius.circular(80),
                        //    child: Image.network(image, width: 100, height: 100, fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 6),
                    child: Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Text(email),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: data.keys
                          .map((key) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //if(key=='User')
                                      Text('$key: ',
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      Text(data[key]!, style: const TextStyle(fontSize: 18, color: Colors.blue))
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),

                  /*
                  SingleChildScrollView(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      map.forEach((key, value) {
                        Card(
                          child: Text('$key: $value'),
                        );
                      });
                      return null;
                    },
                  )),
                  const SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                                child: Text('Settings'),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                      child: Icon(
                                        Icons.work_outline,
                                        color: Color(0xFF57636C),
                                        size: 24,
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                      child: Text('Phone Number', textAlign: TextAlign.start),
                                    )),
                                    Text('Add Number', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                      child: Icon(
                                        Icons.language_rounded,
                                        color: Color(0xFF57636C),
                                        size: 24,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                        child: Text('Language', textAlign: TextAlign.start),
                                      ),
                                    ),
                                    Text('English (eng)', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                        child: Icon(Icons.money_rounded, color: Color(0xFF57636C), size: 24)),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                      child: Text('Currency', textAlign: TextAlign.start),
                                    )),
                                    Text('US Dollar (\$)', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                      child: Icon(
                                        Icons.edit,
                                        color: Color(0xFF57636C),
                                        size: 24,
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                      child: Text('Profile Settings', textAlign: TextAlign.start),
                                    )),
                                    Text('Edit Profile', textAlign: TextAlign.center)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                        child:
                                            Icon(Icons.notifications_active, color: Color(0xFF57636C), size: 24)),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                      child: Text('Notification Settings', textAlign: TextAlign.start),
                                    )),
                                    Icon(Icons.chevron_right_rounded, color: Color(0xFF57636C), size: 24),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                        child: Icon(Icons.login_rounded, color: Color(0xFF57636C), size: 24)),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                      child: Text('Log out of account', textAlign: TextAlign.start),
                                    )),
                                    Text('Log Out?', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  */
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
