import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/Pages/HistoryPage.dart';
import 'package:cancer_project/Pages/LifestylePage.dart';
import 'package:cancer_project/Settings/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ChatApp/ChatPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color primary = Colors.lightBlueAccent;
  Color secondary = Colors.blueAccent;
  Color black = Colors.black;
  Color white = Colors.white;
  Color back = Colors.black;
  Color front = Colors.black;

  @override
  Widget build(BuildContext context) {
    List widgetList = [
      FloatingActionButton.large(
          onPressed: () => nextPage(const ChatPage(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Chat.png"), height: 60, width: 60),
            Text("Chat", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          onPressed: () {},
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Help.png"), height: 60, width: 60),
            Text("Help", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          onPressed: () {},
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Hospital.png"), height: 60, width: 60),
            Text("Hospitals", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          onPressed: () => nextPage(const HistoryPage(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/History.png"), height: 60, width: 60),
            Text("History", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          onPressed: () => nextPage(const LifestylePage(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Lifestyle.png"), height: 60, width: 60),
            Text("Lifestyle", textAlign: TextAlign.center)
          ])),
      FloatingActionButton.large(
          onPressed: () => nextPage(const ProfileWidget(), context),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage("Assets/Profile.png"), height: 60, width: 60),
            Text("Profile", textAlign: TextAlign.center)
          ]))
    ];

    return SafeArea(
      child: MaterialApp(
        title: 'Cancer Project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                snap: false,
                pinned: false,
                floating: false,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  tooltip: 'Menu',
                  onPressed: () {},
                ),
                title: Text(
                  "Cancer Project",
                  style: TextStyle(
                      fontSize: 38, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.outfit().fontFamily),
                ),
                flexibleSpace: const FlexibleSpaceBar(
                    background: Image(image: AssetImage('Assets/background_hill.webp'), fit: BoxFit.fill),
                    centerTitle: true,
                    title: Text(
                      "We are here to heal",
                      style: TextStyle(fontSize: 18),
                    )),
                expandedHeight: 150,
                elevation: 20,
                shadowColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.deepPurpleAccent[100],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Card(
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage("Assets/Back_1.jpg"), fit: BoxFit.cover)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: secondary, width: 2),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            fadeInDuration: const Duration(milliseconds: 500),
                                            fadeOutDuration: const Duration(milliseconds: 500),
                                            imageUrl:
                                                'https://images.unsplash.com/photo-1489980557514-251d61e3eeb6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTZ8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text('Hello! Andrew D.',
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: GoogleFonts.outfit().fontFamily))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
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
                        const Image(image: AssetImage("Assets/Fight.png")),
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
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
