import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../All Functions Page/Functions.dart';
import '../BottomNavigator.dart';
import 'GetImage.dart';

class EditDoctorProfile extends StatefulWidget {
  const EditDoctorProfile({super.key});

  @override
  State<EditDoctorProfile> createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  final imageURL = FirebaseAuth.instance.currentUser?.photoURL;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController hospitalAddressController = TextEditingController();
  TextEditingController expertiseFieldController = TextEditingController();
  TextEditingController doctorLicenceController = TextEditingController();
  String userGender = "Male";

  Future<void> _submitForm() async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('user_list');
      await users.doc(userEmail).update({
        //'imageUrl': imageURL,
        'User Name': nameController.text,
        'Age': ageController.text,
        'Gender': userGender,
        'Address': addressController.text,
        'Hospital': hospitalController.text,
        'Hospital Address': hospitalAddressController.text,
        'Expertise Field': expertiseFieldController.text,
        'Doctor Licence': doctorLicenceController.text,
        'Profession': "Doctor",
        //'profession': _professionController.text,
        //'phone': _phoneController.text,
        //'location': _locationController.text,
        //'dob': _dobController.text,
        //'language': _languageController.text,
        //'joined': date,
      }).then((value) {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameController.text);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: const Text('Success'),
                    content: const Text("Personal information saved successfully!"),
                    actions: [
                      TextButton(
                          onPressed: () => newPage(const BottomNavigatorWidget(), context),
                          child: const Text('OK'))
                    ]));
      }).onError((error, stackTrace) {
        SnackBar(content: Text('Error: $error'));
      });
      //.catchError((error) => SnackBar(content: Text('Error: $error')));

      // Clear the form fields
      nameController.clear();
      ageController.clear();
      addressController.clear();
      hospitalController.clear();
      hospitalAddressController.clear();
      expertiseFieldController.clear();
      doctorLicenceController.clear();
    } catch (e) {
      setState(() => snackBar(e.toString(), context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        /*InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
        ),*/
        title: const Text('Complete Your Profile'),
        actions: const [],
        centerTitle: false,
        elevation: 5,
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 1,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                /// Profile Pic
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Container(
                    width: 80,
                    height: 80,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(imageURL!),

                  ),
                ),

                /// Change Photo Button
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: FloatingActionButton.extended(
                    onPressed: () => const GetImage(),
                    label: const Text("Change Photo"),
                  ),
                ),

                /// Form
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        /// Name
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Your Name',
                              hintText: 'Please enter your name...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Insert a Name";
                              } else {
                                return null;
                              }
                            },

                            ///validator: yourNameControllerValidator.asValidator(context),
                          ),
                        ),
                        /// Age
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: ageController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Your Age',
                              hintText: 'i.e. 24',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Insert a Age";
                              } else {
                                return null;
                              }
                            },

                            ///validator: yourAgeControllerValidator.asValidator(context),
                          ),
                        ),

                        /// Radio Button - Gender
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: Card(
                            color: Colors.white70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                                  child: Text('Your Birth Sex',
                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                        title: const Text('Male'),
                                        value: "Male",
                                        groupValue: userGender,
                                        onChanged: (value) => setState(() {
                                          userGender = 'Male';
                                        }),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                          title: const Text('Female'),
                                          value: "Female",
                                          groupValue: userGender,
                                          onChanged: (value) => setState(() {
                                                userGender = 'Female';
                                              })),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        /// Address
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            controller: addressController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              hintText: 'Please enter a address..',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == '') {
                                return "Insert a Address";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        /// Working Hospital
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: hospitalController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'In which hospital you are working?',
                              hintText: 'Please enter a name...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Insert a Hospital Name";
                              } else {
                                return null;
                              }
                            },

                            ///validator: yourNameControllerValidator.asValidator(context),
                          ),
                        ),
                        /// Hospital Address
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            controller: hospitalAddressController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Hospital Address',
                              hintText: 'Please enter a address..',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == '') {
                                return "Insert a Hospital Address";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        /// Expertise
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: expertiseFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Your Expertise Field',
                              hintText: 'Please enter expertise...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Insert a Expertise Field";
                              } else {
                                return null;
                              }
                            },

                            ///validator: yourNameControllerValidator.asValidator(context),
                          ),
                        ),
                        /// Licence
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: doctorLicenceController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "Your licence number",
                              hintText: 'Please enter a valid number...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Insert a valid number";
                              } else {
                                return null;
                              }
                            },

                            ///validator: yourNameControllerValidator.asValidator(context),
                          ),
                        ),
                      ],
                    )),

                /// Save Button
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                    elevation: 3,
                    label: const Text("Save Changes"),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
