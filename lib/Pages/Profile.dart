import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancer_project/Auth/AuthTree.dart';
import 'package:cancer_project/Auth/ChangePassword.dart';
import 'package:cancer_project/Settings/EditPatientProfile.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ChatApp/UsersProfile.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> with TickerProviderStateMixin {
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    /// Background Image
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: primary,
                        image: const DecorationImage(
                            fit: BoxFit.cover, image: AssetImage("Assets/background_hill.webp")),
                      ),
                    ),

                    /// Profile Pic
                    Align(
                      alignment: const AlignmentDirectional(-1.1, 1.5),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 16),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: primary,
                            //color: FlutterFlowTheme.of(context).accent2,
                            shape: BoxShape.circle,
                            border: Border.all(
                                //color: secondary,
                                //width: 2,
                                ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CachedNetworkImage(
                                fadeInDuration: const Duration(milliseconds: 500),
                                fadeOutDuration: const Duration(milliseconds: 500),
                                imageUrl: '$userImage',
                                //'https://images.unsplash.com/photo-1489980557514-251d61e3eeb6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTZ8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),

              /// User Name
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Text('$userName',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.outfit().fontFamily)),
              ),

              /// User Email
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
                child: Text(
                  '$userEmail',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.outfit().fontFamily),
                  //style: FlutterFlowTheme.of(context).labelMedium,
                ),
              ),
              const SizedBox(height: 20),

              /// Additional
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                child: Text(
                  'Your Account',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.outfit().fontFamily),
                  //style: FlutterFlowTheme.of(context).labelMedium,
                ),
              ),

              /// Profile Details
              GestureDetector(
                onTap: () => nextPage(UsersProfile(userEmail!), context),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black,
                            //color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Profile Details',
                              style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                              //style: FlutterFlowTheme.of(context).labelLarge,
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                //color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Edit Profile
              GestureDetector(
                onTap: () => nextPage(const EditPatientProfile(), context),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Colors.black,
                            //color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                              //style: FlutterFlowTheme.of(context).labelLarge,
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                //color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Change Password
              GestureDetector(
                onTap: () => nextPage(const ChangePasswordWidget(), context),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.change_circle_outlined,
                            color: Colors.black,
                            //color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Change Password',
                              style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                              //style: FlutterFlowTheme.of(context).labelLarge,
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                //color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Delete Account
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Are You Sure?"),
                        content: const Text("This will delete all of your data and this account."),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance.collection("user_list").doc("$userEmail").delete();
                              FirebaseAuth.instance.currentUser!.delete();
                              //FirebaseAuth.instance.signOut();
                              //Navigator.of(context).pop();
                              newPage(const AuthTreeWidget(), context);
                              snackBar("Your account is deleted!", context);
                            },
                            child: const Text("Delete", style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.black,
                            //color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Delete Account',
                              style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                              //style: FlutterFlowTheme.of(context).labelLarge,
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                //color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Additional App Settings

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 0, 0),
                child: Text(
                  'App Settings',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.outfit().fontFamily),
                  //style: FlutterFlowTheme.of(context).labelMedium,
                ),
              ),

              /// Notification Settings

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: white,
                    //color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          color: black,
                          //color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Notification Settings',
                            style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),

                            //style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: const AlignmentDirectional(0.9, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: black,
                              //color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Support
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: white,
                    //color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.help_outline_rounded,
                          color: black,
                          //color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Support',
                            style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                            //style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: const AlignmentDirectional(0.9, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: black,
                              //color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Terms of Service
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: white,
                    //color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.privacy_tip_outlined,
                          color: black,
                          //color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Terms of Service',
                            style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),

                            //style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: const AlignmentDirectional(0.9, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: black,
                              //color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Logout Button
              Center(
                child: FloatingActionButton.extended(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      newPage(const AuthTreeWidget(), context);
                    },
                    label: const Text("  Log Out  "),
                    elevation: 5,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
              ),
              const SizedBox(height: 30),

              /*Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();

                      context.goNamedAuth('null', context.mounted);
                    },
                    text: 'Log Out',
                    options: FFButtonOptions(
                      width: 150,
                      height: 44,
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium,
                      elevation: 0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).lineColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation']!),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

/*
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 140,
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
*/
