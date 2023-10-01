import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/Pages/AppointmentsPage.dart';
import 'package:cancer_project/Pages/DoctorsPage.dart';
import 'package:cancer_project/Pages/HelpPage.dart';
import 'package:cancer_project/Pages/HistoryPage.dart';
import 'package:cancer_project/Pages/HospitalPage.dart';
import 'package:cancer_project/Pages/LifestylePage.dart';
import 'package:cancer_project/Settings/Drawer.dart';
import 'package:cancer_project/Pages/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ChatApp/ChatPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? userName = FirebaseAuth.instance.currentUser?.displayName;
  String? userImage = FirebaseAuth.instance.currentUser?.photoURL;
  //Color primary = Colors.lightBlueAccent;
  Color primary = Colors.black;
  Color secondary = Colors.blueAccent;
  Color black = Colors.black;
  Color white = Colors.white;
  Color back = Colors.black;
  Color front = Colors.black;

  @override
  Widget build(BuildContext context) {
    List widgetList = [
      FloatingActionButton.large(
          heroTag: '0011',
          onPressed: () => nextPage(const ChatPage(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Chat.png"), height: 60, width: 60),
            Text("Chats", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          heroTag: '0012',
          onPressed: () => nextPage(const HospitalPageWidget(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Hospital.png"), height: 60, width: 60),
            Text("Hospitals", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          heroTag: '0013',
          onPressed: () => nextPage(const DoctorsPageWidget(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Doctor.png"), height: 60, width: 60),
            Text("Doctors", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          heroTag: '0014',
          onPressed: () => nextPage(const AppointmentsPageWidget(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Appointments.png"), height: 60, width: 60),
            Text("Appointments", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          heroTag: '0015',
          onPressed: () => nextPage(const HistoryPage(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/History.png"), height: 60, width: 60),
            Text("History", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          heroTag: '0016',
          onPressed: () => nextPage(const LifestylePage(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Lifestyle.png"), height: 60, width: 60),
            Text("Lifestyle", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          heroTag: '0017',
          onPressed: () => nextPage(const HelpPageWidget(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Help.png"), height: 60, width: 60),
            Text("Help", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          heroTag: '0018',
          onPressed: () => nextPage(const ProfileWidget(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Profile.png"), height: 60, width: 60),
            Text("Profile", textAlign: TextAlign.center)
          ])),
    ];

    return SafeArea(
      child: MaterialApp(
        title: 'Cancer Hope',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //drawer: const DrawerWidget(),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                snap: false,
                pinned: true,
                floating: false,
                leading: IconButton(
                    onPressed: () => nextPage(const SafeArea(child: DrawerWidget()), context),
                    icon: const Icon(Icons.menu),
                    tooltip: 'Menu'),
                title: RichText(
                    softWrap: true,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Cancer',
                          style: TextStyle(
                              fontSize: 38,
                              fontFamily: GoogleFonts.outfit().fontFamily,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: ' Hope',
                          style: TextStyle(fontSize: 38, color: Color(0xFF016DF7), fontWeight: FontWeight.bold))
                    ])),
                flexibleSpace: const FlexibleSpaceBar(
                    background: ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      child: Image(
                        image: AssetImage('Assets/background_hill.webp'),
                        fit: BoxFit.fill,
                        opacity: AlwaysStoppedAnimation(60),
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      "We are here to heal",
                      style: TextStyle(fontSize: 16),
                    )),
                actions: [
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () => SystemNavigator.pop(),
                          child: const Row(children: [
                            Icon(Icons.exit_to_app, color: Colors.black),
                            SizedBox(width: 6),
                            Text('Exit')
                          ])),
                    ],
                  )
                ],
                //bottom: PreferredSize(preferredSize: Size.fromRadius(60), child: Text('data')),
                centerTitle: true,
                expandedHeight: 150,
                elevation: 20,
                shadowColor: Colors.deepPurple,
                shape: const ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
                //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,width: 5,strokeAlign: BorderSide.strokeAlignOutside)),
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.5)),
                //backgroundColor: Colors.deepPurpleAccent[100],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),

                        /// Profile
                        Card(
                          child: Container(
                            //decoration: const BoxDecoration(
                            //    image: DecorationImage(image: AssetImage("Assets/Back_1.jpg"), fit: BoxFit.cover)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        shape: BoxShape.circle,
                                        //border: Border.all(color: secondary, width: 2),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(80),
                                          child: CachedNetworkImage(
                                            imageUrl: '$userImage',
                                            //'https://images.unsplash.com/photo-1489980557514-251d61e3eeb6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTZ8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                                            fadeInDuration: const Duration(milliseconds: 500),
                                            fadeOutDuration: const Duration(milliseconds: 500),
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,
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
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text('Hello! $userName',
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          //fontFamily: GoogleFonts.outfit().fontFamily
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(),

                        /// Buttons
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widgetList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.purple[100],
                              margin: const EdgeInsets.all(8),
                              child: Center(
                                child: widgetList[index],
                              ),
                            );
                          },
                        ),
                        const Divider(),

                        /// Trailer row
                        const Image(image: AssetImage("Assets/Fight.png")),

                        /// Credit info
                        Center(
                          child: Text("Made By\nMd. Hasibul Hossain",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.outfit().fontFamily)),
                        )
                      ],
                    );
                  }
                  return null;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
