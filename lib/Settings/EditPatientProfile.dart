import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/BottomNavigator.dart';
import 'package:cancer_project/Settings/GetImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPatientProfile extends StatefulWidget {
  const EditPatientProfile({
    Key? key,
  }) : super(key: key);

  @override
  _EditPatientProfileState createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  final imageURL = FirebaseAuth.instance.currentUser?.photoURL;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController CancerNameController = TextEditingController();
  TextEditingController CancerStageController = TextEditingController();
  TextEditingController HospitalController = TextEditingController();
  TextEditingController HospitalAddressController = TextEditingController();
  TextEditingController DoctorNameController = TextEditingController();
  TextEditingController DoctorLicenceController = TextEditingController();
  String userSex = "Male";

  Future<void> _submitForm() async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('user_list');
      await users.doc(userEmail).update({
        //'imageUrl': imageURL,
        'User Name': NameController.text,
        'Age': AgeController.text,
        'Gender': userSex,
        'Address': AddressController.text,
        'Cancer Name': CancerNameController.text,
        'Cancer Stage': CancerStageController.text,
        'Hospital': HospitalController.text,
        'Hospital Address': HospitalAddressController.text,
        'Doctor Name': DoctorNameController.text,
        'Doctor Licence': DoctorLicenceController.text,
        //'profession': _professionController.text,
        //'phone': _phoneController.text,
        //'location': _locationController.text,
        //'dob': _dobController.text,
        //'language': _languageController.text,
        //'joined': date,
      }).then((value) {
        FirebaseAuth.instance.currentUser!.updateDisplayName(NameController.text);
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
      NameController.clear();
      AgeController.clear();
      AddressController.clear();
      CancerNameController.clear();
      CancerStageController.clear();
      HospitalController.clear();
      HospitalAddressController.clear();
      DoctorNameController.clear();
      DoctorLicenceController.clear();
    } catch (e) {
      setState(() => snackBar(e.toString(), context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                    onPressed: () => nextPage(const GetImage(), context),
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
                            controller: NameController,
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
                          ),
                        ),

                        /// Age
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: AgeController,
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
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == '') {
                                return "Insert a Age";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        /// Radio Button
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
                                        groupValue: userSex,
                                        onChanged: (value) => setState(() {
                                          userSex = "Male";
                                        }),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                          title: const Text('Female'),
                                          value: "Female",
                                          groupValue: userSex,
                                          onChanged: (value) => setState(() {
                                                userSex = "Female";
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
                            controller: AddressController,
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

                        /// Cancer Type
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: CancerNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Cancer Type',
                              hintText: 'Please enter a type...',
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
                                return "Insert a Cancer Type";
                              } else {
                                return null;
                              }
                            },

                            ///validator: yourNameControllerValidator.asValidator(context),
                          ),
                        ),

                        /// Cancer Stage
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: CancerStageController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Cancer Stage',
                              hintText: 'Please enter a stage...',
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
                                return "Insert a Stage";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        /// Admitted Hospital
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: HospitalController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'In which hospital you are admitted?',
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
                          ),
                        ),

                        /// Hospital address
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: HospitalAddressController,
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

                        /// Doctors Name
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: DoctorNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "Your Doctor's Name",
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
                                return "Insert a Doctor's Name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        /// Licence
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: DoctorLicenceController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "Doctor's licence number",
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
                          ),
                        ),
                      ],
                    )),

                /// Save Button
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      //if (_formKey.currentState!.validate()) {
                      _submitForm();
                      //}
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
